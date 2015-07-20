Return-Path: <yangbo.lu@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0143.outbound.protection.outlook.com [207.46.100.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 250C41A094B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 16:59:05 +1000 (AEST)
From: Lu Y.B. <yangbo.lu@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: powerpc/corenet: enable eSDHC
Date: Mon, 20 Jul 2015 06:43:44 +0000
Message-ID: <BY1PR0301MB119285C61D7CDC037DD240DAF2850@BY1PR0301MB1192.namprd03.prod.outlook.com>
References: <1430893748-38821-1-git-send-email-yangbo.lu@freescale.com>
 <20150530000331.GA9143@home.buserror.net>
 <BY1PR0301MB119286F6B8EBD6EED07C8B15F2BF0@BY1PR0301MB1192.namprd03.prod.outlook.com>
 <1433795433.2477.62.camel@freescale.com>
 <BY1PR0301MB1192803896118A14B8A2ABF3F2990@BY1PR0301MB1192.namprd03.prod.outlook.com>
 <1437078653.2993.121.camel@freescale.com>
In-Reply-To: <1437078653.2993.121.camel@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiBPSywgdGhhbmtzLiAgQXNzdW1pbmcgbm8gc2ltaWxhciBpc3N1ZXMgd2hlbiB0ZXN0aW5nLCBJ
J2xsIGFwcGx5IHRoaXMNCj4gcGF0Y2ggdGhlIG5leHQgdGltZSBJIGRvIGEgYmF0Y2ggb2YgcGF0
Y2ggYXBwbGljYXRpb24uDQo+IA0KPiBBbnkgdGhvdWdodHMgcmVnYXJkaW5nIGJldHRlciBlcnJv
ciBoYW5kbGluZz8NCj4gDQo+IC1TY290dA0KDQpEbyB5b3UgbWVhbiBTRCB0ZXN0Pw0KQWN0dWFs
bHkgU0QgcGF0Y2hlcyBuZWVkaW5nIHRvIHNlbnQgdG8gdXBzdHJlYW0gYXJlIHRlc3RlZCBvbiBM
aSBZYW5nJ3MgTGludXggdHJlZS4NCkFuZCB0aGUgSklSQSB0aWNrZXQgaXMgUU9SSVFMVS0xOS4N
Cg0KDQo+IA0KPiBPbiBXZWQsIDIwMTUtMDctMTUgYXQgMjE6MzcgLTA1MDAsIEx1IFlhbmdiby1C
NDcwOTMgd3JvdGU6DQo+ID4gSGkgU2NvdHQsDQo+ID4NCj4gPiBOb3cgdGhlIHBhdGNoIGJlbG93
IGhhcyBiZWVuIG1lcmdlZCBvbg0KPiA+IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQuDQo+ID4gVGhpcyBpc3N1ZSBzaG91bGQg
aGF2ZSBiZWVuIHJlc29sdmVkLg0KPiA+IFRoYW5rcy4NCj4gPg0KPiA+DQo+ID4gY29tbWl0IDVm
ZDI2YzdlY2IzMjA4Mjc0NWIwYmQzM2M4ZTM1YmFkZDFjYjVhOTENCj4gPiBBdXRob3I6IFVsZiBI
YW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiA+IERhdGU6ICAgRnJpIEp1biA1IDEx
OjQwOjA4IDIwMTUgKzAyMDANCj4gPg0KPiA+ICAgICBtbWM6IHNkaGNpOiBSZXN0b3JlIGJlaGF2
aW9yIHdoaWxlIGNyZWF0aW5nIE9DUiBtYXNrDQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFdvb2QgU2NvdHQtQjA3NDIxDQo+ID4gPiBTZW50
OiBUdWVzZGF5LCBKdW5lIDA5LCAyMDE1IDQ6MzEgQU0NCj4gPiA+IFRvOiBMdSBZYW5nYm8tQjQ3
MDkzDQo+ID4gPiBDYzogbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IGxpbnV4LW1tY0B2
Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IFN1YmplY3Q6IFJlOiBwb3dlcnBjL2NvcmVuZXQ6IGVuYWJs
ZSBlU0RIQw0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgMjAxNS0wNi0wOCBhdCAwNToxMiAtMDUwMCwg
THUgWWFuZ2JvLUI0NzA5MyB3cm90ZToNCj4gPiA+ID4gVGhhbmtzIGEgbG90LCBTY290dC4NCj4g
PiA+ID4gQW5kIG5vdyBhIHBhdGNoIHdhcyBtZXJnZWQgb24NCj4gPiA+ID4gZ2l0Oi8vZ2l0Lmxp
bmFyby5vcmcvcGVvcGxlL3VsZi5oYW5zc29uL21tYy5naXQgbmV4dCBicmFuY2ggdG8gZml4DQo+
ID4gPiA+IHRoaXMgaXNzdWUuDQo+ID4gPiA+IEl0IHNob3VsZCBiZSBubyBwcm9ibGVtLg0KPiA+
ID4NCj4gPiA+IEFzc3VtaW5nIHRoYXQgcGF0Y2ggZml4ZXMgaXQgYW5kIGdldHMgcHVsbGVkIGZv
ciA0LjIsIHRoaXMgY29uZmlnDQo+ID4gPiBwYXRjaCBjYW4gZ28gaW4gZm9yIDQuMy4NCj4gPiA+
DQo+ID4gPiBUaGF0IHNhaWQsIGl0IHdvdWxkIGJlIG5pY2UgaWYsIGFwYXJ0IGZyb20gZml4aW5n
IHRoZSBwcm9ibGVtDQo+ID4gPiBpdHNlbGYsIHRoZSBNTUMgY29kZSBmYWlsZWQgbW9yZSBncmFj
ZWZ1bGx5IGluc3RlYWQgb2YgZW5kbGVzc2x5DQo+ID4gPiByZXBlYXRpbmcgYW5kIGZpbGxpbmcg
dXAgdGhlIGxvZy9jb25zb2xlLg0KPiA+ID4NCj4gPiA+IC1TY290dA0KPiA+DQo=
