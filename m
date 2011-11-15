Return-Path: <Clive.Jenkins@xerox.com>
Received: from USA7109MR001.ACS-INC.COM (usa7109mr001.acs-inc.com
 [63.101.151.9])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (Client CN "usa7109mr.acs-inc.com", Issuer "GeoTrust DV SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 84E06B6F77
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2011 01:42:34 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Subject: RE: [PATCH 1/3] mtd/nand: fix coding style issue in
 drivers/mtd/nand/fsl_elbc.c
Date: Tue, 15 Nov 2011 14:42:25 -0000
Message-ID: <929D3CED81F34E43887A393170D66FB9053A8F81@GBRSUN01MS002.eu.xerox.net>
In-Reply-To: <1321362603.1932.67.camel@shinybook.infradead.org>
References: <1321349355-1639-1-git-send-email-b35362@freescale.com>
 <929D3CED81F34E43887A393170D66FB9053A8C82@GBRSUN01MS002.eu.xerox.net>
 <1321362603.1932.67.camel@shinybook.infradead.org>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: Artem.Bityutskiy@nokia.com, b35362@freescale.com,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 scottwood@freescale.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiA+ID4gZml4IHdoaXRlc3BhY2VzLHRhYnMgY29kaW5nIHN0eWxlIGlzc3VlIGFuZCAuLi4NCj4g
PiANCj4gPiBJbiBteSBvcGluaW9uIHRoaXMgY29kZSB3YXMgYWxyZWFkeSBjb3JyZWN0LCBhbmQg
d291bGQgZGlzcGxheSBjb3JyZWN0bHkNCj4gPiBhdCBhbnkgVEFCIHNldHRpbmcuIFRoaXMgcGF0
Y2ggY2hhbmdlcyBpdCBzbyB0aGF0IGl0IGRpc3BsYXlzDQo+ID4gaW5jb3JyZWN0bHkgYXQgYWxs
IFRBQiBzZXR0aW5ncyBvdGhlciB0aGFuIDguDQo+DQo+IEFueSB0YWIgc2V0dGluZyBvdGhlciB0
aGFuIDggaXMgaW5jb3JyZWN0IGFuZCBzaG91bGQgbm90IGJlIHVzZWQgZm9yDQo+IExpbnV4IGNv
ZGUuDQoNClRoaXMgbWF5IGJlIHlvdXIgKG5vdCBzbyBodW1ibGUgOi0pIG9waW5pb24sIGFuZCBJ
IGhhcHBlbiB0byBhZ3JlZSB0aGF0DQphIHRhYiBzZXR0aW5nIG9mIDggaXMgYmVzdCwgdXN1YWxs
eS4gSG93ZXZlciwgYXMgTGludXMgc2F5cyBpbiBoaXMNCmNvZGluZyBzdHlsZSBkb2N1bWVudCAi
Q29kaW5nIHN0eWxlIGlzIHZlcnkgcGVyc29uYWwsIGFuZCBJIHdvbid0IF9mb3JjZV8NCm15IHZp
ZXdzIG9uIGFueWJvZHkiLg0KDQo+IC4uLiBGaXggeW91ciBlZGl0b3IsIGlmIHRoYXQncyBhbiBp
c3N1ZSBmb3IgeW91Lg0KDQpNeSBlZGl0b3IgaGFzIGEgdGFiIHNldHRpbmcgb2YgOCwgYnV0IHJl
YWRlcnMgb2YgdGhpcyBsaXN0IGhhdmUgZGl2ZXJzZQ0KZW1haWwgY2xpZW50cywgc29tZSBvZiB3
aGljaCBkbyBub3QgZGlzcGxheSA4IHNwYWNlcyBwZXIgdGFiLg0KDQpDbGl2ZQ0K
