Return-Path: <yangbo.lu@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0118.outbound.protection.outlook.com [207.46.100.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B75221A0163
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 12:52:26 +1000 (AEST)
From: Lu Y.B. <yangbo.lu@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: powerpc/corenet: enable eSDHC
Date: Thu, 16 Jul 2015 02:37:21 +0000
Message-ID: <BY1PR0301MB1192803896118A14B8A2ABF3F2990@BY1PR0301MB1192.namprd03.prod.outlook.com>
References: <1430893748-38821-1-git-send-email-yangbo.lu@freescale.com>
 <20150530000331.GA9143@home.buserror.net>
 <BY1PR0301MB119286F6B8EBD6EED07C8B15F2BF0@BY1PR0301MB1192.namprd03.prod.outlook.com>
 <1433795433.2477.62.camel@freescale.com>
In-Reply-To: <1433795433.2477.62.camel@freescale.com>
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

SGkgU2NvdHQsDQoNCk5vdyB0aGUgcGF0Y2ggYmVsb3cgaGFzIGJlZW4gbWVyZ2VkIG9uIGdpdDov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5n
aXQuDQpUaGlzIGlzc3VlIHNob3VsZCBoYXZlIGJlZW4gcmVzb2x2ZWQuIA0KVGhhbmtzLg0KDQoN
CmNvbW1pdCA1ZmQyNmM3ZWNiMzIwODI3NDViMGJkMzNjOGUzNWJhZGQxY2I1YTkxDQpBdXRob3I6
IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KRGF0ZTogICBGcmkgSnVuIDUg
MTE6NDA6MDggMjAxNSArMDIwMA0KDQogICAgbW1jOiBzZGhjaTogUmVzdG9yZSBiZWhhdmlvciB3
aGlsZSBjcmVhdGluZyBPQ1IgbWFzaw0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogV29vZCBTY290dC1CMDc0MjENCj4gU2VudDogVHVlc2RheSwgSnVuZSAwOSwgMjAx
NSA0OjMxIEFNDQo+IFRvOiBMdSBZYW5nYm8tQjQ3MDkzDQo+IENjOiBsaW51eHBwYy1kZXZAbGlz
dHMub3psYWJzLm9yZzsgbGludXgtbW1jQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
cG93ZXJwYy9jb3JlbmV0OiBlbmFibGUgZVNESEMNCj4gDQo+IE9uIE1vbiwgMjAxNS0wNi0wOCBh
dCAwNToxMiAtMDUwMCwgTHUgWWFuZ2JvLUI0NzA5MyB3cm90ZToNCj4gPiBUaGFua3MgYSBsb3Qs
IFNjb3R0Lg0KPiA+IEFuZCBub3cgYSBwYXRjaCB3YXMgbWVyZ2VkIG9uDQo+ID4gZ2l0Oi8vZ2l0
LmxpbmFyby5vcmcvcGVvcGxlL3VsZi5oYW5zc29uL21tYy5naXQgbmV4dCBicmFuY2ggdG8gZml4
DQo+ID4gdGhpcyBpc3N1ZS4NCj4gPiBJdCBzaG91bGQgYmUgbm8gcHJvYmxlbS4NCj4gDQo+IEFz
c3VtaW5nIHRoYXQgcGF0Y2ggZml4ZXMgaXQgYW5kIGdldHMgcHVsbGVkIGZvciA0LjIsIHRoaXMg
Y29uZmlnIHBhdGNoDQo+IGNhbiBnbyBpbiBmb3IgNC4zLg0KPiANCj4gVGhhdCBzYWlkLCBpdCB3
b3VsZCBiZSBuaWNlIGlmLCBhcGFydCBmcm9tIGZpeGluZyB0aGUgcHJvYmxlbSBpdHNlbGYsIHRo
ZQ0KPiBNTUMgY29kZSBmYWlsZWQgbW9yZSBncmFjZWZ1bGx5IGluc3RlYWQgb2YgZW5kbGVzc2x5
IHJlcGVhdGluZyBhbmQNCj4gZmlsbGluZyB1cCB0aGUgbG9nL2NvbnNvbGUuDQo+IA0KPiAtU2Nv
dHQNCg0K
