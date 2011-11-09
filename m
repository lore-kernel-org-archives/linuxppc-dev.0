Return-Path: <r61911@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 3E616B6F85
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 02:27:58 +1100 (EST)
Received: from mail101-tx2 (localhost.localdomain [127.0.0.1])	by
 mail101-tx2-R.bigfish.com (Postfix) with ESMTP id AC89B15F838A	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 15:27:42 +0000 (UTC)
Received: from TX2EHSMHS044.bigfish.com (unknown [10.9.14.254])	by
 mail101-tx2.bigfish.com (Postfix) with ESMTP id 031ED1710052	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 15:26:54 +0000 (UTC)
From: Zang Roy-R61911 <r61911@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH] powerpc/p1023: set IRQ[4:6, 11] to high level sensitive
 for PCIe
Date: Wed, 9 Nov 2011 15:27:02 +0000
Message-ID: <2239AC579C7D3646A720227A37E0268120EC83@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1320654778-3294-1-git-send-email-tie-fei.zang@freescale.com>
 <4EB826F1.50402@freescale.com>
 <2239AC579C7D3646A720227A37E0268120D5C5@039-SN1MPN1-004.039d.mgd.msft.net>
 <4EB95EBC.8010808@freescale.com>
In-Reply-To: <4EB95EBC.8010808@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAwOSwgMjAxMSAwOjU0IEFNDQo+IFRvOiBa
YW5nIFJveS1SNjE5MTENCj4gQ2M6IFdvb2QgU2NvdHQtQjA3NDIxOyBsaW51eHBwYy1kZXZAbGlz
dHMub3psYWJzLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBwb3dlcnBjL3AxMDIzOiBzZXQg
SVJRWzQ6NiwgMTFdIHRvIGhpZ2ggbGV2ZWwgc2Vuc2l0aXZlIGZvcg0KPiBQQ0llDQo+IA0KPiBP
biAxMS8wNy8yMDExIDExOjUxIFBNLCBaYW5nIFJveS1SNjE5MTEgd3JvdGU6DQo+ID4NCj4gPg0K
PiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBXb29kIFNjb3R0LUIw
NzQyMQ0KPiA+PiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAwOCwgMjAxMSAyOjQ0IEFNDQo+ID4+
IFRvOiBaYW5nIFJveS1SNjE5MTENCj4gPj4gQ2M6IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMu
b3JnDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHBvd2VycGMvcDEwMjM6IHNldCBJUlFbNDo2
LCAxMV0gdG8gaGlnaCBsZXZlbCBzZW5zaXRpdmUNCj4gZm9yDQo+ID4+IFBDSWUNCj4gPj4NCj4g
Pj4gT24gMTEvMDcvMjAxMSAwMjozMiBBTSwgUm95IFphbmcgd3JvdGU6DQo+ID4+PiBQMTAyMyBl
eHRlcm5hbCBJUlFbNDo2LCAxMV0gZG8gbm90IHBpbiBvdXQsIGJ1dCB0aGUgaW50ZXJydXB0cyBh
cmUNCj4gPj4+IHNoYXJlZCB3aXRoIFBDSWUgY29udHJvbGxlci4NCj4gPj4+IFRoZSBzaWxpY29u
IGludGVybmFsbHkgdGllcyB0aGUgaW50ZXJydXB0cyB0byBMLCBzbyBjaGFuZ2UgdGhlDQo+ID4+
PiBJUlFbNDo2LDExXSB0byBoaWdoIGxldmVsIHNlbnNpdGl2ZSBmb3IgUENJZS4NCj4gPj4NCj4g
Pj4gU29tZSBleHRyYSBjb21tZW50YXJ5IG9uIHdoeSB0aGlzIHdvcmtzIHdvdWxkIGJlIG5pY2Uu
DQo+ID4gSSBkbyBub3Qga25vdyB3aGF0IGtpbmQgb2YgZXh0cmEgY29tbWVudGFyeSB5b3UgcmVx
dWVzdC4NCj4gDQo+IEp1c3QgYSBub3RlIHRoYXQgdGhlcmUncyBtYWdpYyB0byBhbGxvdyB0aGUg
UENJZSBibG9jayB0byBvdXRwdXQgdGhlc2UNCj4gaW50ZXJydXB0cyBhcyBlaXRoZXIgYWN0aXZl
LWhpZ2ggb3IgYWN0aXZlLWxvdywgZGVwZW5kaW5nIG9uIGhvdyB0aGV5J3JlDQo+IGNvbmZpZ3Vy
ZWQgYXQgdGhlIG1waWMuDQpJIGRvIG5vdCB0aGluayB0aGVyZSBpcyBhbnkgbWFnaWMuDQpPbiB0
aGUgY29udHJhcnksIGl0IGlzIHRoZSBtcGljL2RldmljZSB0cmVlIG5lZWRzIHRvIGNvbXBseSB3
aXRoIHRoZSBoYXJkd2FyZSBzZXR0aW5nIGZvciB0aGUgaW50ZXJydXB0IHBvbGFyaXR5Lg0KDQo+
IA0KPiA+IElSUSA0LDUsNiwgMTEgYXJlIGludGVybmFsbHkgdGllIHRvIGxvdyBieSBzaWxpY29u
LiBUbyB1c2UgdGhlc2UgaW50ZXJydXB0cw0KPiBmb3IgUENJZSwgdGhleSBuZWVkIHRvIHNldCBo
aWdoIGxldmVsIHNlbnNpdGl2ZS4NCj4gPiBJdCBpcyBjbGVhciBlbm91Z2ggZm9yIHRoaXMgcGF0
Y2guDQo+IA0KPiBJdCdzIG9kZCBlbm91Z2ggdGhhdCBJIGZlbHQgdGhlIG5lZWQgdG8gZ28gcmVh
ZGluZyB0aHJvdWdoIHRoZSBkb2NzIHRvDQo+IHNlZSB3aHkgc3VjaCBhIHRoaW5nIHdvdWxkIHdv
cmsgYXQgYWxsLg0KSWYgeW91IGNvbnNpZGVyIHRoZSBub3JtYWwgY2FzZSwgdGhlIHNoYXJlZCBp
cnEgcHVsbHMgdXAsIHRoZSBQQ0llIGludGVycnVwdCBzZXQgdG8gbG93IGxldmVsIHNlbnNpdGl2
ZS4gQW55dGhpbmcgb2RkPw0KDQo+IA0KPiA+PiBUaGUgbWFudWFsIHNheXM6DQo+ID4+DQo+ID4+
PiBJZiBhIFBDSSBFeHByZXNzIElOVHggaW50ZXJydXB0IGlzIGJlaW5nIHVzZWQsIHRoZW4gdGhl
IFBJQyBtdXN0IGJlDQo+IGNvbmZpZ3VyZWQNCj4gPj4gc28gdGhhdCBleHRlcm5hbCBpbnRlcnJ1
cHRzDQo+ID4+PiBhcmUgbGV2ZWwtc2Vuc2l0aXZlIChFSVZQUm5bU10gPSAxKS4NCj4gPiBUaGF0
IGlzIHRydWUgZm9yIGFsbCBGU0wgcG93ZXJwYyBzaWxpY29uIHdpdGggUENJZSBjb250cm9sbGVy
IGJlc2lkZSBQMTAyMy4NCj4gDQo+IFN1cmUsIG15IHBvaW50IHdhcyBtb3JlIHRoYXQgaXQgZGlk
bid0IHNheSBhbnl0aGluZyB0aGVyZSBhYm91dCBob3cgdG8NCj4gY29uZmlndXJlIEVJVlBSbltQ
XS4NCkl0IGRlcGVuZHMgb24gdGhlIGlycSBwdWxscyB1cCBvciBkb3duIGJ5IGhhcmR3YXJlLg0K
Um95DQo=
