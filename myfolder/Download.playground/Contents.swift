import Cocoa

class Download : NSObject , URLSessionDownloadDelegate {
    static var id = 0
    static var nameId = 0
    var queue = OperationQueue()
    var dowloading = [Int : URLSessionDownloadTask]()
//    var waitToDowloadData = [Data]()
    var waitToDowload = [Int : URLSessionDownloadTask]()
    lazy var session = URLSession(configuration: .default, delegate: self, delegateQueue: queue)
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        var string = "/Users/naveen-pt6302/Desktop/DEMOFILE/m\(Download.nameId).mp4"
        Download.nameId += 1
        print(string)
        var saveFile = URL(filePath: string)
        try?FileManager.default.moveItem(at: location, to: saveFile )
    }
    func dowload(url : URL){
       var task =  session.downloadTask(with: url)
        task.resume()
        dowloading[Download.id] = task
        Download.id += 1
        
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print("progress report  ",Int((Float(totalBytesWritten)/Float(totalBytesExpectedToWrite))*100))
    }
    func printArray(){
        print(dowloading)
    }
    func pause(index : Int){
        guard let task = dowloading[index] else{
            return
        }//d
        task.cancel { data in
            print("PAUSE")
            guard let data = data else{
                return
            }
//            self.waitToDowloadData.append(data)
            var pause = self.session.downloadTask(withResumeData: data)
            self.waitToDowload[index] = pause
 
        }
       dowloading.removeValue(forKey: index)
        
    }
    func resume(index : Int){
        guard let dow = waitToDowload[index] else{
            print("NO found index values")
            return
        }
        print("RESUME")
        dow.resume()
        dowloading[index] = waitToDowload[index]
        waitToDowload.removeValue(forKey: index)
    }
    func cancel(index : Int){
        guard let dow = dowloading[index] else{
            print("NO found index values")
            return
        }
        print("Cancel")
        dow.cancel()
        dowloading.removeValue(forKey: index)
    }
    func printWait(){
        print(waitToDowload)
    }
}

var download = Download()
download.dowload(url: URL(string: "https://s32.uptofiles.net/files/Tamil%20HD%20Mobile%20Movies/Vikram%20(1986)/Vikram%20(Original)/Vikram%20(640x360)/Vikram%201986%20HD%20Sample.mp4")!)
download.dowload(url: URL(string: "https://s32.uptofiles.net/files/Tamil%20HD%20Mobile%20Movies/Vikram%20(1986)/Vikram%20(Original)/Vikram%20(640x360)/Vikram%201986%20HD%20Sample.mp4")!)
//download.dowload(url: URL(string: "https://s32.uptofiles.net/files/Tamil%20HD%20Mobile%20Movies/Vikram%20(1986)/Vikram%20(Original)/Vikram%20(640x360)/Vikram%201986%20HD%20Sample.mp4")!)
//download.dowload(url: URL(string: "https://s32.uptofiles.net/files/Tamil%20HD%20Mobile%20Movies/Vikram%20(1986)/Vikram%20(Original)/Vikram%20(640x360)/Vikram%201986%20HD%20Sample.mp4")!)
//download.dowload(url: URL(string: "https://s32.uptofiles.net/files/Tamil%20HD%20Mobile%20Movies/Vikram%20(1986)/Vikram%20(Original)/Vikram%20(640x360)/Vikram%201986%20HD%20Sample.mp4")!)pe
download.printArray()
download.printWait()
download.pause(index: 0)
download.pause(index: 1)
download.printArray()
download.printWait()
download.resume(index: 1)
download.printArray()
download.printWait()
download.resume(index: 0)
download.printArray()
download.printWait()






//
//import Cocoa
//class Download : NSObject , URLSessionDownloadDelegate {
//    static var id = 0
//    var queue = OperationQueue()
//    var dowloading = [URLSessionDownloadTask]()
////    var waitToDowloadData = [Data]()
//    var waitToDowload = [URLSessionDownloadTask]()
//    lazy var session = URLSession(configuration: .default, delegate: self, delegateQueue: queue)
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
//        var string = "/Users/naveen-pt6302/Desktop/DEMOFILE/m\(Download.id).mp4"
//        Download.id += 1
//        print(string)
//        var saveFile = URL(filePath: string)
//        try?FileManager.default.moveItem(at: location, to: saveFile )
//    }
//    func dowload(url : URL){
//       var task =  session.downloadTask(with: url)
//        task.resume()
//        dowloading.append(task)
//
//    }
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
//        print("progress report  ",Int((Float(totalBytesWritten)/Float(totalBytesExpectedToWrite))*100))
//    }
//    func printArray(){
//        print(dowloading)
//    }
//    func pause(index : Int){
//        var task = dowloading[index]
//        task.cancel { data in
//            print("PAUSE")
//            guard let data = data else{
//                return
//            }
////            self.waitToDowloadData.append(data)
//            var pause = self.session.downloadTask(withResumeData: data)
//            self.waitToDowload.append(pause)
//        }
//        dowloading.remove(at: index)
//
//    }
//    func resume(index : Int){
//        guard index < waitToDowload.count else{
//            print("NO found index values")
//            return
//        }
//        print("RESUME")
//        waitToDowload[index].resume()
//        dowloading.insert(waitToDowload[index], at: index)
//        waitToDowload.remove(at: index)
//
//    }
//    func cancel(index : Int){
//        guard index < waitToDowload.count else{
//            print("NO found index values")
//            return
//        }
//        print("Cancel")
//        dowloading[index].cancel()
//    }
//}
//
//var download = Download()
//download.dowload(url: URL(string: "https://s32.uptofiles.net/files/Tamil%20HD%20Mobile%20Movies/Vikram%20(1986)/Vikram%20(Original)/Vikram%20(640x360)/Vikram%201986%20HD%20Sample.mp4")!)
//download.dowload(url: URL(string: "https://s32.uptofiles.net/files/Tamil%20HD%20Mobile%20Movies/Vikram%20(1986)/Vikram%20(Original)/Vikram%20(640x360)/Vikram%201986%20HD%20Sample.mp4")!)
//download.pause(index: 0)
//download.pause(index: 1)
//download.resume(index: 0)
//
//download.pause(index: 0)
//
//download.resume(index: 0)
//download.resume(index: 1)





//download.printArray()
//download.pause(index: 0)
//download.pause(index: 1)
//download.printWait()
//download.printArray()
//download.resume(index: 0)
//download.printWait()
//download.printArray()
//download.pause(index: 0)
//download.printWait()
//download.printArray()
//download.resume(index: 0)
//download.resume(index: 1)
//download.printArray()
