Return-Path: <B40534@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B4F172C007F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2012 15:54:02 +1000 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH v2 2/2] powerpc/mpic: add global timer support
Date: Mon, 13 Aug 2012 05:53:53 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259DB147E@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1344578081-8095-1-git-send-email-Dongsheng.wang@freescale.com>
 <5025639F.4070203@freescale.com>
In-Reply-To: <5025639F.4070203@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Gala Kumar-B11780 <B11780@freescale.com>,
 "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogU2F0dXJkYXksIEF1Z3VzdCAxMSwgMjAxMiAzOjQwIEFNDQo+IFRvOiBXYW5n
IERvbmdzaGVuZy1CNDA1MzQNCj4gQ2M6IGJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZzsgcGF1bHVz
QHNhbWJhLm9yZzsgbGludXhwcGMtDQo+IGRldkBsaXN0cy5vemxhYnMub3JnOyBHYWxhIEt1bWFy
LUIxMTc4MDsgTGkgWWFuZy1SNTg0NzINCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzJdIHBv
d2VycGMvbXBpYzogYWRkIGdsb2JhbCB0aW1lciBzdXBwb3J0DQo+IA0KPiBPbiAwOC8xMC8yMDEy
IDEyOjU0IEFNLCBEb25nc2hlbmcud2FuZ0BmcmVlc2NhbGUuY29tIHdyb3RlOg0KPiA+ICtzdGF0
aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtcGljX3RpbWVyX2lkc1tdID0gew0KPiA+ICsJ
eyAuY29tcGF0aWJsZSA9ICJvcGVuLXBpYyxnbG9iYWwtdGltZXIiLCB9LA0KPiA+ICsJeyAuY29t
cGF0aWJsZSA9ICJmc2wsZ2xvYmFsLXRpbWVyIiwgfSwNCj4gPiArCXt9LA0KPiA+ICt9Ow0KPiA+
ICsNCj4gPiArc3RhdGljIGludCBfX2luaXQgbXBpY190aW1lcl9pbml0KHZvaWQpIHsNCj4gPiAr
CXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBOVUxMOw0KPiA+ICsNCj4gPiArCWZvcl9lYWNoX25v
ZGVfYnlfdHlwZShucCwgIm9wZW4tcGljIikNCj4gPiArCQlpZiAob2ZfbWF0Y2hfbm9kZShtcGlj
X3RpbWVyX2lkcywgbnApKQ0KPiA+ICsJCQlncm91cF9pbml0KG5wKTsNCj4gPiArDQo+ID4gKwlp
ZiAobGlzdF9lbXB0eSgmZ3JvdXBfbGlzdCkpDQo+ID4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+ID4g
Kw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArYXJjaF9pbml0Y2FsbChtcGljX3RpbWVy
X2luaXQpOw0KPiANCj4gT2gsIGFuZCBkb24ndCBwcm9iZSBieSBkZXZpY2VfdHlwZS4NCj4gDQpb
V2FuZyBEb25nc2hlbmddIGZpbmUuIGZvcl9lYWNoX25vZGVfYnlfbmFtZS4NCg0KPiAtU2NvdHQN
Cg0K
