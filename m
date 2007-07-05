Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 5F96CDE21A
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:07:49 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: PowerPC equivalent to dma_mmap_writecombine()?
Date: Thu, 5 Jul 2007 18:13:53 +0200
References: <468D1F23.6000803@freescale.com>
In-Reply-To: <468D1F23.6000803@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707051813.53762.arnd@arndb.de>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

T24gVGh1cnNkYXkgMDUgSnVseSAyMDA3LCBUaW11ciBUYWJpIHdyb3RlOgo+IHN0YXRpYyBpbnQg
YXQ5MV9wY21fbW1hcChzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwKPiCgoKCg
oKCgoHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQo+IHsKPiCgoKCgoKCgoHN0cnVjdCBzbmRf
cGNtX3J1bnRpbWUgKnJ1bnRpbWUgPSBzdWJzdHJlYW0tPnJ1bnRpbWU7Cj4gCj4goKCgoKCgoKBy
ZXR1cm4gZG1hX21tYXBfd3JpdGVjb21iaW5lKHN1YnN0cmVhbS0+cGNtLT5jYXJkLT5kZXYsIHZt
YSwKPiCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCCgIKAgcnVudGltZS0+ZG1hX2Fy
ZWEsCj4goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgoCCgIHJ1bnRpbWUtPmRtYV9h
ZGRyLAo+IKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIKAgoCBydW50aW1lLT5kbWFf
Ynl0ZXMpOwo+IH0KPiAKPiBUaGVyZSBhcmUgbm8gZG1hX21tYXBfeCgpIGZ1bmN0aW9ucyBpbiBh
cmNoL3Bvd2VycGMuIKBDYW4gc29tZW9uZSB0ZWxsIG1lIHdoYXQgdGhlIHBvd2VycGMgCj4gZXF1
aXZhbGVudCB0byBkbWFfbW1hcF93cml0ZWNvbWJpbmUoKSBpcz8KCk5vdCBzdXJlIGV4YWN0bHkg
d2hhdCBhcm0gZG9lcyBoZXJlLCBidXQgaXQgc291bmRzIGxpa2UgeW91IHdhbnQKdG8gY2FsbCBy
ZW1hcF9wZm5fcmFuZ2Ugd2l0aCB0aGUgX1BBR0VfTk9fQ0FDSEUgYml0IHNldCBpbiB0aGUKcHJv
dGVjdGlvbiBmbGFncywgYW5kIF9QQUdFX0dVQVJERUQgbm90IHNldC4KCglBcm5kIDw+PAo=
