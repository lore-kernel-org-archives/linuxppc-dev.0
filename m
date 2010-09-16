Return-Path: <R61911@freescale.com>
Received: from TX2EHSOBE010.bigfish.com (tx2ehsobe005.messaging.microsoft.com
	[65.55.88.15]) by ozlabs.org (Postfix) with ESMTP id 464EFB6EDD
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 17:36:50 +1000 (EST)
Received: from mail122-tx2 (localhost.localdomain [127.0.0.1])	by
	mail122-tx2-R.bigfish.com (Postfix) with ESMTP id BB1209B0446	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 07:36:46 +0000 (UTC)
Received: from TX2EHSMHS047.bigfish.com (unknown [10.9.14.237])	by
	mail122-tx2.bigfish.com (Postfix) with ESMTP id 79139B20046	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 07:36:46 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o8G7ajL3007592	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 00:36:45 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP
	id o8G7owNA023289	for <linuxppc-dev@ozlabs.org>;
	Thu, 16 Sep 2010 02:50:59 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: RE: [PATCH 3/3 v3] P4080/mtd: Fix the freescale lbc issue with 36bit
	mode
Date: Thu, 16 Sep 2010 15:36:38 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A1FC68A@zch01exm23.fsl.freescale.net>
In-Reply-To: <20100916073135.GA5431@oksana.dev.rtsoft.ru>
References: <1284619284-23614-1-git-send-email-tie-fei.zang@freescale.com>
	<1284619284-23614-2-git-send-email-tie-fei.zang@freescale.com>
	<1284619284-23614-3-git-send-email-tie-fei.zang@freescale.com>
	<20100916073135.GA5431@oksana.dev.rtsoft.ru>
From: Zang Roy-R61911 <r61911@freescale.com>
To: "Anton Vorontsov" <cbouatmailru@gmail.com>
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
IFttYWlsdG86Y2JvdWF0bWFpbHJ1QGdtYWlsLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIFNlcHRl
bWJlciAxNiwgMjAxMCAxNTozMiBQTQ0KPiBUbzogWmFuZyBSb3ktUjYxOTExDQo+IENjOiBsaW51
eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZHdtdzJAaW5mcmFkZWFkLm9yZzsgZGVkZWtpbmQx
QGdtYWlsLmNvbTsNCj4gYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsgTGFuIENodW5oZS1CMjU4
MDY7IFdvb2QgU2NvdHQtQjA3NDIxOyBHYWxhIEt1bWFyLQ0KPiBCMTE3ODA7IGxpbnV4cHBjLWRl
dkBvemxhYnMub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8zIHYzXSBQNDA4MC9tdGQ6IEZp
eCB0aGUgZnJlZXNjYWxlIGxiYyBpc3N1ZSB3aXRoIDM2Yml0DQo+IG1vZGUNCj4gDQo+IE9uIFRo
dSwgU2VwIDE2LCAyMDEwIGF0IDAyOjQxOjI0UE0gKzA4MDAsIFJveSBaYW5nIHdyb3RlOg0KPiA+
IEZyb206IExhbiBDaHVuaGUtQjI1ODA2IDxiMjU4MDZAZnJlZXNjYWxlLmNvbT4NCj4gPg0KPiA+
IFdoZW4gc3lzdGVtIHVzZXMgMzZiaXQgcGh5c2ljYWwgYWRkcmVzcywgcmVzLnN0YXJ0IGlzIDM2
Yml0DQo+ID4gcGh5c2ljYWwgYWRkcmVzcy4gQnV0IHRoZSBmdW5jdGlvbiBvZiBpbl9iZTMyIHJl
dHVybnMgMzJiaXQNCj4gPiBwaHlzaWNhbCBhZGRyZXNzLiBUaGVuIGJvdGggb2YgdGhlbSBjb21w
YXJlZCBlYWNoIG90aGVyIGlzDQo+ID4gd3JvbmcuIFNvIGJ5IGNvbnZlcnRpbmcgdGhlIGFkZHJl
c3Mgb2YgcmVzLnN0YXJ0IGludG8NCj4gPiB0aGUgcmlnaHQgZm9ybWF0IGZpeGVzIHRoaXMgaXNz
dWUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMYW4gQ2h1bmhlLUIyNTgwNiA8YjI1ODA2QGZy
ZWVzY2FsZS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUm95IFphbmcgPHRpZS1mZWkuemFuZ0Bm
cmVlc2NhbGUuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vZnNs
X2xiYy5oIHwgICAgMSArDQo+ID4gIGFyY2gvcG93ZXJwYy9zeXNkZXYvZnNsX2xiYy5jICAgICAg
fCAgIDIzICsrKysrKysrKysrKysrKysrKysrKystDQo+ID4gIGRyaXZlcnMvbXRkL25hbmQvZnNs
X2VsYmNfbmFuZC5jICAgfCAgICAyICstDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2Vy
cGMvaW5jbHVkZS9hc20vZnNsX2xiYy5oDQo+IGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL2Zz
bF9sYmMuaA0KPiA+IGluZGV4IGRiOTQ2OTguLjU2MzhiMWUgMTAwNjQ0DQo+ID4gLS0tIGEvYXJj
aC9wb3dlcnBjL2luY2x1ZGUvYXNtL2ZzbF9sYmMuaA0KPiA+ICsrKyBiL2FyY2gvcG93ZXJwYy9p
bmNsdWRlL2FzbS9mc2xfbGJjLmgNCj4gPiBAQCAtMjQ2LDYgKzI0Niw3IEBAIHN0cnVjdCBmc2xf
dXBtIHsNCj4gPiAgCWludCB3aWR0aDsNCj4gPiAgfTsNCj4gPg0KPiA+ICtleHRlcm4gdW5zaWdu
ZWQgaW50IGZzbF9sYmNfYWRkcihwaHlzX2FkZHJfdCBhZGRyX2Jhc2UpOw0KPiANCj4gdTMyIGhl
cmUuDQo+IA0KPiBPdGhlciB0aGFuIHRoYXQsIHRoZSBwYXRjaCBsb29rcyBnb29kLg0KPiANCj4g
UmV2aWV3ZWQtYnk6IEFudG9uIFZvcm9udHNvdiA8Y2JvdWF0bWFpbHJ1QGdtYWlsLmNvbT4NCkkg
d2lsbCBjb3JyZWN0IHRoaXMgdG9nZXRoZXIgd2l0aCBwcmV2aW91cyBwYXRjaGVzLg0KRG8geW91
IGhhdmUgYW55IG1vcmUgY29tbWVudHMgZm9yIHRoZSBwcmV2aW91cyB0d28gcGF0Y2hlcz8NClRo
YW5rcy4NClJveQ0K
