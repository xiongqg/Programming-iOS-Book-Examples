

import UIKit

var vglob : String = {
    print("initializing vglob")
    return "hello"
}()

// lazy var and value types

struct Person {
    private lazy var name = "matt"
    mutating func getName() -> String {
        return self.name // compile error unless func is mutating
    }
}

// singleton

class MyClass {
    static let shared = MyClass()
}

class MyView : UIView {
    // lazy var arrow : UIImage = self.arrowImage()
    // explicit type not required if not using define-and-call
    lazy var arrow = self.arrowImage() // self not required here
    func arrowImage () -> UIImage {
        // ... big image-generating code goes here ...
        return UIImage() // stub
    }
}

class Helper {
    unowned var vc : UIViewController
    init(_ vc:UIViewController) {
        self.vc = vc
    }
}

class Helper2 {
    weak var vc : UIViewController?
}

// not entirely satisfactory solution to the lack of lazy let
@propertyWrapper struct Once<T> {
    private var _p : T? = nil
    var wrappedValue : T {
        get {
            if _p == nil {
                fatalError("not initialized")
            }
            return self._p!
        }
        set {
            if _p != nil {
                // fatalError("cannot assign twice")
            }
            self._p = newValue
        }
    }
}


class ViewController: UIViewController {
    
    lazy var prog : UIProgressView = {
        let p = UIProgressView(progressViewStyle: .default)
        p.alpha = 0.7
        p.trackTintColor = UIColor.clear
        p.progressTintColor = UIColor.black
        p.frame = CGRect(x:0, y:0, width:self.view.bounds.size.width, height:20)
        p.progress = 1.0
        return p
    }()
    
    lazy var helperr = Helper(self)
    @Once var helper : Helper
    
    lazy var helper2 : Helper2 = {
        let h = Helper2()
        h.vc = self
        return h
    }()

    static var vstat : String = {
        print("initializing static v")
        return "hello"
    }()
    lazy var vlazy : String = {
        print("initializing lazy v")
        return "hello"
    }()
    var which = true
    override func viewDidLoad() {
        super.viewDidLoad()

        print("setting vglob")
        vglob = "yoho"
        print("did set vglob")
        print("setting vstat")
        Self.vstat = "haha"
        print("did set vstat")
        print("setting vlazy")
        self.vlazy = "teehee"
        print("did set vlazy")



        let s1 = MyClass.shared
        let s2 = MyClass.shared
        print( s1 === s2 )
        
        let layout = UICollectionViewLayout()
        class MyDynamicAnimator : UIDynamicAnimator {}
        let anim2 = MyDynamicAnimator(collectionViewLayout:layout)
        _ = anim2
        
        self.helper = Helper(self)
        print("did one", self.helper)
        self.helper = Helper(self) // crash, better than nothing I suppose
        print("did two", self.helper)

        lazy var what : String = {
            print("lazy local initialized")
            return "howdy"
        }()
        if which {
            print(what)
        }

    }
    

    
    
}

