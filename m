Return-Path: <B29983@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E75592C0103
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Sep 2013 12:30:17 +1000 (EST)
From: Tang Yuantian-B29983 <B29983@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH] powerpc: Add I2C bus multiplexer node for B4 and T4240QDS
Date: Fri, 6 Sep 2013 02:30:06 +0000
Message-ID: <D07C73A334FF604B95B3CBD2A545D07B1506A44E@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1378194704-29909-1-git-send-email-hongtao.jia@freescale.com>
 <52268C7E.4040209@windriver.com>
 <D07C73A334FF604B95B3CBD2A545D07B15056D07@039-SN2MPN1-011.039d.mgd.msft.net>
 <1378406443.12204.102.camel@snotra.buserror.net>
In-Reply-To: <1378406443.12204.102.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Yang,
 Wei" <Wei.Yang@windriver.com>, Jia Hongtao-B38951 <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFdvb2QgU2NvdHQtQjA3NDIx
DQo+IFNlbnQ6IDIwMTPlubQ55pyINuaXpSDmmJ/mnJ/kupQgMjo0MQ0KPiBUbzogVGFuZyBZdWFu
dGlhbi1CMjk5ODMNCj4gQ2M6IFlhbmcsV2VpOyBKaWEgSG9uZ3Rhby1CMzg5NTE7IFdvb2QgU2Nv
dHQtQjA3NDIxOyBsaW51eHBwYy0NCj4gZGV2QGxpc3RzLm96bGFicy5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSF0gcG93ZXJwYzogQWRkIEkyQyBidXMgbXVsdGlwbGV4ZXIgbm9kZSBmb3IgQjQg
YW5kDQo+IFQ0MjQwUURTDQo+IA0KPiBPbiBUdWUsIDIwMTMtMDktMDMgYXQgMjI6MzAgLTA1MDAs
IFRhbmcgWXVhbnRpYW4tQjI5OTgzIHdyb3RlOg0KPiA+IEhpLA0KPiA+DQo+ID4gVGhlc2UgZWVw
cm9tcyBhcmUgbmV2ZXIgdXNlZCBieSBrZXJuZWwuIFNvIG5vIG5lZWQgdG8gYWRkIHRoZW0uDQo+
IA0KPiBUaGUgZGV2aWNlIHRyZWUgZGVzY3JpYmVzIHRoZSBoYXJkd2FyZSwgbm90IHdoYXQgTGlu
dXggZG9lcyB3aXRoIGl0Lg0KPiANCk1pc3Npbmcgc29tZSBub2RlcyBkb2Vzbid0IG1lYW4gaXQg
aXMgbm90IGRlc2NyaWJpbmcgdGhlIGhhcmR3YXJlLg0KVGhlcmUgYXJlIGFsbW9zdCBmaWZ0eSBJ
MkMgZGV2aWNlcyBvbiBUNCBjb25uZWN0ZWQgdG8gUENBOTU0Ny4NCkRvIHlvdSB0aGluayB3ZSBu
ZWVkIHRvIGxpc3QgdGhlbSBhbGw/DQoNClJlZ2FyZHMsDQpZdWFudGlhbg0KDQo+IC1TY290dA0K
PiANCg0K
