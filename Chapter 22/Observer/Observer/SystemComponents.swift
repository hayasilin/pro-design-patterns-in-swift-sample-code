class ActivityLog : Observer {
    /*
    func notify(user:String, success:Bool) {
        println("Auth request for \(user). Success: \(success)");
    }
    */
    
    func notify(notification:Notification) {
        println("Auth request for \(notification.type.rawValue). Success: \(notification.data!)");
    }
    
    func logActivity(activity:String) {
        println("Log: \(activity)");
    }
}

class FileCache : Observer {
    /*
    func notify(user:String, success:Bool) {
        if (success) {
            loadFiles(user);
        }
    }
    */

    func notify(notification:Notification) {
        /*
        if (notification.type == NotificationTypes.AUTH_SUCCESS) {
            loadFiles(notification.data! as! String);
        }
        */
        if let authNotification = notification as? AuthenticationNotification {
            if (authNotification.requestSuccessed && authNotification.userName != nil) {
                loadFiles(authNotification.userName!);
            }
        }
    }

    func loadFiles(user:String) {
        println("Load files for \(user)");
    }
}

//class AttackMonitor : Observer {
class AttackMonitor : MetaObserver {
    /*
    func notify(user:String, success:Bool) {
        monitorSuspiciousActivity = !success;
    }
    */
    
    func notifySubjectCreated(subject:Subject) {
        if (subject is AuthenticationManager) {
            subject.addObservers(self);
        }
    }
    
    func notifySubjectDestroyed(subject:Subject) {
        subject.removeObserver(self);
    }

    func notify(notification:Notification) {
        monitorSuspiciousActivity = (notification.type == NotificationTypes.AUTH_FAIL);
    }

    var monitorSuspiciousActivity: Bool = false {
        didSet {
            println("Monitoring for attack: \(monitorSuspiciousActivity)");
        }
    }
}
