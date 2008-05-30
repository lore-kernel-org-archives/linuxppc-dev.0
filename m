Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id CE3ECDE1DE
	for <linuxppc-dev@ozlabs.org>; Fri, 30 May 2008 18:24:28 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/4] [POWERPC] 85xx: add board support for the TQM8548
	modules
Date: Fri, 30 May 2008 10:24:18 +0200
References: <1212130188-28835-1-git-send-email-wg@grandegger.com>
	<1212130188-28835-2-git-send-email-wg@grandegger.com>
In-Reply-To: <1212130188-28835-2-git-send-email-wg@grandegger.com>
MIME-Version: 1.0
Message-Id: <200805301024.19180.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

T24gRnJpZGF5IDMwIE1heSAyMDA4LCBXb2xmZ2FuZyBHcmFuZGVnZ2VyIHdyb3RlOgo+IAo+IKAj
aWZkZWYgQ09ORklHX1BDSQo+IC2goKCgoKCgZm9yX2VhY2hfY29tcGF0aWJsZV9ub2RlKG5wLCAi
cGNpIiwgImZzbCxtcGM4NTQwLXBjaSIpCj4gLaCgoKCgoKCgoKCgoKCgoGZzbF9hZGRfYnJpZGdl
KG5wLCAxKTsKPiAroKCgoKCgoGZvcl9lYWNoX25vZGVfYnlfdHlwZShucCwgInBjaSIpIHsKPiAr
oKCgoKCgoKCgoKCgoKCgaWYgKG9mX2RldmljZV9pc19jb21wYXRpYmxlKG5wLCAiZnNsLG1wYzg1
NDAtcGNpIikgfHwKPiAroKCgoKCgoKCgoKCgoKCgIKAgoG9mX2RldmljZV9pc19jb21wYXRpYmxl
KG5wLCAiZnNsLG1wYzg1NDgtcGNpZSIpKSB7Cj4gK6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgc3Ry
dWN0IHJlc291cmNlIHJzcmM7Cj4gK6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgb2ZfYWRkcmVzc190
b19yZXNvdXJjZShucCwgMCwgJnJzcmMpOwo+ICugoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGlmICgo
cnNyYy5zdGFydCAmIDB4ZmZmZmYpID09IDB4ODAwMCkKPiAroKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoGZzbF9hZGRfYnJpZGdlKG5wLCAxKTsKPiAroKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKBlbHNlCj4gK6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBmc2xfYWRkX2JyaWRnZShu
cCwgMCk7Cj4gK6CgoKCgoKCgoKCgoKCgoH0KPiAroKCgoKCgoH0KPiCgI2VuZGlmCgpUaGlzIGxv
b2tzIGxpa2UgYSB2ZXJ5IHdyb25nIHRvIGZpZ3VyZSBvdXQgd2hhdCBpcyBhIHByaW1hcnkgYnJp
ZGdlLgpJIGRvIHJlYWxpemUgdGhhdCB5b3UgY29waWVkIGl0IGZyb20gb3RoZXIgcGxhY2VzLCBi
dXQgdGhhdCBkb2Vzbid0Cm1ha2UgaXQgYmV0dGVyLgpDYW4ndCB3ZSBjaGFuZ2UgZnNsX2FkZF9i
cmlkZ2UgdG8gZmlndXJlIHRoaXMgb3V0IGF1dG9tYXRpY2FsbHk/CkEgbXVjaCBiZXR0ZXIgaGV1
cmlzdGljIHNob3VsZCBiZSB0byBtYWtlIGEgYnJpZGdlIHByaW1hcnkgaWYKaXQgaGFzIGFuICJJ
U0EiIGNoaWxkIGJ1cy4gRG9lcyB0aGF0IHdvcmsgZm9yIGFsbCBleGlzdGluZyBzeXN0ZW1zPwoK
CUFybmQgPD48Cg==
