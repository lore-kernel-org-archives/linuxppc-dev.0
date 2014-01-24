Return-Path: <Yuantian.Tang@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 53B322C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jan 2014 14:06:12 +1100 (EST)
From: Yuantian Tang <Yuantian.Tang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH] clk: corenet: Update the clock bindings
Date: Fri, 24 Jan 2014 03:05:57 +0000
Message-ID: <ab64f4bbf44b41a3bd462f538dffc6d4@BL2PR03MB115.namprd03.prod.outlook.com>
References: <1390269732-22798-1-git-send-email-Yuantian.Tang@freescale.com>
 <1390437863.24905.549.camel@snotra.buserror.net>
 <d61cabaec0af4aada9fadf93e7c0bb61@BL2PR03MB115.namprd03.prod.outlook.com>
 <1390511008.24905.581.camel@snotra.buserror.net>
 <a0800d606e364b5980fe5c17efca9d9e@BL2PR03MB115.namprd03.prod.outlook.com>
 <1390530934.24905.639.camel@snotra.buserror.net>
 <ac1c6cb1a6e54f6e87b76e2a3006b64a@BL2PR03MB115.namprd03.prod.outlook.com>
 <1390531664.24905.640.camel@snotra.buserror.net>
In-Reply-To: <1390531664.24905.640.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "prabhakar@freescale.com" <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiA+ID4gPiA+IEluIGFueSBjYXNlLCBpZiAicW9yaXEiIG1ha2VzIHNlbnNlIGZvciB0aGUgY29t
cGF0aWJsZSwgSSBkb24ndA0KPiA+ID4gPiA+IHNlZSB3aHkgaXQgZG9lc24ndCBtYWtlIHNlbnNl
IGZvciB0aGUgZHJpdmVyLg0KPiA+ID4gPiA+DQo+ID4gPiA+IFNvLCAiQ29yZW5ldCIgaXMgYXBw
cm9wcmlhdGUgZm9yIGRyaXZlci4NCj4gPiA+ID4gSWYgc29tZXRoaW5nIHNob3VsZCBjaGFuZ2Us
IHRoYXQgbXVzdCBiZSBjb21wYXRpYmxlIHN0cmluZy4NCj4gPiA+DQo+ID4gPiBOby4gIENvcmVu
ZXQgaXMgYSBidXMgaW50ZXJjb25uZWN0LCBub3QgYSBjaGlwIGZhbWlseSAoZGVzcGl0ZSBhYnVz
ZQ0KPiA+ID4gb2YgdGhlIG5hbWUgaW4gb3RoZXIgY29udGV4dHMgaW4gTGludXgvVS1Cb290KS4g
IEFuZCB0aGUgYmluZGluZw0KPiA+ID4gd2l0aCBxb3JpcSBoYXMgYWxyZWFkeSBiZWVuIGFjY2Vw
dGVkLg0KPiA+ID4NCj4gPiBRb3JJUSBpcyBub3QgdGhlIGJlc3QgbmFtZSBlaXRoZXIgc2luY2Ug
aXQgaW5jbHVkZSB0aGUgbG93LWVuZCBzb2NzLg0KPiA+IFdoYXQgdGhlIG5hbWUgc2hvdWxkIGJl
Pw0KPiANCj4gQWdhaW4sIHRob3NlIGxvdy1lbmQgY2hpcHMgZG8gbm90IGltcGxlbWVudCAiUW9y
SVEgQ2hhc3NpcyAxLjAiIG9yICJRb3JJUQ0KPiBDaGFzc2lzIDIuMCIuICBUaGF0IHRoZXkgaGF2
ZSAiUW9ySVEiIGluIHRoZWlyIG5hbWUgaXMgaXJyZWxldmFudC4NCj4gDQpHb3QgaXQuIA0KDQpS
ZWdhcmRzLA0KWXVhbnRpYW4NCg0KPiAtU2NvdHQNCj4gDQoNCg==
