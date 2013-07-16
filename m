Return-Path: <B42677@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CB9AA2C014A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2013 13:09:50 +1000 (EST)
From: Zhang Haijun-B42677 <B42677@freescale.com>
To: Anton Vorontsov <anton@enomsg.org>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: [PATCH 3/4 V2] mmc: esdhc: Add quirks to support T4240QDS board
Date: Tue, 16 Jul 2013 03:11:47 +0000
Message-ID: <99E897753B6F7048BD8CCDB4661D02E13A7CC3@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1373267764-6364-1-git-send-email-Haijun.Zhang@freescale.com>
 <1373267764-6364-2-git-send-email-Haijun.Zhang@freescale.com>
 <1373303919.8183.164@snotra> <20130712183503.GA24689@teo>
In-Reply-To: <20130712183503.GA24689@teo>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Wrobel Heinz-R39252 <r39252@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "cjb@laptop.org" <cjb@laptop.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Fleming Andy-AFLEMING <afleming@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SGksIEFudG9uDQoNCllvdSBtZWFuIGdldCB2b2x0YWdlIHN1cHBvcnQgZnJvbSBEVFM/DQpPciBn
ZXQgdm9sdGFnZSBib3RoIGZyb20gRFRTIGFuZCBob3N0IGNhcGFjaXR5IHJlZ2lzdGVyPw0KDQpU
aGFua3MuDQoNClJlZ2FyZHMNCkhhaWp1bi4NCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IGxpbnV4LW1tYy1vd25lckB2Z2VyLmtlcm5lbC5vcmcgW21haWx0bzpsaW51
eC1tbWMtDQo+IG93bmVyQHZnZXIua2VybmVsLm9yZ10gT24gQmVoYWxmIE9mIEFudG9uIFZvcm9u
dHNvdg0KPiBTZW50OiBTYXR1cmRheSwgSnVseSAxMywgMjAxMyAyOjM1IEFNDQo+IFRvOiBXb29k
IFNjb3R0LUIwNzQyMQ0KPiBDYzogWmhhbmcgSGFpanVuLUI0MjY3NzsgbGludXgtbW1jQHZnZXIu
a2VybmVsLm9yZzsgbGludXhwcGMtDQo+IGRldkBsaXN0cy5vemxhYnMub3JnOyBjamJAbGFwdG9w
Lm9yZzsgRmxlbWluZyBBbmR5LUFGTEVNSU5HOyBXcm9iZWwNCj4gSGVpbnotUjM5MjUyDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMy80IFYyXSBtbWM6IGVzZGhjOiBBZGQgcXVpcmtzIHRvIHN1cHBv
cnQgVDQyNDBRRFMNCj4gYm9hcmQNCj4gDQo+IE9uIE1vbiwgSnVsIDA4LCAyMDEzIGF0IDEyOjE4
OjM5UE0gLTA1MDAsIFNjb3R0IFdvb2Qgd3JvdGU6DQo+ID4gT24gMDcvMDgvMjAxMyAwMjoxNjow
NCBBTSwgSGFpanVuIFpoYW5nIHdyb3RlOg0KPiA+ID5PbiBUNDI0MFFEUyBib2FyZCBjb250cm9s
bGVycyBoYXMgYW4gdW51c2FibGUgQURNQSBlbmdpbmUsIHNvIHVzZQ0KPiA+ID5TRE1BIGluc3Rl
YWQuDQo+ID4gPkFsc28gMy4wdiBpcyBzdXBwb3J0IG9uIFQ0MjQwUURTIGJvYXJkIGV2ZW4gaWYg
dGhlIGNhcGFjaXR5IGRldGFpbGVkDQo+ID4gPm9ubHkgMS44diBzdXBwb3J0LiBXaXRob3V0IHRo
aXMgcXVpcmsgU0QgY2FyZCB3aWxsIGRlY2xhcmUgdm9sdGFnZQ0KPiA+ID5ub3Qgc3VwcG9ydCBh
bmQNCj4gPiA+DQo+ID4gPlNpZ25lZC1vZmYtYnk6IEhhaWp1biBaaGFuZyA8aGFpanVuLnpoYW5n
QGZyZWVzY2FsZS5jb20+DQo+ID4NCj4gPiAuLi5hbmQgd2hhdD8NCj4gPg0KPiA+IFdoeSBpcyB0
aGlzIGJvYXJkLXNwZWNpZmljPyAgSXNuJ3QgdGhlIGNvbnRyb2xsZXIgcGFydCBvZiB0aGUgU29D
LCBub3QNCj4gPiBwYXJ0IG9mIHRoZSBib2FyZD8gIElmIGl0IHJlYWxseSBpcyBib2FyZC1zcGVj
aWZpYywgY291bGQgeW91IGJlIG1vcmUNCj4gPiBkZXRhaWxlZCBhYm91dCB3aHkgKGlkZWFsbHkg
d2l0aCBhbiBlcnJhdHVtIG51bWJlciksIGFuZCBjaGVjayB0aGUNCj4gPiB0b3BsZXZlbCBib2Fy
ZCBjb21wYXRpYmxlIChvciBnZXQgdGhlIGluZm9ybWF0aW9uIGZyb20gcGxhdGZvcm0NCj4gPiBj
b2RlKSByYXRoZXIgdGhhbiBtb2RpZnkgdGhlIGRldmljZSB0cmVlPw0KPiANCj4gWXVwLCBhbmQg
aWYgYW55dGhpbmcsIEkgd291bGQgcmVjb21tZW5kIHRvIHJldXNlIHZvbHRhZ2UtcmFuZ2VzIHBy
b3BlcnR5LA0KPiBpdCBpcyBhbHJlYWR5IGltcGxlbWVudGVkIGZvciBtbWMgc3BpIGRyaXZlciwN
Cj4gDQo+IGRyaXZlcnMvbW1jL2hvc3Qvb2ZfbW1jX3NwaS5jDQo+IERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9tbWMvbW1jLXNwaS1zbG90LnR4dA0KPiANCj4gVGhhbmtzLA0KPiAN
Cj4gQW50b24NCj4gLS0NCj4gVG8gdW5zdWJzY3JpYmUgZnJvbSB0aGlzIGxpc3Q6IHNlbmQgdGhl
IGxpbmUgInVuc3Vic2NyaWJlIGxpbnV4LW1tYyIgaW4NCj4gdGhlIGJvZHkgb2YgYSBtZXNzYWdl
IHRvIG1ham9yZG9tb0B2Z2VyLmtlcm5lbC5vcmcgTW9yZSBtYWpvcmRvbW8gaW5mbyBhdA0KPiBo
dHRwOi8vdmdlci5rZXJuZWwub3JnL21ham9yZG9tby1pbmZvLmh0bWwNCg0K
