Return-Path: <Lijun.Pan@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0140.outbound.protection.outlook.com [207.46.163.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F3BAA1400BE
 for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2014 05:08:27 +1000 (EST)
From: Lijun Pan <Lijun.Pan@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH v2] powerpc/mpc85xx: Remove P1023 RDS support
Date: Mon, 5 May 2014 19:08:23 +0000
Message-ID: <079301a655c14bb7b0cbcab22038f34d@DM2PR03MB368.namprd03.prod.outlook.com>
References: <1399314195-28616-1-git-send-email-Lijun.Pan@freescale.com>
 <1399316691.15726.93.camel@snotra.buserror.net>
In-Reply-To: <1399316691.15726.93.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Emilian Medve <Emilian.Medve@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogTW9uZGF5LCBNYXkgMDUsIDIwMTQgMjowNSBQTQ0KPiBUbzogUGFuIExpanVu
LUI0NDMwNg0KPiBDYzogbGludXhwcGMtZGV2QG96bGFicy5vcmc7IE1lZHZlIEVtaWxpYW4tRU1N
RURWRTENCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gcG93ZXJwYy9tcGM4NXh4OiBSZW1vdmUg
UDEwMjMgUkRTIHN1cHBvcnQNCj4gDQo+IE9uIE1vbiwgMjAxNC0wNS0wNSBhdCAxMzoyMyAtMDUw
MCwgTGlqdW4gUGFuIHdyb3RlOg0KPiA+IFAxMDIzUkRTIGlzIG5vIGxvbmdlciBzdXBwb3J0ZWQv
bWFudWZhY3R1cmVkIGJ5IEZyZWVzY2FsZSB3aGlsZQ0KPiBQMTAyM1JEQiBpcy4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IExpanVuIFBhbiA8TGlqdW4uUGFuQGZyZWVzY2FsZS5jb20+DQo+ID4g
LS0tDQo+ID4gIGFyY2gvcG93ZXJwYy9ib290L2R0cy9wMTAyM3Jkcy5kdHMgICAgICAgICAgICAg
ICAgIHwgMjE5IC0tLS0tLS0tLS0tLS0NCj4gLS0tLS0tLS0NCj4gPiAgYXJjaC9wb3dlcnBjL2Nv
bmZpZ3MvbXBjODV4eF9kZWZjb25maWcgICAgICAgICAgICAgfCAgIDEgLQ0KPiA+ICBhcmNoL3Bv
d2VycGMvY29uZmlncy9tcGM4NXh4X3NtcF9kZWZjb25maWcgICAgICAgICB8ICAgMSAtDQo+ID4g
IGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvODV4eC9LY29uZmlnICAgICAgICAgICAgICAgIHwgICA2
ICstDQo+ID4gIGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvODV4eC9NYWtlZmlsZSAgICAgICAgICAg
ICAgIHwgICAyICstDQo+ID4gIC4uLi9wbGF0Zm9ybXMvODV4eC97cDEwMjNfcmRzLmMgPT4gcDEw
MjNfcmRiLmN9ICAgIHwgIDM2ICstLS0NCj4gPiAgNiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRp
b25zKCspLCAyNTUgZGVsZXRpb25zKC0pDQo+ID4gIGRlbGV0ZSBtb2RlIDEwMDY0NCBhcmNoL3Bv
d2VycGMvYm9vdC9kdHMvcDEwMjNyZHMuZHRzDQo+ID4gIHJlbmFtZSBhcmNoL3Bvd2VycGMvcGxh
dGZvcm1zLzg1eHgve3AxMDIzX3Jkcy5jID0+IHAxMDIzX3JkYi5jfSAoNzUlKQ0KPiANCj4gV2hh
dCBjaGFuZ2VkIGZyb20gdjE/DQoNCiJQbGVhc2Ugd3JhcCBjaGFuZ2Vsb2dzIGF0IG5vIG1vcmUg
dGhhbiA3NSBjb2x1bW5zLiINCg0KDQo+IElmIHlvdSB3YW50IHRoaXMgcGF0Y2ggbWVyZ2VkLCBw
bGVhc2UgcmVzcG9uZCB0byB0aGUgY29tbWVudHMgb24gdjEuDQo+IA0KPiAtU2NvdHQNCj4gDQoN
Cg==
