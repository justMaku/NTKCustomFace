import lldb
import os

CURRENT_PATH = os.getcwd()
PROCESS_NAME = "Carousel"
PAYLOAD_NAME = "NTKCustomFace.dylib"
PAYLOAD_PATH = "{}/build/{}".format(CURRENT_PATH, PAYLOAD_NAME)
PAYLOAD_LOAD_EXPR = "(int)dlopen(\"{}\")".format(PAYLOAD_PATH)

def __lldb_init_module(debugger, dict):
    target = debugger.CreateTarget('')
    error = SBError()
    
    process = target.AttachToProcessWithName(debugger.GetListener(), PROCESS_NAME, False, error)
    
    thread = process.GetSelectedThread()
    frame = thread.GetSelectedFrame()
    
    result = frame.EvaluateExpression(PAYLOAD_LOAD_EXPR)
    print(result)
    process.Detach()
    os._exit(1)
    return
