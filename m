Return-Path: <Yuantian.Tang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0188.outbound.protection.outlook.com [207.46.163.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B14B82C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jan 2014 13:46:23 +1100 (EST)
From: Yuantian Tang <Yuantian.Tang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH] clk: corenet: Update the clock bindings
Date: Fri, 24 Jan 2014 02:46:15 +0000
Message-ID: <ac1c6cb1a6e54f6e87b76e2a3006b64a@BL2PR03MB115.namprd03.prod.outlook.com>
References: <1390269732-22798-1-git-send-email-Yuantian.Tang@freescale.com>
 <1390437863.24905.549.camel@snotra.buserror.net>
 <d61cabaec0af4aada9fadf93e7c0bb61@BL2PR03MB115.namprd03.prod.outlook.com>
 <1390511008.24905.581.camel@snotra.buserror.net>
 <a0800d606e364b5980fe5c17efca9d9e@BL2PR03MB115.namprd03.prod.outlook.com>
 <1390530934.24905.639.camel@snotra.buserror.net>
In-Reply-To: <1390530934.24905.639.camel@snotra.buserror.net>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXb29kIFNjb3R0LUIwNzQyMQ0K
PiBTZW50OiAyMDE05bm0MeaciDI05pelIOaYn+acn+S6lCAxMDozNg0KPiBUbzogVGFuZyBZdWFu
dGlhbi1CMjk5ODMNCj4gQ2M6IGdhbGFrQGtlcm5lbC5jcmFzaGluZy5vcmc7IGxpbnV4cHBjLWRl
dkBsaXN0cy5vemxhYnMub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgS3VzaHdh
aGEgUHJhYmhha2FyLUIzMjU3OQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBjbGs6IGNvcmVuZXQ6
IFVwZGF0ZSB0aGUgY2xvY2sgYmluZGluZ3MNCj4gDQo+IE9uIFRodSwgMjAxNC0wMS0yMyBhdCAy
MDozMyAtMDYwMCwgVGFuZyBZdWFudGlhbi1CMjk5ODMgd3JvdGU6DQo+ID4gPiA+ID4gSW5zdGVh
ZCwgaG93IGFib3V0IGEgbm90ZSBsaWtlIHRoaXMgbmVhciB0aGUgdG9wIG9mIHRoZSBmaWxlOg0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gQWxsIHJlZmVyZW5jZXMgdG8gIjEuMCIgYW5kICIyLjAiIHJl
ZmVyIHRvIHRoZSBRb3JJUSBjaGFzc2lzDQo+ID4gPiA+ID4gdmVyc2lvbiB0byB3aGljaCB0aGUg
Y2hpcCBjb21wbGllcy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IENoYXNzaXMgVmVyc2lvbgkJRXhh
bXBsZSBDaGlwcw0KPiA+ID4gPiA+IC0tLS0tLS0tLS0tLS0tLQkJLS0tLS0tLS0tLS0tLQ0KPiA+
ID4gPiA+IDEuMAkJCXA0MDgwLCBwNTAyMCwgcDUwNDANCj4gPiA+ID4gPiAyLjAJCQl0NDI0MCwg
YjQ4NjAsIHQxMDQwDQo+ID4gPiA+ID4NCj4gPiA+ID4gQmV0dGVyLCBJIHdpbGwgdXBkYXRlLg0K
PiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQlRXLCB0aGlzIGJpbmRpbmcgYW5kIHRoZSBh
c3NvY2lhdGVkIGRyaXZlciByZWFsbHkgc2hvdWxkIGJlDQo+ID4gPiA+ID4gY2FsbGVkICJxb3Jp
cS1jbG9jayIsIG5vdCAiY29yZW5ldC1jbG9jayIuICBUaGlzIHdvdWxkIG1hdGNoIHRoZQ0KPiA+
ID4gPiA+IGNvbXBhdGlibGUgc3RyaW5nLCBhbmQgaXQgZG9lc24ndCByZWFsbHkgaGF2ZSBtdWNo
IHRvIGRvIHdpdGgNCj4gPiA+ID4gPiBjb3JlbmV0ICh3aGljaCBpcyBwYXJ0IG9mIHRoZSBRb3JJ
USBjaGFzc2lzIHYxIGFuZCB2MiwgYnV0IG5vdA0KPiA+ID4gPiA+ICp0aGlzKiBwYXJ0KS4gIERv
IHlvdSBrbm93IGlmIHRoZSBjaGFzc2lzIHYzIGNsb2NrIGludGVyZmFjZQ0KPiA+ID4gPiA+IHdp
bGwgYmUgc2ltaWxhciBlbm91Z2ggdG8NCj4gPiA+IHNoYXJlIGEgZHJpdmVyPw0KPiA+ID4gPiA+
DQo+ID4gPiA+IERvZXNuJ3QgUW9ySVEgaW5jbHVkZSBzb21lIGxvdy1lbmQgc29jcywgbGlrZSBw
MTAyMiwgcDEwMjA/DQo+ID4gPg0KPiA+ID4gWWVzLCBidXQgdGhvc2UgYXJlbid0ICJRb3JJUSBD
aGFzc2lzIDEuMCIgb3IgIlFvcklRIENoYXNzaXMgMi4wIi4NCj4gPiA+IFRoZXkncmUgbXBjODV4
eC1mYW1pbHkgY2hpcHMuDQo+ID4gPg0KPiA+ID4gSW4gYW55IGNhc2UsIGlmICJxb3JpcSIgbWFr
ZXMgc2Vuc2UgZm9yIHRoZSBjb21wYXRpYmxlLCBJIGRvbid0IHNlZQ0KPiA+ID4gd2h5IGl0IGRv
ZXNuJ3QgbWFrZSBzZW5zZSBmb3IgdGhlIGRyaXZlci4NCj4gPiA+DQo+ID4gU28sICJDb3JlbmV0
IiBpcyBhcHByb3ByaWF0ZSBmb3IgZHJpdmVyLg0KPiA+IElmIHNvbWV0aGluZyBzaG91bGQgY2hh
bmdlLCB0aGF0IG11c3QgYmUgY29tcGF0aWJsZSBzdHJpbmcuDQo+IA0KPiBOby4gIENvcmVuZXQg
aXMgYSBidXMgaW50ZXJjb25uZWN0LCBub3QgYSBjaGlwIGZhbWlseSAoZGVzcGl0ZSBhYnVzZSBv
Zg0KPiB0aGUgbmFtZSBpbiBvdGhlciBjb250ZXh0cyBpbiBMaW51eC9VLUJvb3QpLiAgQW5kIHRo
ZSBiaW5kaW5nIHdpdGggcW9yaXENCj4gaGFzIGFscmVhZHkgYmVlbiBhY2NlcHRlZC4NCj4gDQpR
b3JJUSBpcyBub3QgdGhlIGJlc3QgbmFtZSBlaXRoZXIgc2luY2UgaXQgaW5jbHVkZSB0aGUgbG93
LWVuZCBzb2NzLg0KV2hhdCB0aGUgbmFtZSBzaG91bGQgYmU/IA0KDQpSZWdhcmRzLA0KWXVhbnRp
YW4NCg0KPiAtU2NvdHQNCj4gDQoNCg==
