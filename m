Return-Path: <B48286@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0138.outbound.protection.outlook.com [207.46.100.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E5C211A074F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 14:08:14 +1100 (AEDT)
From: Hou Zhiqiang <B48286@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com"
 <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "Harninder
 Rai" <harninder.rai@freescale.com>, Lian M.H. <Minghuan.Lian@freescale.com>,
 Hu Vincent <Mingkai.Hu@freescale.com>
Subject: RE: [PATCH 1/2] powerpc/fsl: Add PCI node in device tree of bsc9132qds
Date: Thu, 15 Oct 2015 02:52:58 +0000
Message-ID: <CY1PR0301MB0780107C450233E7A0EA24628B3E0@CY1PR0301MB0780.namprd03.prod.outlook.com>
References: <1444735761-1510-1-git-send-email-B48286@freescale.com>
 <1444854968.5185.205.camel@freescale.com>
In-Reply-To: <1444854968.5185.205.camel@freescale.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogMjAxNeW5tDEw5pyIMTXml6UgNDozNg0KPiBUbzogSG91IFpoaXFpYW5nLUI0
ODI4Ng0KPiBDYzogbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IGdhbGFrQGtlcm5lbC5j
cmFzaGluZy5vcmc7DQo+IGJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZzsgcGF1bHVzQHNhbWJhLm9y
ZzsgbXBlQGVsbGVybWFuLmlkLmF1Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgcm9i
aCtkdEBrZXJuZWwub3JnOyBwYXdlbC5tb2xsQGFybS5jb207DQo+IG1hcmsucnV0bGFuZEBhcm0u
Y29tOyBpamMrZGV2aWNldHJlZUBoZWxsaW9uLm9yZy51azsgUmFpIEhhcm5pbmRlci1CMDEwNDQ7
DQo+IExpYW4gTWluZ2h1YW4tQjMxOTM5OyBIdSBNaW5na2FpLUIyMTI4NA0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIDEvMl0gcG93ZXJwYy9mc2w6IEFkZCBQQ0kgbm9kZSBpbiBkZXZpY2UgdHJlZSBv
Zg0KPiBic2M5MTMycWRzDQo+IA0KPiBPbiBUdWUsIDIwMTUtMTAtMTMgYXQgMTk6MjkgKzA4MDAs
IFpoaXFpYW5nIEhvdSB3cm90ZToNCj4gPiBGcm9tOiBIYXJuaW5kZXIgUmFpIDxoYXJuaW5kZXIu
cmFpQGZyZWVzY2FsZS5jb20+DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIYXJuaW5kZXIgUmFp
IDxoYXJuaW5kZXIucmFpQGZyZWVzY2FsZS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWluZ2h1
YW4gTGlhbiA8TWluZ2h1YW4uTGlhbkBmcmVlc2NhbGUuY29tPg0KPiA+IENoYW5nZS1JZDogSTQz
NTVhZGQ0YTkyZDFmY2Y1MTQ4NDNhZWE1ZWNhZGQyZTI1MTc5NjkNCj4gPiBSZXZpZXdlZC1vbjog
aHR0cDovL2dpdC5hbS5mcmVlc2NhbGUubmV0OjgxODEvMjQ1NA0KPiA+IFJldmlld2VkLWJ5OiBa
YW5nIFRpZWZlaS1SNjE5MTEgPHRpZS1mZWkuemFuZ0BmcmVlc2NhbGUuY29tPg0KPiA+IFJldmll
d2VkLWJ5OiBLdXNod2FoYSBQcmFiaGFrYXItQjMyNTc5IDxwcmFiaGFrYXJAZnJlZXNjYWxlLmNv
bT4NCj4gPiBSZXZpZXdlZC1ieTogRmxlbWluZyBBbmRyZXctQUZMRU1JTkcgPEFGTEVNSU5HQGZy
ZWVzY2FsZS5jb20+DQo+ID4gVGVzdGVkLWJ5OiBGbGVtaW5nIEFuZHJldy1BRkxFTUlORyA8QUZM
RU1JTkdAZnJlZXNjYWxlLmNvbT4NCj4gDQo+IEdldCByaWQgb2YgdGhlIGdlcnJpdCBzdHVmZi4g
IEFuZCB3aGVyZSBpcyB5b3VyIHNpZ25vZmY/DQo+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3Bv
d2VycGMvYm9vdC9kdHMvZnNsL2JzYzkxMzJzaS1wb3N0LmR0c2kNCj4gPiBiL2FyY2gvcG93ZXJw
Yy9ib290L2R0cy9mc2wvYnNjOTEzMnNpLXBvc3QuZHRzaQ0KPiA+IGluZGV4IGM3MjMwNzEuLjc4
YzhmMWMgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9wb3dlcnBjL2Jvb3QvZHRzL2ZzbC9ic2M5MTMy
c2ktcG9zdC5kdHNpDQo+ID4gKysrIGIvYXJjaC9wb3dlcnBjL2Jvb3QvZHRzL2ZzbC9ic2M5MTMy
c2ktcG9zdC5kdHNpDQo+ID4gQEAgLTQwLDYgKzQwLDM1IEBADQo+ID4gICAgICAgaW50ZXJydXB0
cyA9IDwxNiAyIDAgMCAyMCAyIDAgMD47ICB9Ow0KPiA+DQo+ID4gKy8qIGNvbnRyb2xsZXIgYXQg
MHhhMDAwICovDQo+ID4gKyZwY2kwIHsNCj4gPiArICAgICBjb21wYXRpYmxlID0gImZzbCxic2M5
MTMyLXBjaWUiLCAiZnNsLHFvcmlxLXBjaWUtdjIuMiI7DQo+ID4gKyAgICAgZGV2aWNlX3R5cGUg
PSAicGNpIjsNCj4gPiArICAgICAjc2l6ZS1jZWxscyA9IDwyPjsNCj4gPiArICAgICAjYWRkcmVz
cy1jZWxscyA9IDwzPjsNCj4gPiArICAgICBidXMtcmFuZ2UgPSA8MCAyNTU+Ow0KPiA+ICsgICAg
IGNsb2NrLWZyZXF1ZW5jeSA9IDwzMzMzMzMzMz47DQo+ID4gKyAgICAgaW50ZXJydXB0cyA9IDwx
NiAyIDAgMD47DQo+IA0KPiBUaGlzIGNsb2NrLWZyZXF1ZW5jeSBpcyBub3QgY29ycmVjdCBmb3Ig
UENJZS4gIEp1c3QgcmVtb3ZlIGl0Lg0KPiANCg0KT2ssIHRoYW5rcyBmb3IgeW91ciBjb3JyZWN0
aW9uLg0KIA0KDQpUaGFua3MsDQpaaGlxaWFuZw0KDQo=
