Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0106.outbound.protection.outlook.com [65.55.169.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DDCC21A0631
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2015 17:49:35 +1000 (AEST)
From: Liberman Igal <Igal.Liberman@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Madalin-Cristian Bucur <madalin.bucur@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] powerpc/mpc85xx: Add FSL QorIQ DPAA FMan support
 to the SoC device tree(s)
Date: Mon, 3 Aug 2015 07:49:29 +0000
Message-ID: <DM2PR03MB509D0BD6BD59FE38B692545E6770@DM2PR03MB509.namprd03.prod.outlook.com>
References: <1438230794-10983-1-git-send-email-igal.liberman@freescale.com>
 <1438287143.2993.367.camel@freescale.com>
In-Reply-To: <1438287143.2993.367.camel@freescale.com>
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

DQoNClJlZ2FyZHMsDQpJZ2FsIExpYmVybWFuLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IFdvb2QgU2NvdHQtQjA3NDIxDQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDMw
LCAyMDE1IDExOjEyIFBNDQo+IFRvOiBMaWJlcm1hbiBJZ2FsLUIzMTk1MA0KPiBDYzogZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBCdWN1
cg0KPiBNYWRhbGluLUNyaXN0aWFuLUIzMjcxNjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvMl0gcG93ZXJwYy9tcGM4NXh4OiBBZGQgRlNM
IFFvcklRIERQQUEgRk1hbg0KPiBzdXBwb3J0IHRvIHRoZSBTb0MgZGV2aWNlIHRyZWUocykNCj4g
DQo+IE9uIFRodSwgMjAxNS0wNy0zMCBhdCAwNzozMyArMDMwMCwgSWdhbC5MaWJlcm1hbiB3cm90
ZToNCj4gPiBAQCAtMzA3LDQgKzMwNywxMTcgQEANCj4gPiAgICAgICAgICAgICAgIHJlZyA9IDww
eGUwMDAwIDB4MTAwMD47DQo+ID4gICAgICAgICAgICAgICBmc2wsaGFzLXJzdGNyOw0KPiA+ICAg
ICAgIH07DQo+ID4gKw0KPiA+ICsgICAgICBmbWFuQDEwMDAwMHsNCj4gPiArICAgICAgICAgICAg
ICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8
MT47DQo+ID4gKyAgICAgICAgICAgICBjZWxsLWluZGV4ID0gPDA+Ow0KPiA+ICsgICAgICAgICAg
ICAgcmFuZ2VzID0gPDAgMHgxMDAwMDAgMHgxMDAwMDA+Ow0KPiA+ICsgICAgICAgICAgICAgY29t
cGF0aWJsZSA9ICJmc2wsZm1hbiI7DQo+ID4gKyAgICAgICAgICAgICByZWcgPSA8MHgxMDAwMDAg
MHgxMDAwMDA+Ow0KPiA+ICsgICAgICAgICAgICAgaW50ZXJydXB0cyA9IDwyNCAyIDAgMD4sIDwx
NiAyIDEgMzA+Ow0KPiA+ICsgICAgICAgICAgICAgY2xvY2stZnJlcXVlbmN5ID0gPDA+Ow0KPiA+
ICsgICAgICAgICAgICAgZnNsLHFtYW4tY2hhbm5lbC1yYW5nZSA9IDwweDQwIDB4Nz47DQo+IA0K
PiBmbWFuIGlzIHN1cHBvc2VkIHRvIGhhdmUgY2xvY2tzL2Nsb2NrLW5hbWVzLCBub3QgY2xvY2st
ZnJlcXVlbmN5Lg0KPiANCg0KVGhlIG5ldyBjbG9jayBiaW5kaW5nIGRvZXNuJ3Qgc3VwcG9ydCBQ
MTAyMyB5ZXQuIA0KSSdsbCBkcm9wIFAxMDIzIGZyb20gdGhpcyBzdWJtaXNzaW9uLCBpdCdzIG5v
dCBzdXBwb3J0ZWQgY3VycmVudGx5IGJ5IHRoZSBkcml2ZXIsIHdlJ2xsIHJlLWFkZCBpdCBsYXRl
ci4gDQoNCj4gLVNjb3R0DQoNCg==
