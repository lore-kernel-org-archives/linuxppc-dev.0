Return-Path: <R61911@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by ozlabs.org (Postfix) with ESMTP id 1F264B70E2
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 20:39:53 +1000 (EST)
Received: from mail98-tx2 (localhost.localdomain [127.0.0.1])	by
	mail98-tx2-R.bigfish.com (Postfix) with ESMTP id D3527F583DA	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 10:39:50 +0000 (UTC)
Received: from TX2EHSMHS033.bigfish.com (unknown [10.9.14.253])	by
	mail98-tx2.bigfish.com (Postfix) with ESMTP id 870011B78046	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 10:39:50 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o8GAdj6J005809	for <linuxppc-dev@ozlabs.org>;
	Thu, 16 Sep 2010 03:39:45 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP
	id o8GAqMep026882	for <linuxppc-dev@ozlabs.org>;
	Thu, 16 Sep 2010 05:52:23 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: RE: [PATCH 2/3 v3] P4080/mtd: Only make elbc nand driver detect nand
	flash partitions
Date: Thu, 16 Sep 2010 18:39:40 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A1FC6E1@zch01exm23.fsl.freescale.net>
In-Reply-To: <20100916101429.GA27393@oksana.dev.rtsoft.ru>
References: <1284619284-23614-1-git-send-email-tie-fei.zang@freescale.com>
	<1284619284-23614-2-git-send-email-tie-fei.zang@freescale.com>
	<20100916082141.GA10978@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A1FC6B8@zch01exm23.fsl.freescale.net>
	<20100916092551.GA17548@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A1FC6DB@zch01exm23.fsl.freescale.net>
	<20100916101429.GA27393@oksana.dev.rtsoft.ru>
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
bWJlciAxNiwgMjAxMCAxODoxNCBQTQ0KPiBUbzogWmFuZyBSb3ktUjYxOTExDQo+IENjOiBXb29k
IFNjb3R0LUIwNzQyMTsgZGVkZWtpbmQxQGdtYWlsLmNvbTsgTGFuIENodW5oZS1CMjU4MDY7IGxp
bnV4cHBjLQ0KPiBkZXZAb3psYWJzLm9yZzsgbGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7DQo+IGR3bXcyQGluZnJhZGVhZC5vcmc7IEdhbGEg
S3VtYXItQjExNzgwDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8zIHYzXSBQNDA4MC9tdGQ6IE9u
bHkgbWFrZSBlbGJjIG5hbmQgZHJpdmVyIGRldGVjdCBuYW5kDQo+IGZsYXNoIHBhcnRpdGlvbnMN
Cj4gDQo+IE9uIFRodSwgU2VwIDE2LCAyMDEwIGF0IDA2OjA4OjE0UE0gKzA4MDAsIFphbmcgUm95
LVI2MTkxMSB3cm90ZToNCj4gWy4uLl0NCj4gPiBJbnRlcmVzdGluZy4NCj4gPiBIb3cgYWJvdXQg
dGhpcz8NCj4gPiAjaW5jbHVkZSA8c3RkaW8uaD4NCj4gPiAjaW5jbHVkZSA8bWFsbG9jLmg+DQo+
ID4NCj4gPiBjaGFyICpmb287DQo+ID4NCj4gPiB2b2lkIHByb2JlKHZvaWQpDQo+ID4gew0KPiA+
ICAgICAgICAgY2hhciAqYmFyID0gTlVMTDsNCj4gPg0KPiA+ICAgICAgICAgaWYgKCFmb28pIHsN
Cj4gPiAgICAgICAgICAgICAgICAgYmFyID0gbWFsbG9jKHNpemVvZigqYmFyKSk7DQo+ID4gICAg
ICAgICAgICAgICAgIGlmICghYmFyKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVy
bjsNCj4gPiAgICAgICAgICAgICAgICAgZm9vID0gYmFyOw0KPiA+ICAgICAgICAgfSBlbHNlDQo+
ID4gCQkgICBiYXIgPSBmb287DQo+IA0KPiBUaGlzIHdpbGxsIHdvcmsgb2YgY291cnNlOyBidXQg
SSdkIHdyaXRlIGl0IGFzDQo+IA0KPiBmb29fbG9jaygpOw0KPiBpZiAoIWZvbykNCj4gCWZvbyA9
IGFsbG9jKCk7DQo+IGZvb191bmxvY2soKTsNCj4gDQo+IGJhciA9IGZvbzsNCj4gYmFyLT5iYXo7
DQpCdXQgbXkgY29kZSBoYXMgc29tZSBhc3NpZ25tZW50IGZvciAiZm9vIiBpbnN0ZWFkIG9mIGEg
c2ltcGxlDQphbGxvY2F0aW9uLCBob3cgYWJvdXQgdGhpcyB3YXkgZm9yIG15IGNvZGU6DQpERUZJ
TkVfTVVURVgoZnNsX2VsYmNfbXV0ZXgpOw0KLi4uDQpzdGF0aWMgaW50IF9fZGV2aW5pdCBmc2xf
ZWxiY19uYW5kX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmRldikNCnsNCi4uLg0KICAg
ICAgICBtdXRleF9sb2NrKCZmc2xfbGJjX211dGV4KTsNCiAgICAgICAgaWYgKCFmc2xfbGJjX2N0
cmxfZGV2LT5uYW5kKSB7DQogICAgICAgICAgICAgICAgZWxiY19mY21fY3RybCA9IGt6YWxsb2Mo
c2l6ZW9mKCplbGJjX2ZjbV9jdHJsKSwgR0ZQX0tFUk5FTCk7DQogICAgICAgICAgICAgICAgaWYg
KCFlbGJjX2ZjbV9jdHJsKSB7DQogICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKGZzbF9s
YmNfY3RybF9kZXYtPmRldiwgImZhaWxlZCB0byBhbGxvY2F0ZSAiDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIm1lbW9yeVxuIik7DQogICAgICAgICAgICAgICAgICAg
ICAgICByZXQgPSAtRU5PTUVNOw0KICAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnI7DQog
ICAgICAgICAgICAgICAgfQ0KDQogICAgICAgICAgICAgICAgZWxiY19mY21fY3RybC0+cmVhZF9i
eXRlcyA9IDA7DQogICAgICAgICAgICAgICAgZWxiY19mY21fY3RybC0+aW5kZXggPSAwOw0KICAg
ICAgICAgICAgICAgIGVsYmNfZmNtX2N0cmwtPmFkZHIgPSBOVUxMOw0KDQogICAgICAgICAgICAg
ICAgc3Bpbl9sb2NrX2luaXQoJmVsYmNfZmNtX2N0cmwtPmNvbnRyb2xsZXIubG9jayk7DQogICAg
ICAgICAgICAgICAgaW5pdF93YWl0cXVldWVfaGVhZCgmZWxiY19mY21fY3RybC0+Y29udHJvbGxl
ci53cSk7DQogICAgICAgICAgICAgICAgZnNsX2xiY19jdHJsX2Rldi0+bmFuZCA9IGVsYmNfZmNt
X2N0cmw7DQogICAgICAgIH0gZWxzZQ0KICAgICAgICAgICAgICAgIGVsYmNfZmNtX2N0cmwgPSBm
c2xfbGJjX2N0cmxfZGV2LT5uYW5kOw0KICAgICAgICBtdXRleF91bmxvY2soJmZzbF9sYmNfbXV0
ZXgpOw0KDQogICAgICAgIGVsYmNfZmNtX2N0cmwtPmNoaXBzW2JhbmtdID0gcHJpdjsNCi4uLg0K
fQ0KDQpBbnkgY29tbWVudD8NClRoYW5rcy4NClJveQ0KDQoNCg0K
