Return-Path: <R61911@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by ozlabs.org (Postfix) with ESMTP id 159E6B70ED
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Sep 2010 13:57:52 +1000 (EST)
Received: from mail176-tx2 (localhost.localdomain [127.0.0.1])	by
	mail176-tx2-R.bigfish.com (Postfix) with ESMTP id 0C4A18202F8	for
	<linuxppc-dev@ozlabs.org>; Mon,  6 Sep 2010 03:57:50 +0000 (UTC)
Received: from TX2EHSMHS036.bigfish.com (unknown [10.9.14.245])	by
	mail176-tx2.bigfish.com (Postfix) with ESMTP id CA28E1798084	for
	<linuxppc-dev@ozlabs.org>; Mon,  6 Sep 2010 03:56:10 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o863u9b2014925	for <linuxppc-dev@ozlabs.org>;
	Sun, 5 Sep 2010 20:56:09 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP
	id o8648Q5B002673	for <linuxppc-dev@ozlabs.org>;
	Sun, 5 Sep 2010 23:08:27 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: RE: [PATCH 3/3][MTD] P4080/nand: Fix the freescale lbc issue with
	36bit mode
Date: Mon, 6 Sep 2010 11:56:07 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A1B379C@zch01exm23.fsl.freescale.net>
In-Reply-To: <20100903113604.GB11847@oksana.dev.rtsoft.ru>
References: <1281063096-26598-1-git-send-email-tie-fei.zang@freescale.com>
	<1281063096-26598-2-git-send-email-tie-fei.zang@freescale.com>
	<1281063096-26598-3-git-send-email-tie-fei.zang@freescale.com>
	<20100903113604.GB11847@oksana.dev.rtsoft.ru>
From: Zang Roy-R61911 <r61911@freescale.com>
To: "Anton Vorontsov" <cbouatmailru@gmail.com>
Cc: Lan Chunhe-B25806 <B25806@freescale.com>, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org, linux-mtd@lists.infradead.org,
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
IFttYWlsdG86Y2JvdWF0bWFpbHJ1QGdtYWlsLmNvbV0NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1i
ZXIgMDMsIDIwMTAgMTk6MzYgUE0NCj4gVG86IFphbmcgUm95LVI2MTkxMQ0KPiBDYzogbGludXgt
bXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IExhbiBDaHVuaGUtQjI1ODA2OyBsaW51eHBwYy1kZXZA
b3psYWJzLm9yZzsNCj4gYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsgR2FsYSBLdW1hci1CMTE3
ODANCj4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzNdW01URF0gUDQwODAvbmFuZDogRml4IHRoZSBm
cmVlc2NhbGUgbGJjIGlzc3VlIHdpdGgNCj4gMzZiaXQgbW9kZQ0KPiANCj4gT24gRnJpLCBBdWcg
MDYsIDIwMTAgYXQgMTA6NTE6MzZBTSArMDgwMCwgUm95IFphbmcgd3JvdGU6DQo+IFsuLi5dDQo+
ID4gIC8qKg0KPiA+ICsgKiBjb252ZXJ0X2xiY19hZGRyZXNzIC0gY29udmVydCB0aGUgYmFzZSBh
ZGRyZXNzDQo+ID4gKyAqIEBhZGRyX2Jhc2U6CWJhc2UgYWRkcmVzcyBvZiB0aGUgbWVtb3J5IGJh
bmsNCj4gPiArICoNCj4gPiArICogVGhpcyBmdW5jdGlvbiBjb252ZXJ0cyBhIGJhc2UgYWRkcmVz
cyBvZiBsYmMgaW50byB0aGUgcmlnaHQgZm9ybWF0IGZvcg0KPiB0aGUgQlINCj4gPiArICogcmVn
aXN0ZXJzLiBJZiB0aGUgU09DIGhhcyBlTEJDIHRoZW4gaXQgcmV0dXJucyAzMmJpdCBwaHlzaWNh
bCBhZGRyZXNzDQo+IGVsc2UNCj4gPiArICogaXQgcmV0dXJucyAzNGJpdCBwaHlzaWNhbCBhZGRy
ZXNzIGZvciBsb2NhbCBidXMoRXhhbXBsZTogTVBDODY0MSkuDQo+ID4gKyAqLw0KPiA+ICt1bnNp
Z25lZCBpbnQgY29udmVydF9sYmNfYWRkcmVzcyhwaHlzX2FkZHJfdCBhZGRyX2Jhc2UpDQo+ID4g
K3sNCj4gPiArCXZvaWQgKmRldjsNCj4gPiArCWludCBjb21wYXRpYmxlOw0KPiA+ICsNCj4gPiAr
CWRldiA9IG9mX2ZpbmRfbm9kZV9ieV9uYW1lKE5VTEwsICJsb2NhbGJ1cyIpOw0KPiANCj4gTm9w
ZSwgeW91IHNob3VsZG4ndCBkbyB0aGlzLiBOZXZlciBzZWFyY2ggYnkgbmFtZS4NCk9LLiBJIHdp
bGwgc2VhcmNoIGJ5IGNvbXBhdGlibGUuDQo+IA0KPiBBbHNvLCBhcmVuJ3QgdGhlcmUgYWxyZWFk
eSBhIGdsb2JhbCBkZXYsIHdoaWNoIHdhcyBmb3VuZCBieSB0aGUNCj4gX3Byb2JlKCkgc3R1ZmY/
DQpJIGRvIG5vdCBzZWUgdGhlIGdsb2JhbCBkZXYgY2FuIGJlIHVzZWQgaW4gcHJvYmUuDQoNCj4g
DQo+ID4gKwlpZiAoIWRldikgew0KPiA+ICsJCXByaW50ayhLRVJOX0lORk8gImZzbC1sYmM6IGNh
bid0IGZpbmQgbG9jYWxidXMgbm9kZVxuIik7DQo+ID4gKwkJb2Zfbm9kZV9wdXQoZGV2KTsNCj4g
PiArCQlyZXR1cm4gMDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwljb21wYXRpYmxlID0gb2ZfZGV2
aWNlX2lzX2NvbXBhdGlibGUoZGV2LCAiZnNsLGVsYmMiKTsNCj4gPiArCW9mX25vZGVfcHV0KGRl
dik7DQo+ID4gKwlpZiAoY29tcGF0aWJsZSkNCj4gPiArCQlyZXR1cm4gYWRkcl9iYXNlICYgMHhm
ZmZmODAwMDsNCj4gPiArCWVsc2UNCj4gPiArCQlyZXR1cm4gKGFkZHJfYmFzZSAmIDB4MGZmZmY4
MDAwdWxsKSBcDQo+ID4gKwkJCXwgKChhZGRyX2Jhc2UgJiAweDMwMDAwMDAwMHVsbCkgPj4gMTkp
Ow0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0woY29udmVydF9sYmNfYWRkcmVzcyk7DQo+ID4g
Kw0KPiA+ICsvKioNCj4gPiAgICogZnNsX2xiY19maW5kIC0gZmluZCBMb2NhbGJ1cyBiYW5rDQo+
ID4gICAqIEBhZGRyX2Jhc2U6CWJhc2UgYWRkcmVzcyBvZiB0aGUgbWVtb3J5IGJhbmsNCj4gPiAg
ICoNCj4gPiBAQCAtNTAsNyArODAsOCBAQCBpbnQgZnNsX2xiY19maW5kKHBoeXNfYWRkcl90IGFk
ZHJfYmFzZSkNCj4gPiAgCQlfX2JlMzIgYnIgPSBpbl9iZTMyKCZmc2xfbGJjX2N0cmxfZGV2LT5y
ZWdzLT5iYW5rW2ldLmJyKTsNCj4gPiAgCQlfX2JlMzIgb3IgPSBpbl9iZTMyKCZmc2xfbGJjX2N0
cmxfZGV2LT5yZWdzLT5iYW5rW2ldLm9yKTsNCj4gPg0KPiA+IC0JCWlmIChiciAmIEJSX1YgJiYg
KGJyICYgb3IgJiBCUl9CQSkgPT0gYWRkcl9iYXNlKQ0KPiA+ICsJCWlmIChiciAmIEJSX1YgJiYg
KGJyICYgb3IgJiBCUl9CQSkgXA0KPiANCj4gTm8gbmVlZCBmb3IgIlwiIGF0IHRoZSBlbmQgb2Yg
dGhlIGxpbmUsIGtlZXAgPT0gb24gdGhlIHNhbWUgbGluZS4NCj4gDQo+ID4gKwkJCQk9PSBjb252
ZXJ0X2xiY19hZGRyZXNzKGFkZHJfYmFzZSkpDQo+IA0KPiBXb3VsZCBiZSBwcmV0dGllciBpZiB5
b3UgbmFtZSBpdCBmc2xfbGJjX2FkZHIoKS4gS2VlcHMgcHJlZml4DQo+IHRoZSBzYW1lIGZvciB0
aGUgcmVzdCBvZiB0aGUgZmlsZSwgcGx1cyBtYWtlcyBpdCBzaG9ydGVyIChzbw0KPiB0aGVyZSBw
cm9iYWJseSB3b24ndCBiZSBhbnkgbmVlZCBmb3IgYnJlYWtpbmcgdGhlIGxpbmUpLg0KQWdyZWUg
dGhlIG5ldyBuYW1lLg0KVGhhbmtzLg0KUm95DQo=
