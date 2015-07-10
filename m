Return-Path: <roy.pledge@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0102.outbound.protection.outlook.com [157.56.111.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DED741A0F02
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2015 04:29:18 +1000 (AEST)
From: Roy Pledge <roy.pledge@freescale.com>
To: Scott Wood <scottwood@freescale.com>, Paul Bolle <pebolle@tiscali.nl>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 02/11] soc/fsl: Introduce DPAA BMan device management
 driver
Date: Fri, 10 Jul 2015 18:29:08 +0000
Message-ID: <BN3PR0301MB1267E9EFD8CBC294275028B68C9F0@BN3PR0301MB1267.namprd03.prod.outlook.com>
References: <1436473322-21247-1-git-send-email-Roy.Pledge@freescale.com>
 <1436473322-21247-3-git-send-email-Roy.Pledge@freescale.com>
 <1436517510.20619.123.camel@tiscali.nl>
 <1436549503.2658.157.camel@freescale.com>
In-Reply-To: <1436549503.2658.157.camel@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiAgIHJldHVybiBpbl9iZTMyKCh2b2lkICopYm0gKyBvZmZzZXQpOw0KPiA+ICAgICAgICAgIF4N
Cj4gPiBbLi4uXS9kcml2ZXJzL3NvYy9mc2wvcWJtYW4vYm1hbi5jOiBJbiBmdW5jdGlvbiDigJhf
X2JtX291dOKAmToNCj4gPiBbLi4uXS9kcml2ZXJzL3NvYy9mc2wvcWJtYW4vYm1hbi5jOjE3Mjoy
OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24NCj4gPiBvZiBmdW5jdGlvbiDigJhvdXRfYmUz
MuKAmSBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCj4gPiAgIG91dF9i
ZTMyKCh2b2lkICopYm0gKyBvZmZzZXQsIHZhbCk7DQo+IA0KPiBUaGVzZSBQUENpc21zIHdpbGwg
bmVlZCB0byBiZSBmaXhlZC4gIExTMTA0M0EgaXMgYW4gQVJNIGNoaXAgd2l0aCBEUEFBIDEuMC4N
Cg0KTFMxMDQzIChBUk0sIExpdHRsZSBFbmRpYW4pIHN1cHBvcnQgaXMgc3RpbGwgd29yayBpbiBw
cm9ncmVzcy4gIFRoZSBwYXRjaGVzIGZvciB0aGF0IGFyZSBiZWluZyB0ZXN0ZWQgbm93IGJ1dCBh
cmUgYmFzZWQgb24gdGhlIFNESyB2ZXJzaW9uIG9mIHRoZSBkcml2ZXIgYW5kIHdpbGwgbmVlZCB0
byBiZSBtYXNzYWdlZCBpbiBvcmRlciB0byBnZXQgdGhlbSBhcHBsaWVkIGhlcmUuICBPdXIgcGxh
biBvZiByZWNvcmQgaXMgdG8gYWRkIHVwc3RyZWFtIHN1cHBvcnQgZm9yIHRoaXMgYXQgYSBsYXRl
ciB0aW1lLg0KDQo+IA0KPiA+ICAgXg0KPiA+IFsuLi5dL2RyaXZlcnMvc29jL2ZzbC9xYm1hbi9i
bWFuLmM6IEluIGZ1bmN0aW9uIOKAmG9mX2ZzbF9ibWFuX3Byb2Jl4oCZOg0KPiA+IFsuLi5dL2Ry
aXZlcnMvc29jL2ZzbC9xYm1hbi9ibWFuLmM6NDYzOjE3OiBlcnJvcjog4oCYTk9fSVJR4oCZIHVu
ZGVjbGFyZWQNCj4gPiAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pDQo+ID4gICBpZiAoZXJy
X2lycSA9PSBOT19JUlEpIHsNCj4gDQo+IFRoaXMgaXNuJ3QgZXZlbiBhIFBQQ2lzbS4gIEl0J3Mg
anVzdCB3cm9uZy4gIENvbXBhcmUgdG8gemVybyBpbnN0ZWFkLg0KDQpZZWFoIC0gSSByZWNhbGwg
Zml4aW5nIHRoaXMgd2hlbiBkb2luZyB0aGUgQVJNIHBvcnQgYnV0IEkgZ3Vlc3MgSSBkaWRuJ3Qg
bWFrZSB0aGUgc2FtZSBjaGFuZ2UgaW4gdGhpcyB2ZXJzaW9uLiAgSSB3aWxsIGFkZHJlc3MgdGhp
cyBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQoNCj4gDQo+IC1TY290dA0KDQo=
