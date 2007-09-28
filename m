Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id A5DA4DDE07
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 05:49:47 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 11/18] Virtex: Port UARTLITE driver to of-platform-bus
Date: Fri, 28 Sep 2007 21:32:17 +0200
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181748.18608.62409.stgit@trillian.cg.shawcable.net>
In-Reply-To: <20070928181748.18608.62409.stgit@trillian.cg.shawcable.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709282132.17919.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

T24gRnJpZGF5IDI4IFNlcHRlbWJlciAyMDA3LCBHcmFudCBMaWtlbHkgd3JvdGU6Cj4gLaCgoKCg
oKByZXQgPSB1YXJ0X3JlZ2lzdGVyX2RyaXZlcigmdWxpdGVfdWFydF9kcml2ZXIpOwo+IC2goKCg
oKCgaWYgKHJldCkKPiAtoKCgoKCgoKCgoKCgoKCgcmV0dXJuIHJldDsKPiAroKCgoKCgoHByX2Rl
YnVnKCJ1YXJ0bGl0ZTogY2FsbGluZyB1YXJ0X3JlZ2lzdGVyX2RyaXZlcigpXG4iKTsKPiAroKCg
oKCgoGlmICgocmV0ID0gdWFydF9yZWdpc3Rlcl9kcml2ZXIoJnVsaXRlX3VhcnRfZHJpdmVyKSkg
IT0gMCkKPiAroKCgoKCgoKCgoKCgoKCgZ290byBlcnJfdWFydDsKPiCgCj4gLaCgoKCgoKByZXQg
PSBwbGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIoJnVsaXRlX3BsYXRmb3JtX2RyaXZlcik7Cj4gLaCg
oKCgoKBpZiAocmV0KQo+IC2goKCgoKCgoKCgoKCgoKB1YXJ0X3VucmVnaXN0ZXJfZHJpdmVyKCZ1
bGl0ZV91YXJ0X2RyaXZlcik7Cj4gK6CgoKCgoKBpZiAoKHJldCA9IHVsaXRlX29mX3JlZ2lzdGVy
KCkpICE9IDApCj4gK6CgoKCgoKCgoKCgoKCgoGdvdG8gZXJyX29mOwo+IKAKPiAroKCgoKCgoHBy
X2RlYnVnKCJ1YXJ0bGl0ZTogY2FsbGluZyBwbGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIoKVxuIik7
Cj4gK6CgoKCgoKBpZiAoKHJldCA9IHBsYXRmb3JtX2RyaXZlcl9yZWdpc3RlcigmdWxpdGVfcGxh
dGZvcm1fZHJpdmVyKSkgIT0gMCkKPiAroKCgoKCgoKCgoKCgoKCgZ290byBlcnJfcGxhdDsKPiAr
Cj4gK6CgoKCgoKByZXR1cm4gMDsKCkkgZG9uJ3Qgc2VlIHRoaXMgYXMgbXVjaCBvZiBhbiBpbXBy
b3ZlbWVudC4gRG9pbmcgYW4gYXNzaWdubWVudCBpbiB0aGUKY29uZGl0aW9uIG1ha2VzIHRoZSBj
b2RlIGxlc3MgcmVhZGFibGUgSU1ITywgc28gaXQgc2hvdWxkIHJlYWxseQpiZSB3cml0dGVuIGFz
CgoJcmV0ID0gdHJ5X3NvbWV0aGluZygpOwoJaWYgKHJldCkKCQlnb3RvIHNvbWV0aGluZ19mYWls
ZWQ7CgpUaGlzIGtlZXBzIHRoZSBub3JtYWwgY29kZSB0byB0aGUgbGVmdCwgYW5kIHRoZSBlcnJv
ciBoYW5kbGluZyBpbmRlbnRlZAp0byB0aGUgcmlnaHQuCgoKCUFybmQgPD48Cg==
