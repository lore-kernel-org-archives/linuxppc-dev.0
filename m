Return-Path: <B21989@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 725C42C056C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 17:20:30 +1000 (EST)
From: Xie Shaohui-B21989 <B21989@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: SATA FSL and upstreaming
Date: Thu, 16 May 2013 07:20:21 +0000
Message-ID: <ED492CCEAF882048BC2237DE806547C90B1B19D2@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1368679657.9603.32.camel@pasglop>
 <1368683156.9603.34.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C307@039-SN2MPN1-012.039d.mgd.msft.net>
 <3E027F8168735B46AC006B1D0C7BB0020B1E040F@039-SN2MPN1-011.039d.mgd.msft.net>
 <1368684547.9603.38.camel@pasglop> <51947A00.9010504@windriver.com>
 <1368685307.9603.39.camel@pasglop> <51947E35.30808@windriver.com>
 <1368686426.9603.49.camel@pasglop> <5194800D.3010606@windriver.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C498@039-SN2MPN1-012.039d.mgd.msft.net>
 <3E027F8168735B46AC006B1D0C7BB0020B1E056D@039-SN2MPN1-011.039d.mgd.msft.net>
 <1368687218.9603.52.camel@pasglop>
 <3E027F8168735B46AC006B1D0C7BB0020B1E05BC@039-SN2MPN1-011.039d.mgd.msft.net>
 <1368687941.9603.56.camel@pasglop>
In-Reply-To: <1368687941.9603.56.camel@pasglop>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Liu Qiang-B32616 <B32616@freescale.com>,
 Zang Roy-R61911 <r61911@freescale.com>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCZW5qYW1pbiBIZXJyZW5zY2ht
aWR0IFttYWlsdG86YmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnXQ0KPiBTZW50OiBUaHVyc2RheSwg
TWF5IDE2LCAyMDEzIDM6MDYgUE0NCj4gVG86IFphbmcgUm95LVI2MTkxMQ0KPiBDYzogQmh1c2hh
biBCaGFyYXQtUjY1Nzc3OyB0aWVqdW4uY2hlbjsgTGl1IFFpYW5nLUIzMjYxNjsgRmxlbWluZyBB
bmR5LQ0KPiBBRkxFTUlORzsgbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IFhpZSBTaGFv
aHVpLUIyMTk4OQ0KPiBTdWJqZWN0OiBSZTogU0FUQSBGU0wgYW5kIHVwc3RyZWFtaW5nDQo+IA0K
PiBPbiBUaHUsIDIwMTMtMDUtMTYgYXQgMDc6MDEgKzAwMDAsIFphbmcgUm95LVI2MTkxMSB3cm90
ZToNCj4gDQo+ID4gSSBqdXN0IHRyaWVkIHlvdXIgUkNXLiBvbmUgZTEwMDAgY2FyZCB3b3JrcyBp
biBzbG90Ny4NCj4gPiB3ZSBtYXkgbmVlZCB0byBjaGVjayBvdGhlcnMgLi4uDQo+IA0KPiBUcmll
ZCA0IGFuZCA3IC4uLg0KPiANCj4gTm90ZSB0aGF0IHRoaXMgKnVzZWQqIHRvIHdvcmsuIExhc3Qg
eWVhciBJIGhhZCB0aGlzIG1hY2hpbmUgdXAgd2l0aCAyDQo+IGNhcmRzIGRvaW5nIHRoaW5ncy4g
Tm90IHN1cmUgd2hhdCBjaGFuZ2VkLCBpdCdzIHBvc3NpYmxlIHRoYXQgdGhlIERJUCBnb3QNCj4g
aW5hZHZlcnRlbnRseSBjaGFuZ2VkLiANCltTLkhdIFBsZWFzZSBjaGVjayB0aGUgU1cyWzE6NF0s
IHNob3VsZCBiZTogb2ZmIG9mZiBvbiBvZmYNCg0KW1MuSF0gQmVzdCBSZWdhcmRzLCANClNoYW9o
dWkgWGllDQo=
