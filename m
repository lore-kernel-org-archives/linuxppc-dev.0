Return-Path: <R61911@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by ozlabs.org (Postfix) with ESMTP id 717E81007D8
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 20:08:26 +1000 (EST)
Received: from mail104-tx2 (localhost.localdomain [127.0.0.1])	by
	mail104-tx2-R.bigfish.com (Postfix) with ESMTP id E94ACA9819D	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 10:08:22 +0000 (UTC)
Received: from TX2EHSMHS020.bigfish.com (unknown [10.9.14.238])	by
	mail104-tx2.bigfish.com (Postfix) with ESMTP id 9208A9E8052	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 10:08:22 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	o8GA8K7d028830	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 03:08:20 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP
	id o8GAMXVO010686	for <linuxppc-dev@ozlabs.org>;
	Thu, 16 Sep 2010 05:22:34 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: RE: [PATCH 2/3 v3] P4080/mtd: Only make elbc nand driver detect nand
	flash partitions
Date: Thu, 16 Sep 2010 18:08:14 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A1FC6DB@zch01exm23.fsl.freescale.net>
In-Reply-To: <20100916092551.GA17548@oksana.dev.rtsoft.ru>
References: <1284619284-23614-1-git-send-email-tie-fei.zang@freescale.com>
	<1284619284-23614-2-git-send-email-tie-fei.zang@freescale.com>
	<20100916082141.GA10978@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A1FC6B8@zch01exm23.fsl.freescale.net>
	<20100916092551.GA17548@oksana.dev.rtsoft.ru>
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
bWJlciAxNiwgMjAxMCAxNzoyNiBQTQ0KPiBUbzogWmFuZyBSb3ktUjYxOTExDQo+IENjOiBsaW51
eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZHdtdzJAaW5mcmFkZWFkLm9yZzsgZGVkZWtpbmQx
QGdtYWlsLmNvbTsNCj4gYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsgTGFuIENodW5oZS1CMjU4
MDY7IFdvb2QgU2NvdHQtQjA3NDIxOyBHYWxhIEt1bWFyLQ0KPiBCMTE3ODA7IGxpbnV4cHBjLWRl
dkBvemxhYnMub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8zIHYzXSBQNDA4MC9tdGQ6IE9u
bHkgbWFrZSBlbGJjIG5hbmQgZHJpdmVyIGRldGVjdCBuYW5kDQo+IGZsYXNoIHBhcnRpdGlvbnMN
Cj4gDQo+IE9uIFRodSwgU2VwIDE2LCAyMDEwIGF0IDA0OjUwOjA1UE0gKzA4MDAsIFphbmcgUm95
LVI2MTkxMSB3cm90ZToNCj4gPiA+IE9uIFRodSwgU2VwIDE2LCAyMDEwIGF0IDAyOjQxOjIzUE0g
KzA4MDAsIFJveSBaYW5nIHdyb3RlOg0KPiA+ID4gWy4uLl0NCj4gPiA+ID4gLXN0YXRpYyBpbnQg
X19kZXZpbml0IGZzbF9lbGJjX2NoaXBfcHJvYmUoc3RydWN0IGZzbF9lbGJjX2N0cmwgKmN0cmws
DQo+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBk
ZXZpY2Vfbm9kZSAqbm9kZSkNCj4gPiA+ID4gKy8qDQo+ID4gPiA+ICsgKiBDdXJyZW50bHkgb25s
eSBvbmUgZWxiYyBwcm9iZSBpcyBzdXBwb3J0ZWQuDQo+ID4gPiA+ICsgKi8NCj4gPiA+ID4gK3N0
YXRpYyBpbnQgX19kZXZpbml0IGZzbF9lbGJjX25hbmRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqZGV2KQ0KPiA+ID4gPiAgew0KPiA+ID4gPiAtICAgICBzdHJ1Y3QgZnNsX2xiY19yZWdz
IF9faW9tZW0gKmxiYyA9IGN0cmwtPnJlZ3M7DQo+ID4gPiA+ICsgICAgIHN0cnVjdCBmc2xfbGJj
X3JlZ3MgX19pb21lbSAqbGJjOw0KPiA+ID4gPiAgICAgICBzdHJ1Y3QgZnNsX2VsYmNfbXRkICpw
cml2Ow0KPiA+ID4gPiAgICAgICBzdHJ1Y3QgcmVzb3VyY2UgcmVzOw0KPiA+ID4gPiArICAgICBz
dHJ1Y3QgZnNsX2VsYmNfZmNtX2N0cmwgKmVsYmNfZmNtX2N0cmwgPSBOVUxMOw0KPiA+ID4gWy4u
Ll0NCj4gPiA+ID4gLSAgICAgY3RybC0+Y2hpcHNbYmFua10gPSBwcml2Ow0KPiA+ID4gPiArICAg
ICBpZiAoZnNsX2xiY19jdHJsX2Rldi0+bmFuZCA9PSBOVUxMKSB7DQo+ID4gPiA+ICsgICAgICAg
ICAgICAgZWxiY19mY21fY3RybCA9IGt6YWxsb2Moc2l6ZW9mKCplbGJjX2ZjbV9jdHJsKSwNCj4g
R0ZQX0tFUk5FTCk7DQo+ID4gPiA+ICsgICAgICAgICAgICAgaWYgKCFlbGJjX2ZjbV9jdHJsKSB7
DQo+ID4gPiBbLi4uXQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgZ290byBlcnI7DQo+
ID4gPiA+ICsgICAgICAgICAgICAgfQ0KPiA+ID4gPiArICAgICAgICAgICAgIGZzbF9sYmNfY3Ry
bF9kZXYtPm5hbmQgPSBlbGJjX2ZjbV9jdHJsOw0KPiA+ID4gPiArICAgICB9DQo+ID4gPiA+ICsN
Cj4gPiA+ID4gKyAgICAgZWxiY19mY21fY3RybC0+Y2hpcHNbYmFua10gPSBwcml2Ow0KPiA+ID4N
Cj4gPiA+IEFnYWluLCB0aGlzIHdpbGwgb29wcyBvbiB0aGUgc2Vjb25kIHByb2JlLg0KPiA+IFdo
eT8NCj4gDQo+IEJlY2F1c2Ugb2YgYSBOVUxMIGRlcmVmZXJlbmNlICgiZWxiY19mY21fY3RybC0+
IikuDQo+IA0KPiBJIHVuZGVyc3RhbmQgdGhhdCB5b3UgZG9uJ3QgaGF2ZSB0byBiZWxpZXZlIG1l
LCBidXQgd2lsbCB5b3UgYmVsaWV2ZQ0KPiBhIGNvbXBpbGVyPw0KPiANCj4gb2tzYW5hOn4kIGNh
dCBhLmMNCj4gI2luY2x1ZGUgPHN0ZGlvLmg+DQo+ICNpbmNsdWRlIDxtYWxsb2MuaD4NCj4gDQo+
IGNoYXIgKmZvbzsNCj4gDQo+IHZvaWQgcHJvYmUodm9pZCkNCj4gew0KPiAgICAgICAgIGNoYXIg
KmJhciA9IE5VTEw7DQo+IA0KPiAgICAgICAgIGlmICghZm9vKSB7DQo+ICAgICAgICAgICAgICAg
ICBiYXIgPSBtYWxsb2Moc2l6ZW9mKCpiYXIpKTsNCj4gICAgICAgICAgICAgICAgIGlmICghYmFy
KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm47DQo+ICAgICAgICAgICAgICAgICBm
b28gPSBiYXI7DQo+ICAgICAgICAgfQ0KPiAgICAgICAgICpiYXIgPSAnYSc7DQo+IH0NCj4gDQo+
IGludCBtYWluKHZvaWQpDQo+IHsNCj4gICAgICAgICBwcm9iZSgpOw0KPiAgICAgICAgIHByb2Jl
KCk7DQo+ICAgICAgICAgcmV0dXJuIDA7DQo+IH0NCj4gb2tzYW5hOn4kIGdjYyBhLmMgJiYgLi9h
Lm91dA0KPiBTZWdtZW50YXRpb24gZmF1bHQNCkludGVyZXN0aW5nLg0KSG93IGFib3V0IHRoaXM/
DQojaW5jbHVkZSA8c3RkaW8uaD4NCiNpbmNsdWRlIDxtYWxsb2MuaD4NCg0KY2hhciAqZm9vOw0K
DQp2b2lkIHByb2JlKHZvaWQpDQp7DQogICAgICAgIGNoYXIgKmJhciA9IE5VTEw7DQoNCiAgICAg
ICAgaWYgKCFmb28pIHsNCiAgICAgICAgICAgICAgICBiYXIgPSBtYWxsb2Moc2l6ZW9mKCpiYXIp
KTsNCiAgICAgICAgICAgICAgICBpZiAoIWJhcikNCiAgICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybjsNCiAgICAgICAgICAgICAgICBmb28gPSBiYXI7DQogICAgICAgIH0gZWxzZQ0KCQkgICBi
YXIgPSBmb287CSAgDQogICAgICAgICpiYXIgPSAnYSc7DQp9DQoNCmludCBtYWluKHZvaWQpDQp7
DQogICAgICAgIHByb2JlKCk7DQogICAgICAgIHByb2JlKCk7DQogICAgICAgIHJldHVybiAwOw0K
fQ0KDQo=
