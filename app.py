import sys, os
from PyQt5.QtCore import QObject, QUrl, pyqtSlot
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlComponent, QQmlEngine

class Application( QObject ) :

    def __init__(self) :
        QObject.__init__( self )
        self.app = QApplication( sys.argv )
        self.app.setApplicationName( 'Waterfall' )
        engine = QQmlEngine()

        appDirPath = os.path.dirname( os.path.abspath( __file__ ) )
        rootContext = engine.rootContext()
        rootContext.setContextProperty( 'controller', self )
        rootContext.setContextProperty( 'appPath', appDirPath.replace( "\\", "/" ) + "/" )
        windowComp = QQmlComponent( engine, QUrl( 'qml/Main.qml' ) )
        
        self.window = windowComp.create()
        self.window.show()
        self.app.exec()

    @pyqtSlot(int, str)
    def animationEnqueue(x, url) :
        print('enq animation', x ,url)


if __name__ == "__main__":
    app = Application()
    