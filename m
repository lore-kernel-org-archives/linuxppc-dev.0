Return-Path: <B48286@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0142.outbound.protection.outlook.com [65.55.169.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA5991A02D1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 21:14:41 +1000 (AEST)
From: Hou Zhiqiang <B48286@freescale.com>
To: Hou Zhiqiang <B48286@freescale.com>, "galak@kernel.crashing.org"
 <galak@kernel.crashing.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Scott Wood <scottwood@freescale.com>
CC: Hu Vincent <Mingkai.Hu@freescale.com>, Wang Dongsheng
 <Dongsheng.Wang@freescale.com>
Subject: RE: [PATCH] c293/pci: remove hook pcibios_fixup_phb
Date: Fri, 31 Jul 2015 10:59:47 +0000
Message-ID: <CY1PR0301MB0780F0F41541CBFC5B5998018B8A0@CY1PR0301MB0780.namprd03.prod.outlook.com>
References: <1437473400-11184-1-git-send-email-B48286@freescale.com>
In-Reply-To: <1437473400-11184-1-git-send-email-B48286@freescale.com>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SGkgRG9uZ3NoZW5nIGFuZCBTY290dCwNCg0KRG8geW91IGhhdmUgYW55IGNvbW1lbnQ/DQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmhpcWlhbmcgSG91IFttYWlsdG86
QjQ4Mjg2QGZyZWVzY2FsZS5jb21dDQo+IFNlbnQ6IDIwMTXE6jfUwjIxyNUgMTg6MTANCj4gVG86
IGdhbGFrQGtlcm5lbC5jcmFzaGluZy5vcmc7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3Jn
DQo+IENjOiBIdSBNaW5na2FpLUIyMTI4NDsgV2FuZyBEb25nc2hlbmctQjQwNTM0OyBIb3UgWmhp
cWlhbmctQjQ4Mjg2DQo+IFN1YmplY3Q6IFtQQVRDSF0gYzI5My9wY2k6IHJlbW92ZSBob29rIHBj
aWJpb3NfZml4dXBfcGhiDQo+IA0KPiBGcm9tOiBIb3UgWmhpcWlhbmcgPEI0ODI4NkBmcmVlc2Nh
bGUuY29tPg0KPiANCj4gVGhlIGMyOTNwY2llIGJvYXJkIGlzIGFuIGVuZHBvaW50IGRldmljZSwg
YW5kIGl0IGRvZXMndCBuZWVkIFBNLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSG91IFpoaXFpYW5n
IDxCNDgyODZAZnJlZXNjYWxlLmNvbT4NCj4gLS0tDQo+ICBhcmNoL3Bvd2VycGMvcGxhdGZvcm1z
Lzg1eHgvYzI5M3BjaWUuYyB8IDEgLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzg1eHgvYzI5M3BjaWUu
Yw0KPiBiL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvODV4eC9jMjkzcGNpZS5jDQo+IGluZGV4IDg0
NDc2YjYuLjIxM2Q1YjggMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvODV4
eC9jMjkzcGNpZS5jDQo+ICsrKyBiL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvODV4eC9jMjkzcGNp
ZS5jDQo+IEBAIC02OCw3ICs2OCw2IEBAIGRlZmluZV9tYWNoaW5lKGMyOTNfcGNpZSkgew0KPiAg
CS5pbml0X0lSUQkJPSBjMjkzX3BjaWVfcGljX2luaXQsDQo+ICAjaWZkZWYgQ09ORklHX1BDSQ0K
PiAgCS5wY2liaW9zX2ZpeHVwX2J1cwk9IGZzbF9wY2liaW9zX2ZpeHVwX2J1cywNCj4gLQkucGNp
Ymlvc19maXh1cF9waGIgICAgICA9IGZzbF9wY2liaW9zX2ZpeHVwX3BoYiwNCj4gICNlbmRpZg0K
PiAgCS5nZXRfaXJxCQk9IG1waWNfZ2V0X2lycSwNCj4gIAkucmVzdGFydAkJPSBmc2xfcnN0Y3Jf
cmVzdGFydCwNCj4gLS0NCj4gMi4xLjAuMjcuZzk2ZGIzMjQNCg0KVGhhbmtzLA0KWmhpcWlhbmcN
Cg==
