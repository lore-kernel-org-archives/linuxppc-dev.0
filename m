Return-Path: <Yuantian.Tang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0236.outbound.protection.outlook.com [207.46.163.236])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 088142C0081
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jan 2014 13:33:27 +1100 (EST)
From: Yuantian Tang <Yuantian.Tang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH] clk: corenet: Update the clock bindings
Date: Fri, 24 Jan 2014 02:33:19 +0000
Message-ID: <a0800d606e364b5980fe5c17efca9d9e@BL2PR03MB115.namprd03.prod.outlook.com>
References: <1390269732-22798-1-git-send-email-Yuantian.Tang@freescale.com>
 <1390437863.24905.549.camel@snotra.buserror.net>
 <d61cabaec0af4aada9fadf93e7c0bb61@BL2PR03MB115.namprd03.prod.outlook.com>
 <1390511008.24905.581.camel@snotra.buserror.net>
In-Reply-To: <1390511008.24905.581.camel@snotra.buserror.net>
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

PiA+ID4gSW5zdGVhZCwgaG93IGFib3V0IGEgbm90ZSBsaWtlIHRoaXMgbmVhciB0aGUgdG9wIG9m
IHRoZSBmaWxlOg0KPiA+ID4NCj4gPiA+IEFsbCByZWZlcmVuY2VzIHRvICIxLjAiIGFuZCAiMi4w
IiByZWZlciB0byB0aGUgUW9ySVEgY2hhc3NpcyB2ZXJzaW9uDQo+ID4gPiB0byB3aGljaCB0aGUg
Y2hpcCBjb21wbGllcy4NCj4gPiA+DQo+ID4gPiBDaGFzc2lzIFZlcnNpb24JCUV4YW1wbGUgQ2hp
cHMNCj4gPiA+IC0tLS0tLS0tLS0tLS0tLQkJLS0tLS0tLS0tLS0tLQ0KPiA+ID4gMS4wCQkJcDQw
ODAsIHA1MDIwLCBwNTA0MA0KPiA+ID4gMi4wCQkJdDQyNDAsIGI0ODYwLCB0MTA0MA0KPiA+ID4N
Cj4gPiBCZXR0ZXIsIEkgd2lsbCB1cGRhdGUuDQo+ID4NCj4gPiA+DQo+ID4gPiBCVFcsIHRoaXMg
YmluZGluZyBhbmQgdGhlIGFzc29jaWF0ZWQgZHJpdmVyIHJlYWxseSBzaG91bGQgYmUgY2FsbGVk
DQo+ID4gPiAicW9yaXEtY2xvY2siLCBub3QgImNvcmVuZXQtY2xvY2siLiAgVGhpcyB3b3VsZCBt
YXRjaCB0aGUgY29tcGF0aWJsZQ0KPiA+ID4gc3RyaW5nLCBhbmQgaXQgZG9lc24ndCByZWFsbHkg
aGF2ZSBtdWNoIHRvIGRvIHdpdGggY29yZW5ldCAod2hpY2ggaXMNCj4gPiA+IHBhcnQgb2YgdGhl
IFFvcklRIGNoYXNzaXMgdjEgYW5kIHYyLCBidXQgbm90ICp0aGlzKiBwYXJ0KS4gIERvIHlvdQ0K
PiA+ID4ga25vdyBpZiB0aGUgY2hhc3NpcyB2MyBjbG9jayBpbnRlcmZhY2Ugd2lsbCBiZSBzaW1p
bGFyIGVub3VnaCB0bw0KPiBzaGFyZSBhIGRyaXZlcj8NCj4gPiA+DQo+ID4gRG9lc24ndCBRb3JJ
USBpbmNsdWRlIHNvbWUgbG93LWVuZCBzb2NzLCBsaWtlIHAxMDIyLCBwMTAyMD8NCj4gDQo+IFll
cywgYnV0IHRob3NlIGFyZW4ndCAiUW9ySVEgQ2hhc3NpcyAxLjAiIG9yICJRb3JJUSBDaGFzc2lz
IDIuMCIuDQo+IFRoZXkncmUgbXBjODV4eC1mYW1pbHkgY2hpcHMuDQo+IA0KPiBJbiBhbnkgY2Fz
ZSwgaWYgInFvcmlxIiBtYWtlcyBzZW5zZSBmb3IgdGhlIGNvbXBhdGlibGUsIEkgZG9uJ3Qgc2Vl
IHdoeQ0KPiBpdCBkb2Vzbid0IG1ha2Ugc2Vuc2UgZm9yIHRoZSBkcml2ZXIuDQo+IA0KU28sICJD
b3JlbmV0IiBpcyBhcHByb3ByaWF0ZSBmb3IgZHJpdmVyLg0KSWYgc29tZXRoaW5nIHNob3VsZCBj
aGFuZ2UsIHRoYXQgbXVzdCBiZSBjb21wYXRpYmxlIHN0cmluZy4NCg0KUmVnYXJkcywNCll1YW50
aWFuDQoNCj4gPiBUaGlzIGRyaXZlciBoYXMgbm90aGluZyB0byBkbyB3aXRoIHRoZXNlIGJvYXJk
cy4NCj4gPiBJIGhhdmUgbm8gaWRlYSBhYm91dCBjaGFzc2lzIHYzLiBJZiBpdCBoYXMgc2ltaWxh
ciBjbG9jayB0cmVlLCB0aGlzDQo+IGRyaXZlciBjYW4gYmUgc2hhcmVkLg0KPiA+IEV2ZW4gdGhl
IGRyaXZlciBjYW4ndCBiZSB1c2VkIGJ5IHYzLCB3ZSBjYW4gZWFzaWx5IGFkZCB2MyBzdXBwb3J0
DQo+ID4gc2luY2UgaXQgaGFzIGRpZmZlcmVudCBDb21wYXRpYmxlIHN0cmluZy4NCj4gDQo+IFRo
ZSByZWFzb24gSSBtZW50aW9uZWQgaXQgaXMgdGhhdCBjaGFzc2lzIHYzIHdpbGwgaW52b2x2ZSBB
Uk0gY2hpcHMgdGhhdA0KPiBoYXZlIHRoZWlyIG93biBpbnRlcmNvbm5lY3QgcmF0aGVyIHRoYW4g
Y29yZW5ldC4NCj4gDQo+IC1TY290dA0KPiANCg0K
