Return-Path: <B40534@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4DB012C02A7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2013 20:51:44 +1100 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: RE: [RFC][PATCH] powerpc: add Book E support to 64-bit hibernation
Date: Fri, 22 Feb 2013 09:50:33 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259E729DB@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1360203915-22112-1-git-send-email-dongsheng.wang@freescale.com>
 <ABB05CD9C9F68C46A5CEDC7F15439259E728F2@039-SN2MPN1-021.039d.mgd.msft.net>
 <1361524129.8146.1.camel@jlt4.sipsolutions.net>
In-Reply-To: <1361524129.8146.1.camel@jlt4.sipsolutions.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Zhao Chenhui-B35336 <B35336@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2hhbm5lcyBCZXJnIFttYWls
dG86am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldF0NCj4gU2VudDogRnJpZGF5LCBGZWJydWFyeSAy
MiwgMjAxMyA1OjA5IFBNDQo+IFRvOiBXYW5nIERvbmdzaGVuZy1CNDA1MzQNCj4gQ2M6IGJlbmhA
a2VybmVsLmNyYXNoaW5nLm9yZzsgbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IFdvb2Qg
U2NvdHQtDQo+IEIwNzQyMTsgTGkgWWFuZy1SNTg0NzI7IFpoYW8gQ2hlbmh1aS1CMzUzMzYNCj4g
U3ViamVjdDogUmU6IFtSRkNdW1BBVENIXSBwb3dlcnBjOiBhZGQgQm9vayBFIHN1cHBvcnQgdG8g
NjQtYml0DQo+IGhpYmVybmF0aW9uDQo+IA0KPiBIaSwNCj4gDQo+ID4gPiBTdWJqZWN0OiBbUkZD
XVtQQVRDSF0gcG93ZXJwYzogYWRkIEJvb2sgRSBzdXBwb3J0IHRvIDY0LWJpdA0KPiA+ID4gaGli
ZXJuYXRpb24NCj4gDQo+ID4gQW55IHRob3VnaHRzIGFib3V0IHRoaXMgcGF0Y2g/DQo+IA0KPiBI
ZWgsIGhvbmVzdGx5LCBuby4gSSBrbm93IG5vdGhpbmcgYWJvdXQgQm9vayBFLCBhbmQgaXQncyB0
b28gbG9uZyBhZ28NCj4gdGhhdCBJIHdyb3RlIChzb21lIG9mKSB0aGUgNjQtYml0IGhpYmVybmF0
aW9uIGNvZGUuDQo+IA0KVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrLg0KDQpDb3VsZCB5b3UgZ2l2
ZSBtZSBzb21lIGFkdmljZSBhYm91dCBjYWNoZSBmbHVzaC4gSXQgY29uZnVzZWQgbWUgdGhhdCB3
aHkNCm9ubHkgMSBNaUIgaXMgZmx1c2hlZCBmcm9tIEtFUk5FTF9TVEFSVCBvbiBQb3dlcm1hYyBH
NS4NCg0KT24gRlNMIEJvb2sgRShlNTAwIGZhbWlseSksIEV2ZW4gaWYgSSBkb24ndCBmbGFzaCBj
YWNoZSwgdGhlIHdvcmsgaXMNCmFsc28gbm9ybWFsKERjYWNoZXMgYXJlIGtlcHQgY29oZXJlbnQg
YnkgaGFyZHdhcmUsIGFuZCBpY2FjaGVzIGFyZSBrZXB0DQpjb2hlcmVudCBieSBzb2Z0d2FyZSku
IEJ1dCBJIHN0aWxsIHdvcnJ5IGFib3V0IGNhY2hlcy4gSXMgdGhlcmUgYSBuZWVkDQp0byBmbHVz
aCBMMiBjYWNoZSBpZiBJIGhhdmUgYWxyZWFkeSBmbHVzaGVkIEwxIGNhY2hlPyANCk9yIG9uIFBv
d2VybWFjIEc1LCBmbHVzaCBjYWNoZXMgaXMgYSBnZW5lcmFsIHdheT8NCg0KUG93ZXJtYWMgRzUg
Q29kZXM6DQogICAgICAgIC8qIGZsdXNoIGNhY2hlcyAqLw0KICAgICAgICBsaXMgICAgIHIzLCAw
eDEwDQogICAgICAgIG10Y3RyICAgcjMNCiAgICAgICAgbGkgICAgICByMywgMA0KICAgICAgICBv
cmkgICAgIHIzLCByMywgQ09ORklHX0tFUk5FTF9TVEFSVD4+NDgNCiAgICAgICAgbGkgICAgICBy
MCwgNDgNCiAgICAgICAgc2xkICAgICByMywgcjMsIHIwDQogICAgICAgIGxpICAgICAgcjAsIDAN
CjE6DQogICAgICAgIGRjYmYgICAgcjAscjMNCiAgICAgICAgYWRkaSAgICByMyxyMywweDIwDQog
ICAgICAgIGJkbnogICAgMWINCg0KICAgICAgICBzeW5jDQoNCiAgICAgICAgdGxiaWENCg0KPiBq
b2hhbm5lcw0KPiANCg==
