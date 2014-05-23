Return-Path: <Shengzhou.Liu@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0207.outbound.protection.outlook.com [207.46.163.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E31F11A0ABD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 18:20:51 +1000 (EST)
From: "Shengzhou.Liu@freescale.com" <Shengzhou.Liu@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH 1/2] mtd/spi: support en25s64 device
Date: Fri, 23 May 2014 08:20:36 +0000
Message-ID: <fc3535e336a645d58be9c729f3e8db08@DM2PR03MB398.namprd03.prod.outlook.com>
References: <1400666751-11459-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1400705405.18239.92.camel@snotra.buserror.net>
In-Reply-To: <1400705405.18239.92.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gLS0tIGEvZHJpdmVycy9tdGQvZGV2
aWNlcy9tMjVwODAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbXRkL2RldmljZXMvbTI1cDgwLmMNCj4g
PiBAQCAtNzQ1LDYgKzc0NSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc3BpX2RldmljZV9pZCBt
MjVwX2lkc1tdID0gew0KPiA+ICAJeyAiZW4yNXEzMmIiLCAgIElORk8oMHgxYzMwMTYsIDAsIDY0
ICogMTAyNCwgICA2NCwgMCkgfSwNCj4gPiAgCXsgImVuMjVwNjQiLCAgICBJTkZPKDB4MWMyMDE3
LCAwLCA2NCAqIDEwMjQsICAxMjgsIDApIH0sDQo+ID4gIAl7ICJlbjI1cTY0IiwgICAgSU5GTygw
eDFjMzAxNywgMCwgNjQgKiAxMDI0LCAgMTI4LCBTRUNUXzRLKSB9LA0KPiA+ICsJeyAiZW4yNXM2
NCIsICAgIElORk8oMHgxYzM4MTcsIDAsIDY0ICogMTAyNCwgIDEyOCwgMCkgfSwNCj4gPiAgCXsg
ImVuMjVxaDI1NiIsICBJTkZPKDB4MWM3MDE5LCAwLCA2NCAqIDEwMjQsICA1MTIsIDApIH0sDQo+
ID4NCj4gPiAgCS8qIEVTTVQgKi8NCj4gDQo+IFRoaXMgbmVlZHMgdG8gYmUgc2VudCB0byB0aGUg
bXRkIGFuZC9vciBzcGkgbWFpbnRhaW5lcnMsIG5vdCBoZXJlLg0KPiANCj4gV2hhdCBkb2VzIHRo
aXMgaGF2ZSB0byBkbyB3aXRoIHBhdGNoIDIvMj8gIERvbid0IHB1dCB1bnJlbGF0ZWQgdGhpbmdz
IGluDQo+IHRoZSBzYW1lIHBhdGNoc2V0LCBlc3BlY2lhbGx5IHdoZW4gdGhleSdyZSBkZXN0aW5l
ZCBmb3IgZGlmZmVyZW50DQo+IG1haW50YWluZXJzLg0KPiANCj4gLVNjb3R0DQo+IA0KW1NoZW5n
emhvdV0gdGhhbmtzLCBzZW50IHRvIGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnIGFscmVh
ZHkuDQoNCg==
