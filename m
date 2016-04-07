Return-Path: <zhiqiang.hou@nxp.com>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0072.outbound.protection.outlook.com [157.56.112.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgWx86QSyzDq6L
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 15:53:48 +1000 (AEST)
From: Zhiqiang Hou <zhiqiang.hou@nxp.com>
To: Scott Wood <oss@buserror.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>
CC: Mingkai Hu <mingkai.hu@nxp.com>
Subject: RE: [PATCH] powerpc/config: Disable the 4KiB erase granularity of SPI
 flash
Date: Thu, 7 Apr 2016 03:17:29 +0000
Message-ID: <AM4PR04MB21485158542FA13151D6B23484900@AM4PR04MB2148.eurprd04.prod.outlook.com>
References: <1459937676-25668-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <1459980089.32510.78.camel@buserror.net>
In-Reply-To: <1459980089.32510.78.camel@buserror.net>
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

SGkgU2NvdHQsDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4NCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTY290dCBXb29kIFttYWlsdG86b3NzQGJ1c2Vycm9yLm5l
dF0NCj4gU2VudDogMjAxNuW5tDTmnIg35pelIDY6MDENCj4gVG86IFpoaXFpYW5nIEhvdSA8emhp
cWlhbmcuaG91QG54cC5jb20+OyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsNCj4gYmVu
aEBrZXJuZWwuY3Jhc2hpbmcub3JnOyBwYXVsdXNAc2FtYmEub3JnOyBtcGVAZWxsZXJtYW4uaWQu
YXUNCj4gQ2M6IE1pbmdrYWkgSHUgPG1pbmdrYWkuaHVAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSF0gcG93ZXJwYy9jb25maWc6IERpc2FibGUgdGhlIDRLaUIgZXJhc2UgZ3JhbnVsYXJp
dHkgb2YgU1BJDQo+IGZsYXNoDQo+IA0KPiBPbiBXZWQsIDIwMTYtMDQtMDYgYXQgMTg6MTQgKzA4
MDAsIFpoaXFpYW5nIEhvdSB3cm90ZToNCj4gPiBGcm9tOiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5n
LkhvdUBueHAuY29tPg0KPiA+DQo+ID4gRGlzYWJsZSB0aGUgc3Vic2VjdG9yICg0S2lCKSBlcmFz
ZSBncmFudWxhcml0eSB0byBzcGVlZCB1cCB0aGUgZXJhc2UNCj4gPiBvcGVyYXRpb24uDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0K
PiA+IC0tLQ0KPiA+ICBhcmNoL3Bvd2VycGMvY29uZmlncy84NXh4LWh3LmNvbmZpZyB8IDEgKw0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9hcmNoL3Bvd2VycGMvY29uZmlncy84NXh4LWh3LmNvbmZpZw0KPiA+IGIvYXJjaC9wb3dlcnBj
L2NvbmZpZ3MvODV4eCAtaHcuY29uZmlnIGluZGV4IDUyOGZmMGUuLmEwZjRlNzAgMTAwNjQ0DQo+
ID4gLS0tIGEvYXJjaC9wb3dlcnBjL2NvbmZpZ3MvODV4eC1ody5jb25maWcNCj4gPiArKysgYi9h
cmNoL3Bvd2VycGMvY29uZmlncy84NXh4LWh3LmNvbmZpZw0KPiA+IEBAIC03Nyw2ICs3Nyw3IEBA
IENPTkZJR19NVERfUEhZU01BUF9PRj15DQo+IENPTkZJR19NVERfUEhZU01BUD15DQo+ID4gQ09O
RklHX01URF9QTEFUUkFNPXkgIENPTkZJR19NVERfU1BJX05PUj15DQo+ID4gKyMgQ09ORklHX01U
RF9TUElfTk9SX1VTRV80S19TRUNUT1JTIGlzIG5vdCBzZXQNCj4gPiAgQ09ORklHX05FVERFVklD
RVM9eQ0KPiA+ICBDT05GSUdfTlZSQU09eQ0KPiA+ICBDT05GSUdfUEFUQV9BTEk9eQ0KPiANCj4g
SXMgdGhlcmUgYSByZWFzb24gc3BlY2lmaWMgdG8gODV4eCB0byBoYXZlIGEgZGlmZmVyZW50IGRl
ZmF1bHQgdGhhbiBldmVyeSBvdGhlcg0KPiBwbGF0Zm9ybSBleGNlcHQgbHBjMTh4eD8gIFRoZSBk
ZXNjcmlwdGlvbiBvZiBNVERfU1BJX05PUl9VU0VfNEtfU0VDVE9SUw0KPiBhY2tub3dsZWRnZXMg
dGhhdCBlcmFzZSBzcGVlZCBpcyBhIHRyYWRlb2ZmLiAgV2h5IGlzIHRoYXQgY29uY2VybiBtb3Jl
DQo+IGNvbXBlbGxpbmcgb24gODV4eCB0aGFuIGVsc2V3aGVyZT8NCj4gDQoNCkkgZG9uJ3Qgd2Fu
dCB0byBzcGVjaWZ5IDg1eHgsIGJ1dCBjb25maWdzIG9mIGZzbC4gSSdtIHN0aWxsIGNvbmZ1c2lu
ZyAgYWJvdXQgc28gbWFueQ0KY29uZmlncy4gV2lsbCBhZGQgb3RoZXIgcGxhdGZvcm1zIGlmIG5l
Y2Vzc2FyeS4NCg0KRm9yIHRoaXMgcGF0Y2gsIGl0IHRha2VzIGFib3V0IDEzIG1pbnMgdG8gZXJh
c2UgNjRNaUIgYnkgc3Vic2VjdG9yIGVyYXNlIGNvbW1hbmQNCig0S2lCIHBlciB0aW1lKSwgYnV0
IHRha2VzIDIgbWlucyBieSBzZWN0b3IgZXJhc2UgY29tbWFuZCg2NEtpQiBwZXIgdGltZSkuIEl0
IGlzDQpjb25zcGljdW91cyBkZWNyZWFzZS4gV2h5IGl0IHVzZXMgdGhlIDRLaUIgZ3JhbnVsYXJp
dHkgYnkgZGVmYXVsdCwgd2hhdCdzIHRoZQ0KYmVuZWZpdD8NCg0KVGhhbmtzLA0KWmhpcWlhbmcN
Cg0K
