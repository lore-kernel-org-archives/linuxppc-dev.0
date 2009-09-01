Return-Path: <jakemagee@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 09DD8B7B6D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Sep 2009 14:09:24 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id b2so2210199ana.32
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 Aug 2009 21:09:23 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 31 Aug 2009 23:09:23 -0500
Message-ID: <a8142e730908312109x7f49806duc35bb580051af2e8@mail.gmail.com>
Subject: PPC405 RTC not working
From: Jake Magee <jakemagee@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0016e6476268c016d604727c5075
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e6476268c016d604727c5075
Content-Type: text/plain; charset=ISO-8859-1

I am currently trying to get a M41T65 sensor to work on a PPC405 based
board.  I am using the 2.6.26 kernel with a backported version of
rtc-m41t80.c (from 2.6.30).  Everything compiles and loads fine.  However,
there is no /dev/rtc node created.  "/proc/devices" returns "254 rtc" (which
I feel isn't correct).  And "/sys/bus/i2c/devices/" list nothing for the
RTC.  I do see the information from the device tree in
"/proc/device-tree/plb/opb/i2c@ef600400/rtc@68/"

Here is my dts information:
 IIC0: i2c@ef600400 {
                                compatible = "ibm,iic-405exr", "ibm,iic";
                                reg = <ef600400 14>;
                                interrupt-parent = <&UIC0>;
                                interrupts = <2 4>;
                                index = <0>;
                                rtc@68 {
                                        compatible = "m41t65";
                                        reg = <68>;
                                        };
                        };

Thanks!
Jake Magee

--0016e6476268c016d604727c5075
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: base64

SSBhbSBjdXJyZW50bHkgdHJ5aW5nIHRvIGdldCBhIE00MVQ2NSBzZW5zb3IgdG8gd29yayBvbiBh
IFBQQzQwNSBiYXNlZCBib2FyZC6gIEkgYW0gdXNpbmcgdGhlIDIuNi4yNiBrZXJuZWwgd2l0aCBh
IGJhY2twb3J0ZWQgdmVyc2lvbiBvZqAgcnRjLW00MXQ4MC5jIChmcm9tIDIuNi4zMCkuoCBFdmVy
eXRoaW5nIGNvbXBpbGVzIGFuZCBsb2FkcyBmaW5lLqAgSG93ZXZlciwgdGhlcmUgaXMgbm8gL2Rl
di9ydGMgbm9kZSBjcmVhdGVkLqAgJnF1b3Q7L3Byb2MvZGV2aWNlcyZxdW90OyByZXR1cm5zICZx
dW90OzI1NCBydGMmcXVvdDsgKHdoaWNoIEkgZmVlbCBpc24mIzM5O3QgY29ycmVjdCkuoCBBbmQg
JnF1b3Q7L3N5cy9idXMvaTJjL2RldmljZXMvJnF1b3Q7IGxpc3Qgbm90aGluZyBmb3IgdGhlIFJU
Qy6gIEkgZG8gc2VlIHRoZSBpbmZvcm1hdGlvbiBmcm9tIHRoZSBkZXZpY2UgdHJlZSBpbiAmcXVv
dDsvcHJvYy9kZXZpY2UtdHJlZS9wbGIvb3BiL2kyY0BlZjYwMDQwMC9ydGNANjgvJnF1b3Q7PGJy
Pgo8YnI+SGVyZSBpcyBteSBkdHMgaW5mb3JtYXRpb246PGJyPqBJSUMwOiBpMmNAZWY2MDA0MDAg
ezxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIGNvbXBhdGlibGUgPSAmcXVvdDtp
Ym0saWljLTQwNWV4ciZxdW90OywgJnF1b3Q7aWJtLGlpYyZxdW90Ozs8YnI+oKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoCByZWcgPSAmbHQ7ZWY2MDA0MDAgMTQmZ3Q7Ozxicj6goKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIGludGVycnVwdC1wYXJlbnQgPSAmbHQ7JmFtcDtVSUMw
Jmd0Ozs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgaW50ZXJydXB0cyA9ICZs
dDsyIDQmZ3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIGluZGV4ID0gJmx0
OzAmZ3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIHJ0Y0A2OCB7PGJyPqCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCBjb21wYXRpYmxlID0gJnF1b3Q7
bTQxdDY1JnF1b3Q7Ozxicj4KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
IHJlZyA9ICZsdDs2OCZndDs7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoCB9Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoCB9Ozxicj48YnI+VGhhbmtzITxicj5K
YWtlIE1hZ2VlPGJyPgo=
--0016e6476268c016d604727c5075--
