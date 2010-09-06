Return-Path: <R61911@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by ozlabs.org (Postfix) with ESMTP id 0074FB70ED
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Sep 2010 13:40:13 +1000 (EST)
Received: from mail157-tx2 (localhost.localdomain [127.0.0.1])	by
	mail157-tx2-R.bigfish.com (Postfix) with ESMTP id 28C091440516	for
	<linuxppc-dev@ozlabs.org>; Mon,  6 Sep 2010 03:40:10 +0000 (UTC)
Received: from TX2EHSMHS020.bigfish.com (unknown [10.9.14.247])	by
	mail157-tx2.bigfish.com (Postfix) with ESMTP id BBE2052804E	for
	<linuxppc-dev@ozlabs.org>; Mon,  6 Sep 2010 03:40:08 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o863e6xo013437	for
	<linuxppc-dev@ozlabs.org>; Sun, 5 Sep 2010 20:40:07 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o863suOT027999	for <linuxppc-dev@ozlabs.org>;
	Sun, 5 Sep 2010 22:54:57 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: RE: [PATCH 2/3][MTD] P4080/nand: Only make elbc nand driver detect
	nand flash partitions
Date: Mon, 6 Sep 2010 11:40:03 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A1B3791@zch01exm23.fsl.freescale.net>
In-Reply-To: <20100903114357.GC11847@oksana.dev.rtsoft.ru>
References: <1281063096-26598-1-git-send-email-tie-fei.zang@freescale.com>
	<1281063096-26598-2-git-send-email-tie-fei.zang@freescale.com>
	<20100903114357.GC11847@oksana.dev.rtsoft.ru>
From: Zang Roy-R61911 <r61911@freescale.com>
To: "Anton Vorontsov" <cbouatmailru@gmail.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	Lan Chunhe-B25806 <B25806@freescale.com>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	akpm@linux-foundation.org, Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW50b24gVm9yb250c292
IFttYWlsdG86Y2JvdWF0bWFpbHJ1QGdtYWlsLmNvbV0NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1i
ZXIgMDMsIDIwMTAgMTk6NDQgUE0NCj4gVG86IFphbmcgUm95LVI2MTkxMQ0KPiBDYzogbGludXgt
bXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IExhbiBDaHVuaGUtQjI1ODA2OyBsaW51eHBwYy1kZXZA
b3psYWJzLm9yZzsNCj4gYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsgR2FsYSBLdW1hci1CMTE3
ODA7IFdvb2QgU2NvdHQtQjA3NDIxDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8zXVtNVERdIFA0
MDgwL25hbmQ6IE9ubHkgbWFrZSBlbGJjIG5hbmQgZHJpdmVyIGRldGVjdA0KPiBuYW5kIGZsYXNo
IHBhcnRpdGlvbnMNCj4gDQo+IE9uIEZyaSwgQXVnIDA2LCAyMDEwIGF0IDEwOjUxOjM1QU0gKzA4
MDAsIFJveSBaYW5nIHdyb3RlOg0KPiBbLi4uXQ0KPiA+DQo+ID4gK3N0YXRpYyBzdHJ1Y3QgZnNs
X2VsYmNfZmNtX2N0cmwgKmVsYmNfZmNtX2N0cmw7DQo+ID4gKw0KPiANCj4gQXJlIHlvdSBzdXJl
IHRoYXQgeW91IHdhbnQgaXQgYXMgYSBnbG9iYWwgdmFyPyBBIGJpdCBzY2FyeSBjaGFuZ2UuDQo+
IA0KPiBPaCwgeW91IHByb2JhYmx5IGRvbid0IG5lZWQgaXQsIGFzIHlvdSBjYW4gZ2V0IGl0IGZy
b20NCj4gZnNsX2xiY19jdHJsX2Rldi0+bmFuZD8NCj4gDQo+IEkgd29uZGVyIGlmIFNjb3R0IHNh
dyB0aGVzZSBwYXRjaGVzPyBDYydlZC4NClllcy4NClJveQ0K
