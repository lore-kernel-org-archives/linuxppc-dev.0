Return-Path: <r61911@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C70102C0EEE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 16:37:52 +1000 (EST)
From: Zang Roy-R61911 <r61911@freescale.com>
To: tiejun.chen <tiejun.chen@windriver.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: RE: SATA FSL and upstreaming
Date: Thu, 16 May 2013 06:37:41 +0000
Message-ID: <3E027F8168735B46AC006B1D0C7BB0020B1E0515@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1368679657.9603.32.camel@pasglop>
 <1368683156.9603.34.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C307@039-SN2MPN1-012.039d.mgd.msft.net>
 <3E027F8168735B46AC006B1D0C7BB0020B1E040F@039-SN2MPN1-011.039d.mgd.msft.net>
 <1368684547.9603.38.camel@pasglop> <51947A00.9010504@windriver.com>
 <1368685307.9603.39.camel@pasglop> <51947E35.30808@windriver.com>
In-Reply-To: <51947E35.30808@windriver.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Liu Qiang-B32616 <B32616@freescale.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Xie Shaohui-B21989 <B21989@freescale.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogdGllanVuLmNoZW4gW21h
aWx0bzp0aWVqdW4uY2hlbkB3aW5kcml2ZXIuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDE2
LCAyMDEzIDI6MzYgUE0NCj4gVG86IEJlbmphbWluIEhlcnJlbnNjaG1pZHQNCj4gQ2M6IFphbmcg
Um95LVI2MTkxMTsgTGl1IFFpYW5nLUIzMjYxNjsgRmxlbWluZyBBbmR5LUFGTEVNSU5HOyBsaW51
eHBwYy0NCj4gZGV2QGxpc3RzLm96bGFicy5vcmc7IFhpZSBTaGFvaHVpLUIyMTk4OTsgQmh1c2hh
biBCaGFyYXQtUjY1Nzc3DQo+IFN1YmplY3Q6IFJlOiBTQVRBIEZTTCBhbmQgdXBzdHJlYW1pbmcN
Cj4gDQo+IE9uIDA1LzE2LzIwMTMgMDI6MjEgUE0sIEJlbmphbWluIEhlcnJlbnNjaG1pZHQgd3Jv
dGU6DQo+ID4gT24gVGh1LCAyMDEzLTA1LTE2IGF0IDE0OjE3ICswODAwLCB0aWVqdW4uY2hlbiB3
cm90ZToNCj4gPj4gSSB0aGluayB5b3UgY2FuIHVzZSBCaGFyYXQncyBSQ1csIHdoaWNoIHNlZW1z
IFJSX0hYQVBOU1BfMHgzNiwgdGhlbg0KPiA+PiBwbGVhc2UgdGFrZSBhIGxvb2sgYXQgdGhpczoN
Cj4gPg0KPiA+IE9rLCBob3cgZG8gSSB1cGRhdGUgbXkgUkNXIHRvIGJzZSBCaGFyYXQncyA/DQo+
IA0KPiANCj4gRmlyc3RseSBwbGVhc2UgY2hlY2sgd2hpY2ggZmxhc2ggYmFuayBpcyB1c2VkIHNp
bmNlIHdlIGhhdmUgdG8ga25vdyB3aGVyZQ0KPiBzaG91bGQgYmUgdXBkYXRlZCBSQ1cuDQo+IA0K
PiBXaGF0IGlzIFNXN1sxOjRdPw0KPiANCj4gT3Igd2UgaGF2ZSBhbm90aGVyIHNpbXBsZSB3YXkg
aW4gdS1ib290IHByb21wdDoNCj4gDQo+ID0+IG1kLmIgZmZkZjAwMmMNCj4gZmZkZjAwMmM6IDRm
IDAwIGZlIDAwIDM5IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwDQo+IE8uLi45Li4u
Li4uLi4uLi4NCj4gLi4uDQo+IA0KPiBUaGlzIG1lYW5zIHdlJ3JlIG9uIGJhbms0Lg0KQmVuJ3Mg
bG9nIHNob3dzIGl0IGlzIGJhbmswLg0KDQpCb2FyZDogUDUwMjBEUywgU3lzIElEOiAweDFjLCBT
eXMgVmVyOiAweDEyLCBGUEdBIFZlcjogMHgwNSwgdkJhbms6IDANCg0KUm95DQo=
