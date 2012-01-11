Return-Path: <Farrukh_Arshad@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "relay1.mentorg.com",
 Issuer "Entrust Certification Authority - L1B" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1B208B6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2012 02:52:22 +1100 (EST)
From: "Arshad, Farrukh" <Farrukh_Arshad@mentor.com>
To: tiejun.chen <tiejun.chen@windriver.com>
Subject: RE: Problem in getting shared memory access on P1022RDK
Date: Wed, 11 Jan 2012 15:52:12 +0000
Message-ID: <93CD5F41FDBC6042A6B449764F3B35CC050CD375@EU-MBX-03.mgc.mentorg.com>
References: <93CD5F41FDBC6042A6B449764F3B35CC050CCA22@EU-MBX-03.mgc.mentorg.com>
 <93CD5F41FDBC6042A6B449764F3B35CC050CCA80@EU-MBX-03.mgc.mentorg.com>
 <4F033685.6000509@freescale.com>
 <93CD5F41FDBC6042A6B449764F3B35CC050CCB2E@EU-MBX-03.mgc.mentorg.com>
 <4F050653.6010601@windriver.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

QWRkaW5nIG1vcmUgaXQsIA0KDQpJIGhhdmUgcmVtb3ZlZCB0aGUgc2hhcmVkIG1lbW9yeSBrZXJu
ZWwgZHJpdmVyIGRlcGVuZGVuY3kganVzdCB0byBuYXJyb3cgZG93biB0aGUgcHJvYmxlbSBhcmVh
IGFuZCBJIGhhdmUgd3JpdHRlbiBhIHNtYWxsIHBpZWNlIG9mIGNvZGUgaW4gdXNlciBzcGFjZS4g
QSB3cml0ZXIgJiBhIHJlYWRlciBhcHBsaWNhdGlvbiB3aGljaCBhY2Nlc3MgdGhlIHNoYXJlZCBt
ZW1vcnkgYW5kIEkgZ290IHRoZSBzYW1lIGJlaGF2aW9yIGFzIHdpdGggdGhlIHNoYXJlZCBtZW1v
cnkga2VybmVsIGRyaXZlci4gSW50ZXJlc3RpbmdseSwgbXkgdXNlciBzcGFjZSBhcHBsaWNhdGlv
biB3b3JrIGZpbmUgb24gUDEwMjJEUyBidXQgbm90IG9uIFAxMDIyUkRLIGhvd2V2ZXIgYm90aCB1
c2luZyB0aGUgc2FtZSBDUFUgbW9kdWxlcy4NCg0KV2hlbiBJIHdyaXRlIGEgc2ltcGxlIHN0cmlu
ZyBvbiBzaGFyZWQgbWVtb3J5IGZyb20gQ29yZSAxIGl0IGlzIHJlYWQgYXQgQ29yZSAwIHByb3Bl
cmx5DQpXaGVuIEkgd3JpdGUgYSBzaW1wbGUgc3RyaW5nIG9uIHNoYXJlZCBtZW1vcnkgZnJvbSBD
b3JlIDAgaXQgaXMgbm90IHJlYWQgYXQgQ29yZSAxLiANCg0KV2l0aCB0aGlzIHRlc3Qgbm93IEkg
YW0gc3VyZSB0aGUgcHJvYmxlbSBsaWVzIGluIHRoZSBrZXJuZWwgaXRzZWxmLiBBbnkgcG9pbnRl
cnMgdG8gbG9vayBmb3IgdGhlIHRyb3VibGVkIGFyZWEgPw0KDQpNeSBhcHBsaWNhdGlvbiBjb2Rl
IGlzIChlcnJvciBjaGVja2luZyBhbmQgb3RoZXIgY29kZSBpcyBvbWl0dGVkKQ0KDQojZGVmaW5l
IAlTSE1fQkFTRSAJMHgxQzAwMDAwMA0KI2RlZmluZQlTSE1fU0laRSAJMHg0MDAwMDAJCS8vIDQg
TUIgb2YgU2hhcmVkIE1lbW9yeQ0KI2RlZmluZSAJUEFHRV9TSVpFIAkoNCoxMDI0KQ0KDQpmZCA9
IG9wZW4oZGV2aWNlLCBPX1JEV1IpOw0KDQpzaG0gPSBtYWxsb2MoU0hNX1NJWkUgKyAoUEFHRV9T
SVpFIC0gMSkpOw0KaWYgKCAodW5zaWduZWQgbG9uZykgc2htICUgUEFHRV9TSVpFKSB7DQoJc2ht
ICs9IFBBR0VfU0laRSAtICgodW5zaWduZWQgbG9uZylzaG0gJSBQQUdFX1NJWkUpOw0KfQ0KDQpz
aG0gPSBtbWFwKHNobSwgU0hNX1NJWkUsIFBST1RfUkVBRHxQUk9UX1dSSVRFLCBNQVBfU0hBUkVE
IHwgTUFQX0ZJWEVELCBmZCwgU0hNX0JBU0UpOw0KLi4uLi4uDQouLi4uLi4gd3JpdGUgc29tZSBz
dHJpbmcgYXQgc2htLg0KDQpNeSBtZW1vcnkgcGFydGl0aW9uaW5nIGZvciBib3RoIHN5c3RlbXMg
aXMgDQoNCkNvcmUgICAgICAgICAgICAgICAgIAkJQmFzZSBBZGRyZXNzICAgICAgICAgCVNpemUN
CkNvcmUgMCAgICAgICAgICAgICAgIAkJMHgwMDAwLDAwMDAgICAgICAgICAgCTB4MTAwMCwwMDAw
DQpDb3JlIDEgICAgICAgICAgICAgICAJCTB4MTAwMCwwMDAwICAgICAgICAgIAkweDBDMDAsMDAw
MA0KU2hhcmVkIE1lbW9yeSAgICAJMHgxQzAwLDAwMDAgICAgICAgICAgCTB4MDQwMCwwMDAwDQoN
ClJlZ2FyZHMsDQpGYXJydWtoIEFyc2hhZC4NCk1lbnRvciBHcmFwaGljcyBQYWtpc3Rhbg0K
