from flask import Flask,request
from flask_smorest import abort
from ocr import Ocr
from flask_cors import CORS
app=Flask(__name__)
CORS(app)
@app.post("/get-ocr")
def send_ocr_res():
    req_data=request.get_json()
    url=req_data['url']
    ocr=Ocr.get_ocr(url)
    return {"message":ocr}

@app.get("/get-ocr")
def hello():
    return {"message":"hoi"}


    

