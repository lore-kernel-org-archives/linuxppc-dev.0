Return-Path: <R61911@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142]) by ozlabs.org (Postfix) with ESMTP id 2E689B70A5
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2010 16:20:40 +1000 (EST)
Received: from mail56-db3 (localhost.localdomain [127.0.0.1])	by
	mail56-db3-R.bigfish.com (Postfix) with ESMTP id 345DFE481BC	for
	<linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2010 06:20:36 +0000 (UTC)
Received: from DB3EHSMHS010.bigfish.com (unknown [10.3.81.249])	by
	mail56-db3.bigfish.com (Postfix) with ESMTP id A0CCCDD004C	for
	<linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2010 06:20:35 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	o8E6KMsF004479	for
	<linuxppc-dev@ozlabs.org>; Mon, 13 Sep 2010 23:20:32 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o8E6ZSMX014234	for <linuxppc-dev@ozlabs.org>;
	Tue, 14 Sep 2010 01:35:29 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: RE: [PATCH v2 3/3][MTD] P4080/mtd: Fix the freescale lbc issue with
	36bit mode
Date: Tue, 14 Sep 2010 14:20:16 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A1FC2D7@zch01exm23.fsl.freescale.net>
In-Reply-To: <1284388075.10955.51.camel@localhost>
References: <1284027632-32573-1-git-send-email-tie-fei.zang@freescale.com>
	<1284027632-32573-2-git-send-email-tie-fei.zang@freescale.com>
	<1284027632-32573-3-git-send-email-tie-fei.zang@freescale.com>
	<20100909114153.GB6622@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A1FC158@zch01exm23.fsl.freescale.net>
	<AANLkTimfKwdw+nLAjDjxf52dbZKLF-3aES+bT7CHskAS@mail.gmail.com>
	<1284388075.10955.51.camel@localhost>
From: Zang Roy-R61911 <r61911@freescale.com>
To: <dedekind1@gmail.com>, "Timur Tabi" <timur.tabi@gmail.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	Lan Chunhe-B25806 <B25806@freescale.com>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	akpm@linux-foundation.org, dwmw2@infradead.org,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJ0ZW0gQml0eXV0c2tp
eSBbbWFpbHRvOmRlZGVraW5kMUBnbWFpbC5jb21dDQo+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVy
IDEzLCAyMDEwIDIyOjI4IFBNDQo+IFRvOiBUaW11ciBUYWJpDQo+IENjOiBaYW5nIFJveS1SNjE5
MTE7IEFudG9uIFZvcm9udHNvdjsgV29vZCBTY290dC1CMDc0MjE7IExhbiBDaHVuaGUtQjI1ODA2
Ow0KPiBsaW51eHBwYy1kZXZAb3psYWJzLm9yZzsgbGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGFrcG1AbGludXgtDQo+IGZvdW5kYXRpb24ub3JnOyBkd213MkBpbmZyYWRlYWQub3JnOyBH
YWxhIEt1bWFyLUIxMTc4MA0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDMvM11bTVREXSBQNDA4
MC9tdGQ6IEZpeCB0aGUgZnJlZXNjYWxlIGxiYyBpc3N1ZSB3aXRoDQo+IDM2Yml0IG1vZGUNCj4g
DQo+IE9uIE1vbiwgMjAxMC0wOS0xMyBhdCAwOToxMCAtMDUwMCwgVGltdXIgVGFiaSB3cm90ZToN
Cj4gPiBPbiBNb24sIFNlcCAxMywgMjAxMCBhdCAyOjMwIEFNLCBaYW5nIFJveS1SNjE5MTEgPHI2
MTkxMUBmcmVlc2NhbGUuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+ID4gV2hhdCBpcyB0aGUgZGlm
ZmVyZW50IGZvciB1bnNpZ25lZCBpbnQgYW5kIHUzMj8gSSB0aGluayB0aGV5IGFyZSBzYW1lLg0K
PiA+DQo+ID4gUm95LCBwbGVhc2UgZG9uJ3QgZXZlciB3cml0ZSBjb2RlIHRoYXQgYXNzdW1lcyB0
aGF0IHNpemVvZihpbnQpID09IDQuDQo+ID4gVGhlcmUncyBhIHJlYXNvbiB3aHkgd2UgaGF2ZSB1
bnNpemVkIGludGVnZXIgdHlwZXMgKGxpa2UgaW50LCBsb25nLA0KPiA+IGFuZCBzaG9ydCkgYW5k
IHNpemVkIGludGVnZXIgdHlwZXMgKGxpa2UgdTgsIHUxNiwgdTMyKS4gIElmIHlvdSB3YW50DQo+
ID4gYW4gaW50ZWdlciBvZiBhIHNwZWNpZmljIHNpemUsIHlvdSBzaG91bGQgdXNlIGEgc2l6ZWQg
aW50ZWdlciB0eXBlLg0KPiANCj4gWWVzLCBzaXplb2YoaW50KSA9PSA0IGFzc3VtcHRpb24gaXMg
bm90IGdvb2QuDQo+IA0KPiBCdXQgc2l6ZW9mKGludCkgPj0gNCBpcyBwZXJmZWN0bHkgZmluZS4N
Cj4gDQo+IEl0IGlzIE9LIHRvIHJlbHkgb24gdGhlIGZhY3QgdGhhdCB1bnNpZ25lZCBpbnQgaXMg
X2F0IGxlYXN0XyAzMi1iaXQsIG5vdA0KPiBsZXNzLiBBbmQgaWYgeW91IGtub3cgMzIgYml0cyBp
cyBlbm91Z2gsIGFuZCB5b3UgYXJlIGZpbmUgd2l0aCBtb3JlLCBpdA0KPiBpcyBfYmV0dGVyXyB0
byBhdm9pZCB1MzIuIFNpbXBseSBiZWNhdXNlIHdpdGggdW5zaWduZWQgaW50IHlvdSBkbyBub3QN
Cj4gbGltaXQgdGhlIGNvbXBpbGVyIGFuZCBDUFUgYW5kIGxldCB0aGVtIHVzZSBuYXRpdmUgaW50
ZWdlcnMsIHJhdGhlciB0aGFuDQo+IHN0cmljdGx5IDMyLWJpdC4gVGhpcyBwb3RlbnRpYWxseSBn
aXZlcyB0aGUgY29tcGlsZXIgYW5kIENQVSBtb3JlIHJvb20NCj4gZm9yIG9wdGltaXphdGlvbi4N
Cj4gDQo+IEkgc2VlIHBlb3BsZSB1c2UgdTMyIGFuZCB0aGUgZnJpZW5kcyB0b28gbXVjaC4gSXQg
aXMgc2FmZSBhbmQgYmV0dGVyIHRvDQo+IHVzZSBuYXRpdmUgdHlwZXMsIHVubGVzcyB5b3UgcmVh
bGx5IGhhdmUgdG8gbWFrZSB0aGUgdmFyaWFibGUgdG8gYmUNCj4gc3RyaWN0bHkgdTMyLg0KPiAN
Cj4gSSBkaWQgbm90IGZvbGxvdyB0aGlzIHBhcnRpY3VsYXIgY29udmVyc2F0aW9uIGFuZCBkbyBu
b3QganVkZ2Ugd2hpY2gNCj4gdHlwZSBpcyBiZXR0ZXIgaW4gdGhpcyBjYXNlLiBJIGFtIHRhbGtp
bmcgaW4gZ2VuZXJhbC4gOi0pDQoNClRoZSBmdW5jdGlvbiB3aWxsIHJldHVybiBmaXhlZCAzMmJp
dC4gc28gdTMyIHNob3VsZCBiZSBPSy4NClRoYW5rcy4NClJveQ0K
