/*
class AuthenticationManager {
    private let log = ActivityLog();
    private let cache = FileCache();
    private let monitor = AttackMonitor();
    
    func authenticate(user:String, pass:String) -> Bool {
        var result = false;
        if (user == "bob" && pass == "secret") {
            result = true;
            println("User \(user) is authenticated");
            // call system components
            log.logActivity("Authenticated \(user)");
            cache.loadFiles(user);
            monitor.monitorSuspiciousActivity = false;
        } else {
            println("Failed authentication attempt");
            // call system components
            log.logActivity("Failed authentication: \(user)");
            monitor.monitorSuspiciousActivity = true;
        }
        return result;
    }
}
*/

//class AuthenticationManager : SubjectBase {
class AuthenticationManager : ShortLivedSubject {
    
    func authenticate(user:String, pass:String) -> Bool {
        var nType = NotificationTypes.AUTH_FAIL;
        if (user == "bob" && pass == "secret") {
            nType = NotificationTypes.AUTH_SUCCESS;
            println("User \(user) is authenticated");
        } else {
            println("Failed authentication attempt");
        }
        //sendNotification(user, success:result);
        sendNotification(Notification(type:nType, data:user));
        return nType == NotificationTypes.AUTH_SUCCESS;
    }
}
