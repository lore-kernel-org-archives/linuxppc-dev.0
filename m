Return-Path: <R58472@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C2A031007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Dec 2010 19:03:16 +1100 (EST)
From: Li Yang-R58472 <R58472@freescale.com>
To: Thomas Taranowski <tom@baringforge.com>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>
Subject: RE: RapidIO: multiple mport support for QorIQ
Date: Wed, 15 Dec 2010 08:04:45 +0000
Message-ID: <3F607A5180246847A760FD34122A1E0503B1D8@039-SN1MPN1-003.039d.mgd.msft.net>
References: <AANLkTinwP6kQvWjSO3cxNUqd7tx7dhGEShTdKQXj-+iD@mail.gmail.com>
In-Reply-To: <AANLkTinwP6kQvWjSO3cxNUqd7tx7dhGEShTdKQXj-+iD@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiBTdWJqZWN0OiBSYXBpZElPOiBtdWx0aXBsZSBtcG9ydCBzdXBwb3J0IGZvciBRb3JJUQ0KPiAN
Cj4gSSdtIHBsYW5uaW5nIHRvIGFkZCBzdXBwb3J0IGZvciB0aGUgbXVsdGlwbGUoMikgbXBvcnRz
IHN1cHBvcnRlZCBieSB0aGUgRnJlZXNjYWxlDQo+IHAyMDIwIHByb2Nlc3Nvci4gIEknbSBjdXJy
ZW50bHkgbG9va2luZyBhdCB0aGUgZnNsIGxheWVyIHRvIGFkZCBpbiBzdXBwb3J0IGZvcg0KPiBt
dWx0aXBsZSBwb3J0IGVudW1lcmF0aW9uLCBhbmQgd29yayB1cCBmcm9tIHRoZXJlLiAgSXQgbG9v
a3MgbGlrZSB0aGUgdXBwZXINCj4gbGF5ZXJzIGFscmVhZHkgaGF2ZSBhdCBsZWFzdCBwYXJ0aWFs
IHN1cHBvcnQgZm9yIHRoaXMuICBNeSBxdWVzdGlvbiBpcywgYXJlIHRoZXJlDQo+IGFueSBlZmZv
cnRzIGFscmVhZHkgb25nb2luZyBJIGNhbiBob3AgaW4gb24gc28gYXMgbm90IHRvIGR1cGxpY2F0
ZSBlZmZvcnQ/ICBJZiBub3QsDQo+IEknbGwganVzdCBkbyBpdC4NCj4gDQoNCkknbSBub3QgYXdh
cmUgb2Ygc29tZW9uZSB3b3JraW5nIG9uIHRoYXQuDQoNCj4gVGhlcmUgaXMgc29tZSBkaXZlcmdh
bmNlIGluIHJlc3BlY3QgdG8gdGhlIG1lbW9yeSBtYXAgdGhhdCBpcyBub24tdHJpdmlhbCB0aGF0
DQo+IEknbSBub3Qgc3VyZSBob3cgdG8gaGFuZGxlLCBzaW5jZSBpdCB0b3RhbGx5IGhvc2VzIHRo
ZSBjb21tb24gZnNsX3Jpby5jIHN0cnVjdHVyZXMuDQo+IEkgdGhpbmsgSSB3YW50IHRvIGNyZWF0
ZSBhIG5ldyBzZXQgdGhhdCdzIHAyMDIwIHNwZWNpZmljLCBidXQgaGFzIHBvdGVudGlhbCB0byBi
ZQ0KPiBzaGFyZWQgd2l0aCB0aGUgb3RoZXIgUW9ySVEgc2VyaWVzLCBzbyBkdW1waW5nIHRoZSBw
c2VyaWVzLXNwZWNpZmljIGNvZGUgaW50bw0KPiBwbGF0Zm9ybXMvcHNlcmllcyBzZWVtcyBsaWtl
IGEgcmVhc29uYWJsZSB3YXkgdG8gZ28uICBUaG91Z2h0cz8NCg0KVGhlIGR1YWwtcG9ydCBSSU8g
aXMgdmVyeSBjb21tb24gb24gUW9ySVEgY2hpcHMuICBJIHdvbid0IHN1Z2dlc3QgeW91IGFkZCBQ
MjAyMCBzcGVjaWZpYyBtZW1vcnkgbWFwIGZpbGUuICBUaGUgdHdvIHBvcnQgbWVtb3J5IG1hcCBz
aG91bGQgYWxzbyBiZSBjb21wYXRpYmxlIHdpdGggb25lIHBvcnQgZHJpdmVyLg0KDQotTGVvDQoN
Cg==
