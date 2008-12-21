Return-Path: <xilinx@live.cn>
Received: from bay0-omc3-s41.bay0.hotmail.com (bay0-omc3-s41.bay0.hotmail.com
	[65.54.246.241]) by ozlabs.org (Postfix) with ESMTP id 83DE9DDD04
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 21 Dec 2008 19:55:51 +1100 (EST)
Message-ID: <BAY105-DS67451C50733C2C2A9DEBFCDEE0@phx.gbl>
From: "mingqian" <xilinx@live.cn>
To: "Grant Likely" <grant.likely@secretlab.ca>
In-Reply-To: <BAY105-DS3567863497ABB33F27B64CDF10@phx.gbl>
	<fa686aa40812192235q6d9e09bav80508cf31bf0be94@mail.gmail.com>
	<BAY105-DS5483ABB21548C3078681CCDF10@phx.gbl>
	<fa686aa40812201245q5a04cf39x62f20be2bba69b8@mail.gmail.com>
	<BAY105-DS32759F571CA31E6361531CDEE0@phx.gbl>
	<fa686aa40812201958k5358d81wac30662517c59d@mail.gmail.com>
References: <BAY105-DS3567863497ABB33F27B64CDF10@phx.gbl>
	<fa686aa40812192235q6d9e09bav80508cf31bf0be94@mail.gmail.com>
	<BAY105-DS5483ABB21548C3078681CCDF10@phx.gbl>
	<fa686aa40812201245q5a04cf39x62f20be2bba69b8@mail.gmail.com>
	<BAY105-DS32759F571CA31E6361531CDEE0@phx.gbl>
	<fa686aa40812201958k5358d81wac30662517c59d@mail.gmail.com>
Subject: Re: Linux 2.6 frame buffer for XUPV2P
Date: Sun, 21 Dec 2008 16:55:34 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

VGhhbmtzIEdyYW50IQ0KICAgIEl0IHdvcmtzIGFmdGVyIEkgZm9sbG93IHlvdXIgYWR2aWNlIDEp
ICYgMikuIFRoZSBzbWFsbCBMaW51eCBsb2dvIGlzIHNob3duIG9uIHRoZSBzY3JlZW4sDQoNCkFu
ZCBJIGdvdCB0aGUgZm9sbG93aW5nIGZyb20gZG1lc2c6DQp4aWxpbnhmYjogY2FsbGluZyBvZl9y
ZWdpc3Rlcl9wbGF0Zm9ybV9kcml2ZXIoKQ0KeGlsaW54ZmIgYTA4ZjhiMDAudGZ0OiB4aWxpbnhm
Yl9vZl9wcm9iZShkZmFhZWUwMCwgYzAyYmZkZTApDQpDb25zb2xlOiBzd2l0Y2hpbmcgdG8gY29s
b3VyIGZyYW1lIGJ1ZmZlciBkZXZpY2UgODB4MzANCnhpbGlueGZiIGEwOGY4YjAwLnRmdDogZmI6
IHBoeXM9MWYwMDAwMDAsIHZpcnQ9ZmYxMDAwMDAsIHNpemU9MWUwMDAwDQoNCg0KQmVzdCBSZWdh
cmRzICYgTWVycnkgQ2hyaXN0bWFzIQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KRnJvbTogIkdyYW50IExpa2VseSIgPGdyYW50Lmxpa2VseUBz
ZWNyZXRsYWIuY2E+DQpTZW50OiBTdW5kYXksIERlY2VtYmVyIDIxLCAyMDA4IDExOjU4IEFNDQpU
bzogIm1pbmdxaWFuIiA8eGlsaW54QGxpdmUuY24+DQpDYzogPGxpbnV4cHBjLWVtYmVkZGVkQG96
bGFicy5vcmc+DQpTdWJqZWN0OiBSZTogTGludXggMi42IGZyYW1lIGJ1ZmZlciBmb3IgWFVQVjJQ
DQoNCj4gT24gU2F0LCBEZWMgMjAsIDIwMDggYXQgNjozNCBQTSwgbWluZ3FpYW4gPHhpbGlueEBs
aXZlLmNuPiB3cm90ZToNCj4+IEhpIEdyYW50LCB0aGFuayB5b3UgZm9yIHlvdXIgcXVpY2sgcmVw
bHk6LSkNCj4+IEhlcmUgaXMgbXkgZHRzOg0KPiANCj4gVHJ5IHRoZSBmb2xsb3dpbmcgdGhpbmdz
Og0KPiANCj4gMSkgQ2hhbmdlIHRoZSBmb2xsb3dpbmcgbGluZSBpbiB0aGUgZHRzOg0KPj4gY29t
cGF0aWJsZSA9ICJ4bG54LHBsYi10ZnQtY250bHItcmVmLTEuMDAuZCI7DQo+IA0KPiB0byAnY29t
cGF0aWJsZSA9ICJ4bG54LHBsYi10ZnQtY250bHItcmVmLTEuMDAuYSI7Jw0KPiANCj4gMikgYWRk
ICcjZGVmaW5lIERFQlVHJyB0byB0aGUgdG9wIG9mIGRyaXZlcnMvdmlkZW8veGlsaW54ZmIuYyBi
ZWZvcmUNCj4gdGhlIGZpcnN0ICNpbmNsdWRlIHN0YXRlbWVudCBhbmQgcG9zdCB0aGUgZG1lc2cg
b3V0cHV0Lg0KPiANCj4gMykgbG9vayBpbiAvc3lzL2J1cy9vZl9wbGF0Zm9ybS9kZXZpY2VzIHRv
IHNlZSBpZiB0aGVyZSBpcyBhIGRpcmVjdG9yeQ0KPiBmb3IgdGhlIHhpbGlueCBmcmFtZWJ1ZmZl
ciBkZXZpY2UuDQo+IA0KPiBnLg0KPiANCj4gLS0gDQo+IEdyYW50IExpa2VseSwgQi5TYy4sIFAu
RW5nLg0KPiBTZWNyZXQgTGFiIFRlY2hub2xvZ2llcyBMdGQuDQo+IA==
