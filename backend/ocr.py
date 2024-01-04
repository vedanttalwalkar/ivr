class Ocr:
    def get_ocr(url):
        import cv2
        from PIL import Image
        import pytesseract
        import urllib
        import numpy as np
    
        # url = "https://pyimagesearch.com/wp-content/uploads/2015/01/opencv_logo.png"
        url_response = urllib.request.urlopen(url)
        img_array = np.array(bytearray(url_response.read()), dtype=np.uint8)
        img = cv2.imdecode(img_array, -1)
        # img=cv2.imread("data/sample.png")
        gray=cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
        cv2.imwrite("temp/gray.png",gray)
        blur = cv2.GaussianBlur(gray, (7,7), 0)
        cv2.imwrite("temp/blur.png",blur)
        thresh = cv2.threshold(blur, 0, 255, cv2.THRESH_BINARY_INV + cv2.THRESH_OTSU)[1]
        cv2.imwrite("temp/thresh.png",thresh)
        kernal = cv2.getStructuringElement(cv2.MORPH_RECT, (3, 13))
        dilate = cv2.dilate(thresh, kernal, iterations=1)
        cv2.imwrite("temp/index_kernal.png", kernal)
        cv2.imwrite("temp/index_dilate.png", dilate)

        cnts = cv2.findContours(dilate, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        cnts = cnts[0] if len(cnts) == 2 else cnts[1]
        cnts = sorted(cnts, key=lambda x: cv2.boundingRect(x)[0])
        for c in cnts:
            x,y,w,h=cv2.boundingRect(c)
            roi=img[y:y+h,x:x+w]
            cv2.imwrite("data/roi.png",roi)
            cv2.rectangle(img,(x,y),(x+w,y+h),(36,100,13),2)
        cv2.imwrite("data/cnt.png",img)
        ocr_res=pytesseract.image_to_string(img)
        ocr_res=ocr_res.split("\n")
        print(ocr_res)
        for item in ocr_res:
            item=item.strip()
            print(item)
        return ocr_res