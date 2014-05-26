Return-Path: <Shengzhou.Liu@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0140.outbound.protection.outlook.com [207.46.163.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 38F741A05A6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 May 2014 13:08:55 +1000 (EST)
From: "Shengzhou.Liu@freescale.com" <Shengzhou.Liu@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [2/2] powerpc/corenet64_smp_defconfig: enable RTC support
Date: Mon, 26 May 2014 03:08:46 +0000
Message-ID: <a1c1a49caf9f4f2b82b517c5c2d598d1@DM2PR03MB398.namprd03.prod.outlook.com>
References: <1400666751-11459-2-git-send-email-Shengzhou.Liu@freescale.com>
 <20140522225144.GA1670@home.buserror.net>
 <474028133ffd49cebfeb951498923caa@DM2PR03MB398.namprd03.prod.outlook.com>
 <1400864771.12823.51.camel@snotra.buserror.net>
In-Reply-To: <1400864771.12823.51.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFdvb2QgU2NvdHQtQjA3NDIx
DQo+IFNlbnQ6IFNhdHVyZGF5LCBNYXkgMjQsIDIwMTQgMTowNiBBTQ0KPiBUbzogTGl1IFNoZW5n
emhvdS1CMzY2ODUNCj4gQ2M6IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbMi8yXSBwb3dlcnBjL2NvcmVuZXQ2NF9zbXBfZGVmY29uZmlnOiBlbmFibGUgUlRD
IHN1cHBvcnQNCj4gDQo+IE9uIEZyaSwgMjAxNC0wNS0yMyBhdCAwMzowMyAtMDUwMCwgTGl1IFNo
ZW5nemhvdS1CMzY2ODUgd3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+ID4gRnJvbTogV29vZCBTY290dC1CMDc0MjENCj4gPiA+IFNlbnQ6IEZyaWRheSwgTWF5IDIz
LCAyMDE0IDY6NTIgQU0NCj4gPiA+IFRvOiBMaXUgU2hlbmd6aG91LUIzNjY4NQ0KPiA+ID4gQ2M6
IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnDQo+ID4gPiBTdWJqZWN0OiBSZTogWzIvMl0g
cG93ZXJwYy9jb3JlbmV0NjRfc21wX2RlZmNvbmZpZzogZW5hYmxlIFJUQw0KPiA+ID4gc3VwcG9y
dA0KPiA+ID4NCj4gPiA+ID4gKysrIGIvYXJjaC9wb3dlcnBjL2NvbmZpZ3MvY29yZW5ldDY0X3Nt
cF9kZWZjb25maWcNCj4gPiA+ID4gQEAgLTEyNSw2ICsxMjUsMTEgQEAgQ09ORklHX1VTQl9FSENJ
X0ZTTD15ICBDT05GSUdfVVNCX1NUT1JBR0U9eQ0KPiA+ID4gPiBDT05GSUdfTU1DPXkgIENPTkZJ
R19NTUNfU0RIQ0k9eQ0KPiA+ID4gPiArQ09ORklHX1JUQ19DTEFTUz15DQo+ID4gPiA+ICtDT05G
SUdfUlRDX0RSVl9DTU9TPXkNCj4gPiA+ID4gK0NPTkZJR19SVENfRFJWX0RTMTMwNz15DQo+ID4g
PiA+ICtDT05GSUdfUlRDX0RSVl9EUzEzNzQ9eQ0KPiA+ID4gPiArQ09ORklHX1JUQ19EUlZfRFMz
MjMyPXkNCj4gPiA+ID4gIENPTkZJR19FREFDPXkNCj4gPiA+ID4gIENPTkZJR19FREFDX01NX0VE
QUM9eQ0KPiA+ID4gPiAgQ09ORklHX0RNQURFVklDRVM9eQ0KPiA+ID4NCj4gPiA+IFdoeSBvbmx5
IGNvcmVuZXQ2NCBhbmQgbm90IGNvcmVuZXQzMj8NCj4gPiA+DQo+ID4gPiAtU2NvdHQNCj4gPiBb
U2hlbmd6aG91XSBUaGVyZSBpcyBhbHJlYWR5IFJUQyBzdXBwb3J0IGluIGNvcmVuZXQzMiwgb25s
eSBtaXNzaW5nIGluDQo+IGNvcmVuZXQ2NC4NCj4gDQo+IE9ubHkgRFMzMjMyLCBub3QgRFMxMzA3
IG9yIERTMTM3NC4gIFdoaWNoIGJvYXJkcyB1c2UgdGhlIGxhdHRlciB0d28/DQo+IA0KPiBXaHkg
ZG8gd2UgbmVlZCBDT05GSUdfUlRDX0RSVl9DTU9TPw0KPiANCj4gLVNjb3R0DQo+IA0KW1NoZW5n
emhvdV0gc28gZmFyIERTMTMwNyBhbmQgRFMxMzc0IG9jY3VyIG9ubHkgb24gdGhvc2UgYm9hcmRz
IHdpdGggY29yZW5ldDY0LiANCkNPTkZJR19SVENfRFJWX0NNT1MgaXMgZW5hYmxlZCBpbiBtcGM4
NXh4X2RlZmNvbmZpZywgbXBjODV4eF9zbXBfZGVmY29uZmlnLCBjb3JlbmV0MzJfc21wX2RlZmNv
bmZpZywgZXRjLCBoZXJlIGtlZXBzIGNvbnNpc3RlbnQgaW4gY29yZW5ldDY0Lg0KSXQgc2VlbXMg
Q09ORklHX1JUQ19EUlZfQ01PUyBpcyBub3QgbmVlZGVkIG9uIDg1eHggcGxhdGZvcm0sIGRvIHdl
IG5lZWQgdG8gcmVtb3ZlIENPTkZJR19SVENfRFJWX0NNT1MgZnJvbSBhbGwgODV4eC9jb3JlbmV0
IGRlZmNvbmZpZz8gSWYgc28sIEkgd2lsbCBwb3N0IGEgbmV3IHBhdGNoIHRvIGRvIGl0Lg0KDQoN
Cg0K
