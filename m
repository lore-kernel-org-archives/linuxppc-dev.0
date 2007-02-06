Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 693B4DDE10
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 00:07:41 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] add soc setup code for USB DR OTG mode
Date: Tue, 6 Feb 2007 14:07:24 +0100
References: <45C6F46C.9000000@freescale.com>
	<297BF1F9-551F-43AD-9E76-00C79EC8BF31@kernel.crashing.org>
In-Reply-To: <297BF1F9-551F-43AD-9E76-00C79EC8BF31@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702061407.24843.arnd@arndb.de>
Cc: Li Yang <leoli@freescale.com>, Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

T24gTW9uZGF5IDA1IEZlYnJ1YXJ5IDIwMDcgMTY6MTUsIEt1bWFyIEdhbGEgd3JvdGU6Cj4gPiAr
oKCgoKCgoKCgoKCgoKCgoKCgoKCgdXNiX2RhdGEub3BlcmF0aW5nX21vZGUgPSBGU0xfVVNCMl9E
Ul9IT1NUOwo+ID4gK6CgoKCgoKCgoKCgoKCgoKCgoKCgoHVzYl9kZXZfZHJfaG9zdCA9IHBsYXRm
b3JtX2RldmljZV9yZWdpc3Rlcl9zaW1wbGUoCj4gPiAroKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoCJmc2wtZWhjaSIsIGksIHIsIDIpOwo+ID4gK6CgoKCgoKCgoKCgoKCgoKCg
oKCgoGlmIChJU19FUlIodXNiX2Rldl9kcl9ob3N0KSkgewo+ID4gK6CgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgcmV0ID0gUFRSX0VSUih1c2JfZGV2X2RyX2hvc3QpOwo+ID4gK6CgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgZ290byBlcnI7CgpJIGp1c3Qgc2F3IHRoYXQgdGhpcyBmaWxl
IGhhcyBhIG51bWJlciBvZiBjYWxscyB0byAKcGxhdGZvcm1fZGV2aWNlX3JlZ2lzdGVyX3NpbXBs
ZSgpIGZvciBkZXZpY2VzIHRoYXQgY29tZSBmcm9tIHRoZSBPRgpkZXZpY2UgdHJlZS4KCkNhbiB0
aGlzIGJlIGNvbnZlcnRlZCB0byB1c2Ugb2ZfcmVnaXN0ZXJfcGxhdGZvcm1fZHJpdmVyKCkgYW5k
Cm9mX3BsYXRmb3JtX2RldmljZV9wcm9iZSgpIGluc3RlYWQ/CgoJQXJuZCA8PjwK
