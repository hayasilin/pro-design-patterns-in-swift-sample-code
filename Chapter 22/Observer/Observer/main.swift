//let monitor = AttackMonitor();
// create meta observer
let monitor = AttackMonitor();
MetaSubject.sharedInstance.addObservers(monitor);

let log = ActivityLog();
let cache = FileCache();

let authM = AuthenticationManager();
//authM.addObservers(log, cache, monitor);
authM.addObservers(log, cache);

authM.authenticate("bob", pass: "secret");
println("-----");
authM.authenticate("joe", pass: "shhh");

