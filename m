Return-Path: <B29983@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A53D62C0340
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Oct 2013 13:53:34 +1100 (EST)
From: Tang Yuantian-B29983 <B29983@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH v5] powerpc/mpc85xx: Update the clock nodes in device tree
Date: Sat, 12 Oct 2013 02:53:26 +0000
Message-ID: <D07C73A334FF604B95B3CBD2A545D07B150C24D2@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1381300704-4238-1-git-send-email-Yuantian.Tang@freescale.com>
 <1381518492.7979.537.camel@snotra.buserror.net>
In-Reply-To: <1381518492.7979.537.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

VGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBXb29kIFNjb3R0LUIwNzQyMQ0KPiBTZW50OiAyMDEz5bm0MTDmnIgxMuaXpSDmmJ/m
nJ/lha0gMzowOA0KPiBUbzogVGFuZyBZdWFudGlhbi1CMjk5ODMNCj4gQ2M6IGdhbGFrQGtlcm5l
bC5jcmFzaGluZy5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eHBwYy0NCj4g
ZGV2QGxpc3RzLm96bGFicy5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NV0gcG93ZXJwYy9t
cGM4NXh4OiBVcGRhdGUgdGhlIGNsb2NrIG5vZGVzIGluIGRldmljZQ0KPiB0cmVlDQo+IA0KPiBP
biBXZWQsIDIwMTMtMTAtMDkgYXQgMTQ6MzggKzA4MDAsIFl1YW50aWFuLlRhbmdAZnJlZXNjYWxl
LmNvbSB3cm90ZToNCj4gPiBGcm9tOiBUYW5nIFl1YW50aWFuIDx5dWFudGlhbi50YW5nQGZyb3Zp
ZGVyOg0KPiA+ICsvIHsNCj4gPiArCWNsb2NrZ2VuOiBnbG9iYWwtdXRpbGl0aWVzQGUxMDAwIHsN
Cj4gPiArCQljb21wYXRpYmxlID0gImZzbCxwNTAyMC1jbG9ja2dlbiIsICJmc2wscW9yaXEtY2xv
Y2tnZW4tMS4wIjsNCj4gPiArCQlyZWcgPSA8MHhlMTAwMCAweDEwMDA+Ow0KPiA+ICsJCWNsb2Nr
LWZyZXF1ZW5jeSA9IDwwPjsNCj4gPiArCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPiArCQkj
c2l6ZS1jZWxscyA9IDwxPjsNCj4gPiArDQo+ID4gKwkJc3lzY2xrOiBzeXNjbGsgew0KPiA+ICsJ
CQkjY2xvY2stY2VsbHMgPSA8MD47DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAiZnNsLHFvcmlxLXN5
c2Nsay0xLjAiLCAiZml4ZWQtY2xvY2siOw0KPiA+ICsJCQljbG9jay1vdXRwdXQtbmFtZXMgPSAi
c3lzY2xrIjsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCXBsbDA6IHBsbDBAODAwIHsNCj4gPiAr
CQkJI2Nsb2NrLWNlbGxzID0gPDE+Ow0KPiA+ICsJCQlyZWcgPSA8MHg4MDAgMHg0PjsNCj4gPiAr
CQkJY29tcGF0aWJsZSA9ICJmc2wscW9yaXEtY29yZS1wbGwtMS4wIjsNCj4gPiArCQkJY2xvY2tz
ID0gPCZzeXNjbGs+Ow0KPiA+ICsJCQljbG9jay1vdXRwdXQtbmFtZXMgPSAicGxsMCIsICJwbGww
LWRpdjIiOw0KPiA+ICsJCX07DQo+IA0KPiBXaGVyZSBpcyAicmFuZ2VzIiBpbiB0aGUgZ2xvYmFs
LXV0aWxpdGllcyBub2RlPw0KPiANCldpbGwgYWRkIGl0IHRoYW5rcy4NCg0KUmVnYXJkcywNCll1
YW50aWFuDQoNCj4gLVNjb3R0DQo+IA0KDQo=
