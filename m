Return-Path: <r61911@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A765E2C095D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 16:49:46 +1000 (EST)
From: Zang Roy-R61911 <r61911@freescale.com>
To: Bhushan Bharat-R65777 <R65777@freescale.com>, tiejun.chen
 <tiejun.chen@windriver.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: RE: SATA FSL and upstreaming
Date: Thu, 16 May 2013 06:49:38 +0000
Message-ID: <3E027F8168735B46AC006B1D0C7BB0020B1E056D@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1368679657.9603.32.camel@pasglop>
 <1368683156.9603.34.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C307@039-SN2MPN1-012.039d.mgd.msft.net>
 <3E027F8168735B46AC006B1D0C7BB0020B1E040F@039-SN2MPN1-011.039d.mgd.msft.net>
 <1368684547.9603.38.camel@pasglop> <51947A00.9010504@windriver.com>
 <1368685307.9603.39.camel@pasglop> <51947E35.30808@windriver.com>
 <1368686426.9603.49.camel@pasglop> <5194800D.3010606@windriver.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C498@039-SN2MPN1-012.039d.mgd.msft.net>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D0701C498@039-SN2MPN1-012.039d.mgd.msft.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Liu Qiang-B32616 <B32616@freescale.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Xie Shaohui-B21989 <B21989@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmh1c2hhbiBCaGFyYXQt
UjY1Nzc3DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXkgMTYsIDIwMTMgMjo0OCBQTQ0KPiBUbzogdGll
anVuLmNoZW47IEJlbmphbWluIEhlcnJlbnNjaG1pZHQNCj4gQ2M6IFphbmcgUm95LVI2MTkxMTsg
TGl1IFFpYW5nLUIzMjYxNjsgRmxlbWluZyBBbmR5LUFGTEVNSU5HOyBsaW51eHBwYy0NCj4gZGV2
QGxpc3RzLm96bGFicy5vcmc7IFhpZSBTaGFvaHVpLUIyMTk4OQ0KPiBTdWJqZWN0OiBSRTogU0FU
QSBGU0wgYW5kIHVwc3RyZWFtaW5nDQo+IA0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPiBGcm9tOiB0aWVqdW4uY2hlbiBbbWFpbHRvOnRpZWp1bi5jaGVuQHdpbmRy
aXZlci5jb21dDQo+ID4gU2VudDogVGh1cnNkYXksIE1heSAxNiwgMjAxMyAxMjoxMyBQTQ0KPiA+
IFRvOiBCZW5qYW1pbiBIZXJyZW5zY2htaWR0DQo+ID4gQ2M6IFphbmcgUm95LVI2MTkxMTsgTGl1
IFFpYW5nLUIzMjYxNjsgRmxlbWluZyBBbmR5LUFGTEVNSU5HOw0KPiA+IGxpbnV4cHBjLSBkZXZA
bGlzdHMub3psYWJzLm9yZzsgWGllIFNoYW9odWktQjIxOTg5OyBCaHVzaGFuDQo+ID4gQmhhcmF0
LVI2NTc3Nw0KPiA+IFN1YmplY3Q6IFJlOiBTQVRBIEZTTCBhbmQgdXBzdHJlYW1pbmcNCj4gPg0K
PiA+IE9uIDA1LzE2LzIwMTMgMDI6NDAgUE0sIEJlbmphbWluIEhlcnJlbnNjaG1pZHQgd3JvdGU6
DQo+ID4gPiBPbiBUaHUsIDIwMTMtMDUtMTYgYXQgMTQ6MzUgKzA4MDAsIHRpZWp1bi5jaGVuIHdy
b3RlOg0KPiA+ID4+IE9uIDA1LzE2LzIwMTMgMDI6MjEgUE0sIEJlbmphbWluIEhlcnJlbnNjaG1p
ZHQgd3JvdGU6DQo+ID4gPj4+IE9uIFRodSwgMjAxMy0wNS0xNiBhdCAxNDoxNyArMDgwMCwgdGll
anVuLmNoZW4gd3JvdGU6DQo+ID4gPj4+PiBJIHRoaW5rIHlvdSBjYW4gdXNlIEJoYXJhdCdzIFJD
Vywgd2hpY2ggc2VlbXMgUlJfSFhBUE5TUF8weDM2LA0KPiA+ID4+Pj4gdGhlbiBwbGVhc2UgdGFr
ZSBhIGxvb2sgYXQgdGhpczoNCj4gPiA+Pj4NCj4gPiA+Pj4gT2ssIGhvdyBkbyBJIHVwZGF0ZSBt
eSBSQ1cgdG8gYnNlIEJoYXJhdCdzID8NCj4gPiA+Pg0KPiA+ID4+DQo+ID4gPj4gRmlyc3RseSBw
bGVhc2UgY2hlY2sgd2hpY2ggZmxhc2ggYmFuayBpcyB1c2VkIHNpbmNlIHdlIGhhdmUgdG8ga25v
dw0KPiA+ID4+IHdoZXJlIHNob3VsZCBiZSB1cGRhdGVkIFJDVy4NCj4gPiA+Pg0KPiA+ID4+IFdo
YXQgaXMgU1c3WzE6NF0/DQo+ID4gPj4NCj4gPiA+PiBPciB3ZSBoYXZlIGFub3RoZXIgc2ltcGxl
IHdheSBpbiB1LWJvb3QgcHJvbXB0Og0KPiA+ID4+DQo+ID4gPj4gPT4gbWQuYiBmZmRmMDAyYw0K
PiA+ID4+IGZmZGYwMDJjOiA0ZiAwMCBmZSAwMCAzOSAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMA0KPiBPLi4uOS4uLi4uLi4uLi4uDQo+ID4gPj4gLi4uDQo+ID4gPg0KPiA+ID4gZmZk
ZjAwMmM6IDBmIDAwIGZlIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwDQo+IDAw
ICAgIC4uLi4uLi4uLi4uLi4uLi4NCj4gPiA+DQo+ID4gPj4gVGhpcyBtZWFucyB3ZSdyZSBvbiBi
YW5rNC4NCj4gPiA+DQo+ID4gPiBJIGFzc3VtZSB0aGF0IG1lYW5zIGJhbmswID8NCj4gPg0KPiA+
IFllcywgUkNXIHNob3VsZCBiZSBidXJuZWQgdG8gMHhlYzAwMDAwMC4NCj4gPg0KPiA+IEluIHUt
Ym9vdCBwcm9tcHQ6DQo+ID4NCj4gPiA9PiBsb2FkeQ0KPiA+ICMjIFJlYWR5IGZvciBiaW5hcnkg
KHltb2RlbSkgZG93bmxvYWQgdG8gMHgwMTAwMDAwMCBhdCAxMTUyMDAgYnBzLi4uDQo+ID4gQw0K
PiA+DQo+ID4gVGhlbiBzZW5kIHRoYXQgUkNXIHdpdGggeW1vZGVtIGluIHlvdXIgdGVybWluYWwg
Y2xpZW50Lg0KPiANCj4gMSkgTG9hZCBSQ1cgYXMgVGllanVuIG9uIHNvbWUgYWRkcmVzcyBpbiBE
RFIuDQo+IA0KPiAyKSBCcnVuIFJDVyBhdCAweGVjMDAwMDAwOg0KPiBwcm90ZWN0IG9mZiAweGVj
MDAwMDAwICskZmlsZXNpemU7IGVyYXNlIDB4ZWMwMDAwMDAgKyRmaWxlc2l6ZTsgY3AuYg0KPiAw
eDEwMDAwMDAgMHhlYzAwMDAwMCAkZmlsZXNpemUNCj4gDQo+IDMpIHJ1biAiIHBpeCBhbHRiYWsi
IGNvbW1hbmQNCj4gDQo+IDQpIGNoZWNrIHlvdSBhcmUgb24gYmFuazQNCj4gDQo+IDUpIElmIHlv
dSBhcmUgbHVja2llciB0aGVuIG5ldHdvcmtpbmcgd2lsbCB3b3JrIGZvciB5b3UuDQp0aGUgc3Rl
cHMgbG9vayBnb29kLg0KUGxlYXNlIGFsc28gcHJvdmlkZSBhIFJDVyBiaW5hcnkgdG8gQmVuLCBp
ZiB5b3VyIGd1eXMgaW5zaXN0IHVwZGF0aW5nICB0aGUgUkNXLg0KUm95DQo=
