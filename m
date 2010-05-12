Return-Path: <pbathija@amcc.com>
Received: from sdcmail01.amcc.com (sdcmail01.amcc.com [198.137.200.72])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D9DC3B7D81
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 May 2010 13:41:06 +1000 (EST)
Subject: RE: 440SPe/Katmai PCIe problems
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Date: Tue, 11 May 2010 20:30:38 -0700
Message-ID: <9D1E2BDCB5C57B46B56E6D80843439EB0A5EB9B3@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <1273633366.21352.100.camel@pasglop>
References: <1273632013.21352.88.camel@pasglop>
	<1273633366.21352.100.camel@pasglop>
From: "Pravin Bathija" <pbathija@amcc.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Stefan Roese" <sr@denx.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJlbmphbWluIEhlcnJlbnNj
aG1pZHQgW21haWx0bzpiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmddDQo+IFNlbnQ6IFR1ZXNkYXks
IE1heSAxMSwgMjAxMCA4OjAzIFBNDQo+IFRvOiBTdGVmYW4gUm9lc2UNCj4gQ2M6IGxpbnV4cHBj
LWRldjsgUHJhdmluIEJhdGhpamENCj4gU3ViamVjdDogUmU6IDQ0MFNQZS9LYXRtYWkgUENJZSBw
cm9ibGVtcw0KPiANCj4gT24gV2VkLCAyMDEwLTA1LTEyIGF0IDEyOjQwICsxMDAwLCBCZW5qYW1p
biBIZXJyZW5zY2htaWR0IHdyb3RlOg0KPiA+IEhpIFN0ZWZhbiAhDQo+ID4NCj4gPiAoT3Igc29t
ZWJvZHkgZnJvbSBBTUNDKQ0KPiA+DQo+ID4gSSBub3RpY2VkIHdlIHN0aWxsIGhhdmUgdGhpcyBv
bGQgcHJvYmxlbSBvbiBQQ0llIHdoZXJlIHNvbWUgY2FyZHMNCj4gZG9uJ3QNCj4gPiBzZWVtIHRv
IHdvcmsuIFRoZSBsaW5rIHRyYWlucyBidXQgdGhleSBkb24ndCByZXNwb25kIG9uIGNvbmZpZyBz
cGFjZS4NCj4gPiBUaGlzIGlzIHRoZSBjYXNlIGZvciBleGFtcGxlIG9mIHRoYXQgU3VuaXggcXVh
ZCBVU0IgY2FyZC4gSXQgc2VlbXMgdG8NCj4gYmUNCj4gPiByZWxhdGVkIHRvIHRoZSBraW5kIG9m
IFRJIFBDSWUgPC0+IFBDSSBicmlkZ2Ugb24gdGhlc2UgdGhvdWdoLg0KPiA+DQo+ID4gSGF2ZSBh
bnlib2R5IHRyYWNrZWQgZG93biB0aGUgcm9vdCBjYXVzZSBvZiB0aGUgcHJvYmxlbSA/IFNvbWUg
c2F5DQo+IHRoYXQNCj4gPiBpdCBjb3VsZCBiZSB0aGF0IHRoZSBicmlkZ2UgZG9lc24ndCBjb3Bl
IHdpdGggdGhlIGRvdWJsZSByZXNldCAodWJvb3QNCj4gPiB0aGVuIGtlcm5lbCkuIFdvdWxkIGl0
IGJlIHBvc3NpYmxlIHRvIHRlbGwgdWJvb3QgdG8gYXZvaWQgdG91Y2hpbmcNCj4gdGhlDQo+ID4g
UENJZSBpbnRlcmZhY2UgY29tcGxldGVseSBzbyB0aGUga2VybmVsIGlzIHRoZSBmaXJzdCBvbmUg
dG8gZ2V0IGluID8NCj4gDQo+IEFjdHVhbGx5Li4uIHRoZSBjYXJkIHdvcmtzIGluIHRoZSBDYW55
b25sYW5kcyB1c2luZyB0aGUgbGF0ZXN0IHUtYm9vdA0KPiBmcm9tIGZ0cC5kZW54LmRlICh1LWJv
b3QtbmFuZC5iaW4tMjAwOS4xMS4xKSwgdGhvdWdoIGludGVyZXN0aW5nbHkNCj4gZW5vdWdoLCB0
aGlzIHUtYm9vdCBmYWlscyB0byBkZXRlY3QgYW4gWEdJIFoxMSB2aWRlbyBjYXJkIHRoYXQgSSBo
YXZlLA0KPiB3aGljaGV2ZXIgc2xvdCBJIHB1dCBpdCBpbi4NCj4gDQo+IGluIGZhY3QsIHRoZSBr
ZXJuZWwgaXRzZWxmIGRldGVjdHMgdGhlIGNhcmQgYW5kIHRpbWVzIG91dCB0cnlpbmcgdG8gZ2V0
DQo+IGEgbGluay4gSXQgd29ya3Mgd2l0aCB3aGF0ZXZlciB1LWJvb3QgSSB1c2VkIHRvIGhhdmUg
aW4gdGhlcmUgKGFuZCBubw0KPiBsb25nZXIgZG8gLi4uIG9vcHMgOi0pDQo+IA0KPiBDaGVlcnMs
DQo+IEJlbi4NCj4gDQoNCg0KQmVuLA0KDQpUaGFua3MgZm9yIGJyaW5naW5nIHRoaXMgdG8gb3Vy
IGF0dGVudGlvbi4gV2UnbGwgcmVzZWFyY2ggdGhpcyBpc3N1ZS4NCg0KUmVnYXJkcywNClByYXZp
bg0KDQoNCg==
