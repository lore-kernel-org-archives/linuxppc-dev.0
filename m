Message-ID: <397DCCDD.5BF75110@ivey.uwo.ca>
Date: Tue, 25 Jul 2000 13:22:37 -0400
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
MIME-Version: 1.0
To: Godmar Back <gback@cs.utah.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: diff to tonight's kaffe cvs tree to work on ppc
References: <200007250345.VAA22028@faith.cs.utah.edu> <397D926F.111AF60E@ivey.uwo.ca>
Content-Type: multipart/mixed;
 boundary="------------FFA3DA259B6C9B06A9307215"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------FFA3DA259B6C9B06A9307215
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Godmar,

Will you you replace the kaffe_cleanups.patch I just sent you with the slightly
revised one attached.

After some discussions with Tom Gall (of IBM for Linux and 64bit ppc and Linux),
it would be better to change the unsigned int types I used in the align with
unsigned long.

Thanks again,

Kevin
--------------FFA3DA259B6C9B06A9307215
Content-Type: application/x-gzip;
 name="kaffe_cleanups.rev2.patch.gz"
Content-Disposition: inline;
 filename="kaffe_cleanups.rev2.patch.gz"
Content-Transfer-Encoding: base64

H4sICM/LfTkAA2thZmZlX2NsZWFudXBzLnJldjIucGF0Y2gAlZJvb5swEMZfh09x66QKQhxM
/mwd06akWVRtS9toZJr2ZoiBCbRgUIAk/fY7Y0hYmkmrJZB9j587+/wjhMCjGwTM8FIeRGsj
S3dsk3m4TJKU98PObcrhSxnDYAQD0xoPrBGFAaVU0XVdWom3zf9pX5VM2sdA31kU7WNpn0yA
jHqmCTr+hzCZKABd8RkKKOR1FIDPgogzH1THiSNe7h1Hg8vLJozRuhjGFVJZOGpQ785QkKdw
QhSl66yoH51NxpZ2MD7T4KjezeefHHs1nX11povPN3dHpRVUMw1AxVHyPFqLm8UpX2sYxnuB
OdbgF5zRFB2qI76oHyAM1anyp9xn2cyN41tWhKkvJO7Fpc/gwsNoUkUd7Eg/vEBRpuuc2tTZ
dLHQ4DQsfFJSyAGl1n+bGGgpWJIbJY/25KEIN8z1c6Oe9L2OXdaADYFeWXRojd+eA+xlSdvY
XWFGS+DbYGcOTdozKejNRMDXSVjiZU8qZ7u8cL3HHqSxX8/kI87ulz+199gixn3srtGFV1K4
+Xb/w3a+L5+z+1/odjDTjgFn+LZpuYGqKBQp/GbgxpIGXJlvRH4C9WjOCR9a0Hihu4GudooY
HG4lSKP7QA6Kt2mTpZ5iLNg7U26bRj5W+YvtQ4FDgxQdm2rPV469VB+KyCcfGd/2oL1RYtpU
F3uvl5ryBxK78yuUBAAA
--------------FFA3DA259B6C9B06A9307215--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
