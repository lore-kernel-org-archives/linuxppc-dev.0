Return-Path: <lim@taicom.com.cn>
Received: from mxvip1.hichina.com (mxvip1.hichina.com [218.106.248.51])
	by ozlabs.org (Postfix) with ESMTP id E9115DDE3B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Aug 2007 13:05:10 +1000 (EST)
Received: from 203.187.170.169 (HELO a792c537ba7342e) (envelope-from
	lim@taicom.com.cn)
	by mxvip1.hichina.com (quarkmail-1.2.1) with ESMTP id S4192498AbXHQC6Z
	for linuxppc-embedded@ozlabs.org; Fri, 17 Aug 2007 10:58:25 +0800
Date: Fri, 17 Aug 2007 10:58:01 +0800
From: "=?GB2312?B?wO7D9w==?=" <lim@taicom.com.cn>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
References: <200708171019577288809@taicom.com.cn>,
	<200708171028495734596@taicom.com.cn>
Subject: some question about linux kernel in embed system
Message-ID: <200708171057543728507@taicom.com.cn>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====001_Dragon147626187522_====="
Reply-To: lim@taicom.com.cn
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

--=====001_Dragon147626187522_=====
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

hello everyone 
I am doing some embed system works.
Now I want to replant the linux-2.4.32 to my own system.
But there are some questions.First let me introduce my heardware:
I use powerpc+flash+sdram to buildup a mini system,use u-boot 1.1.4 as bootloader then I need to replant the kernel on it .
The linux-2.4.32 kernel which was made a uImage, is running in this mini system, the question is appear:
    Image Name:   Linux-2.4.32
   Created:      2007-08-16  21:31:03 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    685809 Bytes = 669.7 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
then the kernel is dead, I do not know what is problem,please give me some clew,thanks!   
--=====001_Dragon147626187522_=====
Content-Type: image/gif;
	name="man_016(08-17-10-55-25).gif"
Content-Transfer-Encoding: base64
Content-Disposition: FoxmailIcon;
	filename="man_016(08-17-10-55-25).gif"

R0lGODlhKAAoAPcGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAQAAAcAAAwAABEAABgAAB0AABwB
ARUEAxEGBA8HBQ8IBg4JBw4KCA4LCg8ODRAPDRMPDBYQChgQChkRCRoRCR0TCiIXDicaECoeFywh
Gy8hFzIgFTQiFTkkFDsmFj0nGD8pG0MsH0UuIEcvIEcvIEcwI0guH0kpHE0bE1EEBU4AAksAAUwA
AU8AAVEAAVUAAlcBAlgBA1sGBWAPCmIYDmQlEmMvFmI1GWE4G186IV08KWA+KmNCK2dEKmpFKGxH
K3BKLnRMMHlQNH1TOIZYOYxdO5BfPpJhQZNiQpZkQ5dlRJZmRo9lSX9lU29mYmhscGdxe2dzfmh1
gWt4hG98iHSAi3qFj3+Jk4ONl4aPmIiPl4qOlIyMjo+IhJWCdZ17ZKN3WKZ1U6l0UKp0Tq11TrB2
TrR3TrZ5ULd6Ubl7Ur19VMGAVcGAVsKAVsKAVsKAVsKAVcKBVcKAVcKBVsKBVsKBVsOBWMSCWcWC
WcWCWsaEW8eFXMiGXciIX8eJYceKYseLZMiMZcqNZcyPZs+RZ9KSaNKTadOTaNKRZ9GPZdCOY86M
YMqHU8aBRMJ7NMB0I8FzHMFxF8Z1F8l2F8x5F9F8GNaAGN6EGeKHGuWJGuaKGueLGueLGueLGueL
GueLGueLGueLG+eMG+eMG+eMHOeNIeaQLeSWQ+KbVOGfZOCjb9+kdN+lduCmeOCneeGne+KofOGo
feGoft+pgd2phNuqiNqrjNirkNetlNSumdqwlt6ykuK0jea1iee1h+i2h+m4iOq5iOy6ie28iu69
i/C/jfHBj/LEkPPGkvTHk/XJlPXKlfXKlfXKlvTLmfLMne/No+rPruLSvdXb4c7i9srj+8fj/snk
/crk/cnk/cbj/sbj/sbj/sbj/sbj/sbj/sbj/sbj/sbj/sbj/sbj/sbj/sbj/sbj/sbj/sfh+sbe
9cXb8cPZ77/V6r3S57fL36/E2Ki90qC3zZ+2y560yp2zyJyyx5yzyCH5BAgAAAYALAAAAAAoACgA
AAj+AL35M0CwoMGDCBMq9Mawi8KHEB8y9IYlosWLEyte3LiQoUaOIAtmfBgiRMiOFBVW+Xjy4MiD
F7BgoYCE4IcnLAgieTJCJxMJEPV5PBiCDBkQI+YQTKqE4JQ5NQ3MmYMCor+hBYmMOSphjVIDSacQ
nPpk7BwiVrFSuDLmygUDSqYulStV7oepTDQ8vJqSghUibw0gmfo16ZwRhg8bXiMEbUK+WCToPcji
TeGpQhILQUFYSU6DI/RCZlFWQ9WCEpjMneOZMBMiU1gAPbjEzxID9TwSeXJ3zhslpwsankJk6hsh
D4X48aM64wgmiY0DXw2VyWkJiEc0JtKTyHIhFib+giGo4ckTy4S/Siju+4nX9OnReo8jwcrEehYQ
Yh9R5a0GIu/NsYZ5BBaYk3coWIDPRN7oA8JBDTRQBTctCLecYwQFdhAROYHBIEP1hDCZATMkwU0w
MSyQ0Aw7aINiDDE0cFAXH050hRDIERRMMDvEoIABVETiRy1okKgNNz3EMIOKEiBngYc1MiTGXWvk
pCEFaDQDiR+7NGOSGCg0oKIBEhAXglBRTmTBe4agUcWbxTzzTCN+HPNMMUtUaAAFKSBhGRFYpMlg
C4PNkYgtyDwjzaLSNGLAMYwu+gwyuCQyFQuBCiplb4XMkoyijDqaTKSLIjOLH1NJgKamAz3lhyz+
n0YqKqnPGNPIVFOEJ2g9YISgwAIsTNWILs3IqaijkEZqKqpzsBCCGFF20YIFC8yQgwwSWNbpMch0
iwwjI+DSjDPOTGqMI6iWJaYFVkA7EQMzyJDDvDksMJgfjeBizDH84lILv8kEfMwshUz1QQMw/qBE
BxZgsSC9EM+gwVSFyFILLhhnrPEsW55FIoyZqKJKJj80DDHEcM3hByOyzOIIIjDH7MgsdM4hlgEw
xhCyyKpwUsLJ9C6ggbaNONJEEkgn/YQjlr6hQU05b8Izz/ICrYAGwfqRCCSNdO1114mgigJnOMMo
9dSqGIAwxA188IYEcWkdSRpIEEHEEnSE3ayhB5Z5MAPIaPdcAonzzlCmzXDPQUgijDeeCCHNdjUV
EQvAqMPOaGfSgQINHI6XAVP4QcjopKMq21OEafC3Dj9gjjYTLxjAQoBKlLnc7X68wYIHAdpsgAw/
fDK1z4Fz8oMB2xHxQWoF8jYCelM11UAPU39yvBGBi8yJEdwb8UMJ4HewnxDwIcei8CLX/gIn2bfP
MyeJp/fGCAvIEMPZmn+AeUAAOw==

--=====001_Dragon147626187522_=====--
