Return-Path: <Shaohui.Xie@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0136.outbound.protection.outlook.com [157.56.111.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 75A111A0D2E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 13:54:04 +1100 (AEDT)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH][v4] power/fsl: add MDIO dt binding for FMan
Date: Fri, 30 Jan 2015 02:38:25 +0000
Message-ID: <DM2PR0301MB0864EF866EFDEB634BED54E5E2310@DM2PR0301MB0864.namprd03.prod.outlook.com>
References: <1422446064-3901-1-git-send-email-shh.xie@gmail.com>
 <1422579249.10544.140.camel@freescale.com>
In-Reply-To: <1422579249.10544.140.camel@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Emilian Medve <Emilian.Medve@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXb29kIFNjb3R0LUIwNzQyMQ0K
PiBTZW50OiBGcmlkYXksIEphbnVhcnkgMzAsIDIwMTUgODo1NCBBTQ0KPiBUbzogc2hoLnhpZUBn
bWFpbC5jb20NCj4gQ2M6IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZzsgTWVkdmUNCj4gRW1pbGlhbi1FTU1FRFZFMTsgWGllIFNoYW9odWkt
QjIxOTg5DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdW3Y0XSBwb3dlci9mc2w6IGFkZCBNRElPIGR0
IGJpbmRpbmcgZm9yIEZNYW4NCj4gDQo+IE9uIFdlZCwgMjAxNS0wMS0yOCBhdCAxOTo1NCArMDgw
MCwgc2hoLnhpZUBnbWFpbC5jb20gd3JvdGU6DQo+ID4gKy0gaW50ZXJydXB0cw0KPiA+ICsJCVVz
YWdlOiByZXF1aXJlZA0KPiA+ICsJCVZhbHVlIHR5cGU6IDxwcm9wLWVuY29kZWQtYXJyYXk+DQo+
ID4gKwkJRGVmaW5pdGlvbjogRXZlbnQgaW50ZXJydXB0IG9mIGV4dGVybmFsIE1ESU8gY29udHJv
bGxlci4NCj4gDQo+IFdoYXQgaWYgdGhpcyBNRElPIGNvbnRyb2xsZXIgaXMgbm90ICJleHRlcm5h
bCI/ICBTaG91bGQgVXNhZ2Ugc2F5DQo+ICJyZXF1aXJlZCBmb3IgZXh0ZXJuYWwgTURJTyI/DQpb
Uy5IXSBJIHRob3VnaHQgdGhlIGRlZmluaXRpb24gY2FuIHRlbGwgdGhlIGludGVycnVwdCBpcyBm
b3IgZXh0ZXJuYWwgTURJTywNCkkgY2FuIGNoYW5nZSB0aGUgVXNhZ2UgdG8gInJlcXVpcmVkIGZv
ciBleHRlcm5hbCBNRElPIiBpbiBuZXh0IHZlcnNpb24uIA0KaG93IGFib3V0IG90aGVyIHBhcnRz
LCBhcmUgdGhleSBPSz8NCg0KVGhhbmtzIQ0KU2hhb2h1aQ0K
