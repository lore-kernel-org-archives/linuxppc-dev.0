Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E3DB6DDECF
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Aug 2008 18:55:51 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m748teJk029775
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Aug 2008 01:55:40 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m748tcbN026242
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Aug 2008 03:55:39 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Subject: RE: [2.6 patch] sata_fsl.c: fix 8315DS workaround
Date: Mon, 4 Aug 2008 16:55:37 +0800
Message-ID: <A94B04433DF4F44C9C2AB5DEFBF29A4E05E1E7@zch01exm26.fsl.freescale.net>
In-Reply-To: <20080804084611.GA6088@cs181140183.pp.htv.fi>
References: <20080804084611.GA6088@cs181140183.pp.htv.fi>
From: "Li Yang" <LeoLi@freescale.com>
To: "Adrian Bunk" <bunk@kernel.org>,
	"Kalra Ashish" <ashish.kalra@freescale.com>,
	"Jeff Garzik" <jeff@garzik.org>, <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, "Robert P. J. Day" <rpjday@crashcourse.ca>,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBZHJpYW4gQnVuayBbbWFpbHRv
OmJ1bmtAa2VybmVsLm9yZ10gDQo+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDA0LCAyMDA4IDQ6NDYg
UE0NCj4gVG86IEthbHJhIEFzaGlzaDsgTGkgWWFuZzsgSmVmZiBHYXJ6aWs7IGdhbGFrQGtlcm5l
bC5jcmFzaGluZy5vcmcNCj4gQ2M6IGxpbnV4cHBjLWRldkBvemxhYnMub3JnOyBsaW51eC1pZGVA
dmdlci5rZXJuZWwub3JnOyANCj4gUm9iZXJ0IFAuIEouIERheQ0KPiBTdWJqZWN0OiBbMi42IHBh
dGNoXSBzYXRhX2ZzbC5jOiBmaXggODMxNURTIHdvcmthcm91bmQNCj4gDQo+IENvbW1pdCBlN2Vh
Yzk2ZThmMGU1N2E2ZTlmOTQ5NDM1NTdiYzJiMjNiZTMxNDcxIA0KPiAoYXRhL3NhdGFfZnNsOiBN
b3ZlIE1QQzgzMTVEUyBsaW5rIHNwZWVkIGxpbWl0IHdvcmthcm91bmQgdG8gDQo+IHNwZWNpZmlj
IGlmZGVmKSBhaW1lZCBhdCBsaW1pdGluZyB0aGUgd29ya2Fyb3VuZCBvbmx5IHRvIHRoZSANCj4g
YWZmZWN0ZWQgaGFyZHdhcmUsIGJ1dCBzaW5jZSB0aGUgI2lmZGVmIHVzZWQgYSBub25leGlzdGlu
ZyANCj4ga2NvbmZpZyB2YXJpYWJsZSBpdCBhY3R1YWxseSBraWxsZWQgdGhlIHdvcmthcm91bmQu
DQoNClRoaXMgd29ya2Fyb3VuZCBpcyBvbmx5IGZvciBNUEM4MzE1X0RTIGJvYXJkIHdoaWNoIGlz
IG5vdCBzdXBwb3J0ZWQgaW4gdGhlIG1haW4gbGluZSB5ZXQuICBXZSBjYW4gcmVtb3ZlIHRoZSB3
b3JrYXJvdW5kIGlmIHdlIG5lZWQgdG8gZG8gc29tZXRoaW5nIGhlcmUuDQoNCi0gTGVvDQoNCj4g
DQo+IFJlcG9ydGVkLWJ5OiBSb2JlcnQgUC4gSi4gRGF5IDxycGpkYXlAY3Jhc2hjb3Vyc2UuY2E+
DQo+IFNpZ25lZC1vZmYtYnk6IEFkcmlhbiBCdW5rIDxidW5rQGtlcm5lbC5vcmc+DQo+IA0KPiAt
LS0NCj4gY2Q1NGRkOGI2YThiY2E0NGVhZDIxMmQxMmZlMTE2NzAyY2MzMWVkNw0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9hdGEvc2F0YV9mc2wuYyBiL2RyaXZlcnMvYXRhL3NhdGFfZnNsLmMgDQo+
IGluZGV4IDM5MjRlNzIuLjQ1ODc4ZWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYXRhL3NhdGFf
ZnNsLmMNCj4gKysrIGIvZHJpdmVycy9hdGEvc2F0YV9mc2wuYw0KPiBAQCAtNjQwLDcgKzY0MCw3
IEBAIHN0YXRpYyBpbnQgc2F0YV9mc2xfcG9ydF9zdGFydChzdHJ1Y3QgDQo+IGF0YV9wb3J0ICph
cCkNCj4gIAlWUFJJTlRLKCJIQ29udHJvbCA9IDB4JXhcbiIsIGlvcmVhZDMyKGhjcl9iYXNlICsg
SENPTlRST0wpKTsNCj4gIAlWUFJJTlRLKCJDSEJBICA9IDB4JXhcbiIsIGlvcmVhZDMyKGhjcl9i
YXNlICsgQ0hCQSkpOw0KPiAgDQo+IC0jaWZkZWYgQ09ORklHX01QQzgzMTVfRFMNCj4gKyNpZmRl
ZiBDT05GSUdfTVBDODMxeF9SREINCj4gIAkvKg0KPiAgCSAqIFdvcmthcm91bmQgZm9yIDgzMTVE
UyBib2FyZCAzZ2JwcyBsaW5rLXVwIGlzc3VlLA0KPiAgCSAqIGN1cnJlbnRseSBsaW1pdCBTQVRB
IHBvcnQgdG8gR0VOMSBzcGVlZA0KPiANCj4gDQo=
