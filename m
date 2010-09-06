Return-Path: <R61911@freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
	[213.199.154.207]) by ozlabs.org (Postfix) with ESMTP id EEF9BB70E2
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Sep 2010 19:24:47 +1000 (EST)
Received: from mail55-am1 (localhost.localdomain [127.0.0.1])	by
	mail55-am1-R.bigfish.com (Postfix) with ESMTP id 66ADC1350456	for
	<linuxppc-dev@ozlabs.org>; Mon,  6 Sep 2010 09:24:42 +0000 (UTC)
Received: from am1ehsmhs002.bigfish.com (unknown [10.3.201.253])	by
	mail55-am1.bigfish.com (Postfix) with ESMTP id 10429199804E	for
	<linuxppc-dev@ozlabs.org>; Mon,  6 Sep 2010 09:24:42 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o869OddB020642	for <linuxppc-dev@ozlabs.org>;
	Mon, 6 Sep 2010 02:24:39 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP
	id o869Oi1B008830	for <linuxppc-dev@ozlabs.org>;
	Mon, 6 Sep 2010 04:24:45 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: RE: [PATCH 1/3][MTD] P4080/eLBC: Make Freescale elbc interrupt common
	to elbc devices
Date: Mon, 6 Sep 2010 17:24:35 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A1B3872@zch01exm23.fsl.freescale.net>
In-Reply-To: <20100906082142.GB13755@oksana.dev.rtsoft.ru>
References: <1281063096-26598-1-git-send-email-tie-fei.zang@freescale.com>
	<20100903112755.GA11847@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A1B378F@zch01exm23.fsl.freescale.net>
	<20100906082142.GB13755@oksana.dev.rtsoft.ru>
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
IFttYWlsdG86Y2JvdWF0bWFpbHJ1QGdtYWlsLmNvbV0NCj4gU2VudDogTW9uZGF5LCBTZXB0ZW1i
ZXIgMDYsIDIwMTAgMTY6MjIgUE0NCj4gVG86IFphbmcgUm95LVI2MTkxMQ0KPiBDYzogbGludXgt
bXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IExhbiBDaHVuaGUtQjI1ODA2OyBsaW51eHBwYy1kZXZA
b3psYWJzLm9yZzsNCj4gYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsgR2FsYSBLdW1hci1CMTE3
ODA7IFdvb2QgU2NvdHQtQjA3NDIxDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXVtNVERdIFA0
MDgwL2VMQkM6IE1ha2UgRnJlZXNjYWxlIGVsYmMgaW50ZXJydXB0IGNvbW1vbg0KPiB0byBlbGJj
IGRldmljZXMNCj4gDQo+IE9uIE1vbiwgU2VwIDA2LCAyMDEwIGF0IDExOjM4OjA5QU0gKzA4MDAs
IFphbmcgUm95LVI2MTkxMSB3cm90ZToNCj4gWy4uLl0NCj4gPiA+ID4gIAlzd2l0Y2ggKGJyICYg
QlJfTVNFTCkgew0KPiA+ID4gPiAgCWNhc2UgQlJfTVNfVVBNQToNCj4gPiA+ID4gLQkJdXBtLT5t
eG1yID0gJmZzbF9sYmNfcmVncy0+bWFtcjsNCj4gPiA+ID4gKwkJdXBtLT5teG1yID0gJmZzbF9s
YmNfY3RybF9kZXYtPnJlZ3MtPm1hbXI7DQo+ID4gPg0KPiA+ID4gRGl0dG8sIGEgdmVyeSByZXBl
dGl0aXZlIHN0dWZmLCBkZXNpcmVzIGEgdmFyaWFibGUgZm9yIHJlZ3M/DQo+ID4gQnV0IHRoZSBm
YWN0IGlzIHRoYXQgdGhlIHZhcmlhYmxlIHJlcHJlc2VudHMgZGlmZmVyZW50IHJlZw0KPiA+IGFk
ZHJlc3MgYWNjb3JkaW5nIHRvIHRoZSBjb25kaXRpb24uIEl0IHdpbGwgYmUgdWdseSB0byB1c2UN
Cj4gPiB0aGUgcmVnIGFkZHJlc3MgZGlyZWN0b2x5Lg0KPiANCj4gSSBtZWFudCBhIGRlZGljYXRl
ZCB2YXIgZm9yICdmc2xfbGJjX2N0cmxfZGV2LT5yZWdzJy4NCj4gSS5lLg0KPiANCj4gcmVncyA9
IGZzbF9sYmNfY3RybF9kZXYtPnJlZ3M7DQo+IC4uLg0KPiBteG1yID0gJnJlZ3MtPm1hbXI7DQo+
IC4uLg0KPiBteG1yID0gJnJlZ3MtPm1ibXI7DQo+IC4uDQo+IG14bXIgPSAmcmVncy0+bWNtcjsN
Cj4gDQo+IEluc3RlYWQgb2YNCj4gDQo+IG14bXIgPSAmZnNsX2xiY19jdHJsX2Rldi0+cmVncy0+
bWFtcjsNCj4gLi4uDQo+IG14bXIgPSAmZnNsX2xiY19jdHJsX2Rldi0+cmVncy0+bWJtcjsNCj4g
Li4NCj4gbXhtciA9ICZmc2xfbGJjX2N0cmxfZGV2LT5yZWdzLT5tY21yOw0KVGhhdCBtYWtlcyBz
ZW5zZS4gIEEgZ2xvYmFsIG9yIGxvY2FsIHZhcmlhYmxlIGZvciBmc2xfbGJjX2N0cmxfZGV2LT5y
ZWdzPyBXaGljaCBvbmUgaXMgYmV0dGVyPw0KDQo+IA0KPiBbLi4uXQ0KPiA+ID4gPiArc3RhdGlj
IGludCBfX2RldmluaXQgZnNsX2xiY19jdHJsX3Byb2JlKHN0cnVjdCBvZl9kZXZpY2UgKm9mZGV2
LA0KPiA+ID4gPiArCQkJCQkgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCAqbWF0Y2gpDQo+ID4g
PiA+ICt7DQo+ID4gPiA+ICsJaW50IHJldCA9IDA7DQo+ID4gPg0KPiA+ID4gbm8gbmVlZCBmb3Ig
dGhlIGluaXRpYWwgdmFsdWUgaGVyZS4NCj4gPiBBbnkgaGFybT8NCj4gDQo+IFByb2JhYmx5IG5v
dCBhcyBnY2Mgd2lsbCBsaWtlbHkgb3B0aW1pemUgaXQgYXdheSwNCj4gYnV0IGl0J3Mgbm90IG5l
ZWRlZCwgc28gd2h5IGtlZXAgaXQgdGhlcmU/DQpoYWJpdC4NClRoYW5rcy4NClJveQ0KDQo=
