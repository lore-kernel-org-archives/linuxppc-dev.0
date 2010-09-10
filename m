Return-Path: <R61911@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
	[216.32.180.14]) by ozlabs.org (Postfix) with ESMTP id 5CBACB7112
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Sep 2010 16:58:56 +1000 (EST)
Received: from mail105-va3 (localhost.localdomain [127.0.0.1])	by
	mail105-va3-R.bigfish.com (Postfix) with ESMTP id E3D5212C01BD	for
	<linuxppc-dev@ozlabs.org>; Fri, 10 Sep 2010 06:58:51 +0000 (UTC)
Received: from VA3EHSMHS013.bigfish.com (unknown [10.7.14.248])	by
	mail105-va3.bigfish.com (Postfix) with ESMTP id 70426CC8052	for
	<linuxppc-dev@ozlabs.org>; Fri, 10 Sep 2010 06:58:40 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o8A6wMPe023008	for
	<linuxppc-dev@ozlabs.org>; Thu, 9 Sep 2010 23:58:33 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o8A7DK7U015128	for <linuxppc-dev@ozlabs.org>;
	Fri, 10 Sep 2010 02:13:21 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: RE: [PATCH 1/3 v2][MTD] P4080/eLBC: Make Freescale elbc interrupt
	common to elbc devices
Date: Fri, 10 Sep 2010 14:58:15 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A1FBF4A@zch01exm23.fsl.freescale.net>
In-Reply-To: <20100909115338.GA12320@oksana.dev.rtsoft.ru>
References: <1284027632-32573-1-git-send-email-tie-fei.zang@freescale.com>
	<20100909115338.GA12320@oksana.dev.rtsoft.ru>
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
bWJlciAwOSwgMjAxMCAxOTo1NCBQTQ0KPiBUbzogWmFuZyBSb3ktUjYxOTExDQo+IENjOiBsaW51
eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZHdtdzJAaW5mcmFkZWFkLm9yZzsgZGVkZWtpbmQx
QGdtYWlsLmNvbTsNCj4gYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsgTGFuIENodW5oZS1CMjU4
MDY7IFdvb2QgU2NvdHQtQjA3NDIxOyBHYWxhIEt1bWFyLQ0KPiBCMTE3ODA7IGxpbnV4cHBjLWRl
dkBvemxhYnMub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zIHYyXVtNVERdIFA0MDgwL2VM
QkM6IE1ha2UgRnJlZXNjYWxlIGVsYmMgaW50ZXJydXB0DQo+IGNvbW1vbiB0byBlbGJjIGRldmlj
ZXMNCj4gDQo+IEp1c3QgYSBmZXcgY29zbWV0aWMgbml0cyBmb3IgdGhpcyBwYXRjaC4uLg0KPiAN
Cj4gT24gVGh1LCBTZXAgMDksIDIwMTAgYXQgMDY6MjA6MzBQTSArMDgwMCwgUm95IFphbmcgd3Jv
dGU6DQo+IFsuLi5dDQpbc25pcF0NCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2Vf
aWQgZnNsX2xiY19tYXRjaFtdID0gew0KPiA+ICsJeyAuY29tcGF0aWJsZSA9ICJmc2wsZWxiYyIs
IH0sDQo+ID4gKwl7IC5jb21wYXRpYmxlID0gImZzbCxwcTMtbG9jYWxidXMiLCB9LA0KPiA+ICsJ
eyAuY29tcGF0aWJsZSA9ICJmc2wscHEyLWxvY2FsYnVzIiwgfSwNCj4gPiArCXsgLmNvbXBhdGli
bGUgPSAiZnNsLHBxMnByby1sb2NhbGJ1cyIsIH0sDQo+ID4gKwl7fSwNCj4gPiArfTsNCj4gDQo+
IFlvdSBuZWVkIGxpbnV4L21vZF9kZXZpY2V0YWJsZS5oIGZvciB0aGlzLg0KSXQgaGFzIGJlZW4g
aW5jbHVkZSBpbiBsaW51eC9vZi5oLg0KDQo+IA0KPiA+ICsNCj4gPiArc3RhdGljIHN0cnVjdCBv
Zl9wbGF0Zm9ybV9kcml2ZXIgZnNsX2xiY19jdHJsX2RyaXZlciA9IHsNCj4gDQo+IE5lZWQgbGlu
dXgvb2ZfcGxhdGZvcm0uaCBmb3IgdGhpcy4NCkl0IGhhcyBiZWVuIGluY2x1ZGUgYnkNCmZzbF9s
YmMuaC0+bGludXgvb2ZfcGxhdGZvcm0uaC0+IGxpbnV4L3BsYXRmb3JtX2RldmljZS5oDQpCZWZv
cmUgc3VibWl0dGluZyB0aGUgcGF0Y2gsIEkgaGF2ZSBidWlsdCBhbmQgdGVzdGVkIGl0Lg0KDQpE
byB5b3UgdGhpbmsgSSBkbyBub3QgYnVpbGQgdGhlIHRyZWUgYmVmb3JlIEkgc2VuZCBvdXQgdGhl
IHBhdGNoPw0KPiANCj4gPiArDQo+ID4gK3N0YXRpYyBzdHJ1Y3Qgb2ZfcGxhdGZvcm1fZHJpdmVy
IGZzbF9sYmNfY3RybF9kcml2ZXIgPSB7DQo+IA0KPiBOZWVkIGxpbnV4L29mX3BsYXRmb3JtLmgg
Zm9yIHRoaXMuDQo+IA0KPiBCdXQgeW91IGFjdHVhbGx5IGRvbid0IG5lZWQgb2ZfcGxhdGZvcm1f
ZHJpdmVyLCBhcyBmb3IgdGhlDQo+IG5ldyBjb2RlIHlvdSBjYW4gdXNlIHBsYXRmb3JtX2RyaXZl
ciAoYW5kIHRodXMNCj4gbGludXgvcGxhdGZvcm1fZGV2aWNlLmgpLg0KSSdkIHByZWZlciB1c2lu
ZyBvZl9wbGF0Zm9ybV9kcml2ZXIgaGVyZSBmb3Igc2ltcGxpZmllZCBjb2RlLg0KQW55IHNwZWNp
YWwgcmVhc29uIHRvIHVzZSBwbGF0Zm9ybV9kZXZpY2UgaGVyZT8NClRoYW5rcy4NClJveQ0K
