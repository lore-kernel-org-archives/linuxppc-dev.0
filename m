Return-Path: <R61911@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0BA2CB70CD
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Oct 2010 22:40:29 +1000 (EST)
Received: from mail39-tx2 (localhost.localdomain [127.0.0.1])	by
	mail39-tx2-R.bigfish.com (Postfix) with ESMTP id B315130618	for
	<linuxppc-dev@ozlabs.org>; Sat,  2 Oct 2010 12:40:25 +0000 (UTC)
Received: from TX2EHSMHS026.bigfish.com (unknown [10.9.14.251])	by
	mail39-tx2.bigfish.com (Postfix) with ESMTP id 8C9B14F0051	for
	<linuxppc-dev@ozlabs.org>; Sat,  2 Oct 2010 12:39:54 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o92Cdrqf011076	for <linuxppc-dev@ozlabs.org>;
	Sat, 2 Oct 2010 05:39:53 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP
	id o92CaTmt023108	for <linuxppc-dev@ozlabs.org>;
	Sat, 2 Oct 2010 07:36:30 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: RE: [PATCH 2/3 v4] P4080/mtd: Only make elbc nand driver detect nand
	flash partitions
Date: Sat, 2 Oct 2010 20:36:27 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A256099@zch01exm23.fsl.freescale.net>
In-Reply-To: <20100920131907.GA2184@oksana.dev.rtsoft.ru>
References: <1284706869-12555-1-git-send-email-tie-fei.zang@freescale.com>
	<1284706869-12555-2-git-send-email-tie-fei.zang@freescale.com>
	<20100920131907.GA2184@oksana.dev.rtsoft.ru>
From: Zang Roy-R61911 <r61911@freescale.com>
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>, dedekind1@gmail.com,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW50b24gVm9yb250c292
IFttYWlsdG86Y2JvdWF0bWFpbHJ1QGdtYWlsLmNvbV0NCj4gU2VudDogTW9uZGF5LCBTZXB0ZW1i
ZXIgMjAsIDIwMTAgMjE6MTkgUE0NCj4gVG86IFphbmcgUm95LVI2MTkxMQ0KPiBDYzogbGludXgt
bXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IGR3bXcyQGluZnJhZGVhZC5vcmc7IGRlZGVraW5kMUBn
bWFpbC5jb207DQo+IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7IExhbiBDaHVuaGUtQjI1ODA2
OyBXb29kIFNjb3R0LUIwNzQyMTsgR2FsYSBLdW1hci0NCj4gQjExNzgwOyBsaW51eHBwYy1kZXZA
b3psYWJzLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMyB2NF0gUDQwODAvbXRkOiBPbmx5
IG1ha2UgZWxiYyBuYW5kIGRyaXZlciBkZXRlY3QgbmFuZA0KPiBmbGFzaCBwYXJ0aXRpb25zDQo+
IA0KPiBPbiBGcmksIFNlcCAxNywgMjAxMCBhdCAwMzowMTowOFBNICswODAwLCBSb3kgWmFuZyB3
cm90ZToNCj4gWy4uLl0NCj4gPiArc3RhdGljIHN0cnVjdCBtdXRleCBmc2xfZWxiY19uYW5kX211
dGV4Ow0KPiA+ICsNCj4gPiArc3RhdGljIGludCBfX2RldmluaXQgZnNsX2VsYmNfbmFuZF9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYpDQo+ID4gIHsNCj4gPiAtCXN0cnVjdCBmc2xf
bGJjX3JlZ3MgX19pb21lbSAqbGJjID0gY3RybC0+cmVnczsNCj4gPiArCXN0cnVjdCBmc2xfbGJj
X3JlZ3MgX19pb21lbSAqbGJjOw0KPiA+ICAJc3RydWN0IGZzbF9lbGJjX210ZCAqcHJpdjsNCj4g
PiAgCXN0cnVjdCByZXNvdXJjZSByZXM7DQo+ID4gKwlzdHJ1Y3QgZnNsX2VsYmNfZmNtX2N0cmwg
KmVsYmNfZmNtX2N0cmwgPSBOVUxMOw0KPiANCj4gTm8gbmVlZCBmb3IgPSBOVUxMLg0KQW55IGhh
cm0/IE9yIGp1c3QgcGVyc29uYWwgaGFiaXQgb3Igc3R5bGU/IENhbiB5b3UgZXhwbGFpbiBhYm91
dCB3aHk/DQpUaGFua3MuDQpSb3kNCg==
