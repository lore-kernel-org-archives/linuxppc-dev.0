Return-Path: <B40534@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2B00D2C0093
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2012 12:01:13 +1000 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH v2 2/2] powerpc/mpic: add global timer support
Date: Tue, 14 Aug 2012 02:00:50 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259DB1984@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1344578081-8095-1-git-send-email-Dongsheng.wang@freescale.com>
 <50257116.3030207@freescale.com>
 <ABB05CD9C9F68C46A5CEDC7F15439259DB14CA@039-SN2MPN1-022.039d.mgd.msft.net>
 <50293B36.1000408@freescale.com>
In-Reply-To: <50293B36.1000408@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Gala Kumar-B11780 <B11780@freescale.com>,
 "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDE0LCAyMDEyIDE6MzcgQU0NCj4gVG86IFdhbmcg
RG9uZ3NoZW5nLUI0MDUzNA0KPiBDYzogV29vZCBTY290dC1CMDc0MjE7IGJlbmhAa2VybmVsLmNy
YXNoaW5nLm9yZzsgcGF1bHVzQHNhbWJhLm9yZzsNCj4gbGludXhwcGMtZGV2QGxpc3RzLm96bGFi
cy5vcmc7IEdhbGEgS3VtYXItQjExNzgwOyBMaSBZYW5nLVI1ODQ3Mg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYyIDIvMl0gcG93ZXJwYy9tcGljOiBhZGQgZ2xvYmFsIHRpbWVyIHN1cHBvcnQNCj4g
DQo+IE9uIDA4LzEzLzIwMTIgMDE6MTggQU0sIFdhbmcgRG9uZ3NoZW5nLUI0MDUzNCB3cm90ZToN
Cj4gPj4+ICsJcCA9IG9mX2dldF9wcm9wZXJ0eShucCwgImF2YWlsYWJsZS1yYW5nZXMiLCAmbGVu
KTsNCj4gPj4+ICsJaWYgKHAgJiYgbGVuICUgKDIgKiBzaXplb2YodTMyKSkgIT0gMCkgew0KPiA+
Pj4gKwkJcHJfZXJyKCIlczogbWFsZm9ybWVkIGZzbCxhdmFpbGFibGUtcmFuZ2VzIHByb3BlcnR5
LlxuIiwNCj4gPj4+ICsJCQkJbnAtPmZ1bGxfbmFtZSk7DQo+ID4+PiArCQlyZXR1cm4gLUVJTlZB
TDsNCj4gPj4+ICsJfQ0KPiA+Pg0KPiA+PiBZb3UgbmVlZCB0byBzdXBwb3J0IGZzbCxhdmFpbGFi
bGUtcmFuZ2VzIHNpbmNlIHRoYXQncyBpbiBhbiBhY2NlcHRlZA0KPiA+PiBiaW5kaW5nIGFuZCBw
ZW9wbGUgY291bGQgaGF2ZSBwYXJ0aXRpb25lZCBzZXR1cHMgYWxyZWFkeSB1c2luZyBpdC4NCj4g
Pj4NCj4gPiBbV2FuZyBEb25nc2hlbmddIEZTTCBjaGlwIG9yIE9QRU4tUElDIHNwZWNpZmljYXRp
b24oT25seSBhIGdyb3VwKSBpbg0KPiA+IGVhY2ggZ3JvdXAgb25seSBmb3VyIHRpbWVyLiBUaGlz
IGlzIHVuaWZpZWQuIFNvIGkgdXNlIGEgZ2VuZXJpYyBuYW1lLg0KPiA+IEkgdGhpbmsgdGhlcmUg
aXMgbm90IGNvbXBhdGlibGUgd2l0aCBleGlzdGluZyBtcGljIHRpbWVyIG5vZGVzLg0KPiANCj4g
V2UgbmVlZCB0byBiZSBjb21wYXRpYmxlIHdpdGggZXhpc3RpbmcgdHJlZXMsIHNvIHlvdSdkIG5l
ZWQgdG8gY2hlY2sgZm9yDQo+IGJvdGggLS0gYnV0IEkgdGhpbmsgYW55IGZ1cnRoZXIgZGlzY3Vz
c2lvbiBvZiB0aGUgZGV0YWlscyBpcyBwcmVtYXR1cmUNCj4gdW50aWwgd2UgZGVjaWRlIHdoZXRo
ZXIgdGhpcyBpcyB3b3J0aHdoaWxlIHRvIGJlZ2luIHdpdGggKGJvdGggdGhlDQo+IHN1cHBvcnQg
b2Ygbm9uLUZTTCB0aW1lcnMsIGFuZCB0aGUgY3JlYXRpb24gb2YgYSBuZXcgZGV2aWNlIHRyZWUg
YmluZGluZw0KPiB3aGljaCB3aWxsIG5vdCBiZSBpbXBsZW1lbnRlZCBieSBtYW55IG9mIHRoZSBt
YWNoaW5lcyB0aGF0IGhhdmUgbm9uLUZTTA0KPiBvcGVucGljIGJlY2F1c2UgdGhleSBydW4gcmVh
bCBPcGVuIEZpcm13YXJlKS4NCj4gDQpbV2FuZyBEb25nc2hlbmddIA0KCXAgPSBvZl9nZXRfcHJv
cGVydHkobnAsICJhdmFpbGFibGUtcmFuZ2VzIiwgJmxlbik7DQoJaWYgKCFwKQ0KCQlwID0gb2Zf
Z2V0X3Byb3BlcnR5KG5wLCAiZnNsLGF2YWlsYWJsZS1yYW5nZXMiLCAmbGVuKTsNCgkNCgl0aGlz
IGNvZGUgYmUgY29tcGF0aWJsZSB3aXRoIGV4aXN0aW5nIHRyZWVzLg0KCQ0KPiAtU2NvdHQNCg0K
