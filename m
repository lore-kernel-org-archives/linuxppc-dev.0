Return-Path: <roy.zang@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5C28D2C00C8
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Nov 2013 10:05:36 +1100 (EST)
Received: from mail87-db8 (localhost [127.0.0.1])	by mail87-db8-R.bigfish.com
 (Postfix) with ESMTP id 1825ED800FB	for <linuxppc-dev@ozlabs.org>;
 Tue, 12 Nov 2013 23:05:32 +0000 (UTC)
Received: from DB8EHSMHS026.bigfish.com (unknown [10.174.8.252])	by
 mail87-db8.bigfish.com (Postfix) with ESMTP id 43F9A200049	for
 <linuxppc-dev@ozlabs.org>; Tue, 12 Nov 2013 23:05:29 +0000 (UTC)
From: Roy Zang <roy.zang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH V2] powerpc/85xx: Merge 85xx/p1023_defconfig into
 mpc85xx_smp_defconfig and mpc85xx_defconfig
Date: Tue, 12 Nov 2013 23:05:27 +0000
Message-ID: <3E027F8168735B46AC006B1D0C7BB0020B37817C@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1383952632-5770-1-git-send-email-Lijun.Pan@freescale.com>
 <1384197913-24610-1-git-send-email-Lijun.Pan@freescale.com>
 <1384293891.1403.70.camel@snotra.buserror.net>
 <3E027F8168735B46AC006B1D0C7BB0020B37812C@039-SN2MPN1-011.039d.mgd.msft.net>
 <1384296734.1403.72.camel@snotra.buserror.net>
In-Reply-To: <1384296734.1403.72.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Lijun Pan <Lijun.Pan@freescale.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTIsIDIwMTMgNDo1MiBQTQ0KPiBUbzogWmFu
ZyBSb3ktUjYxOTExDQo+IENjOiBQYW4gTGlqdW4tQjQ0MzA2OyBsaW51eHBwYy1kZXZAb3psYWJz
Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYyXSBwb3dlcnBjLzg1eHg6IE1lcmdlIDg1eHgv
cDEwMjNfZGVmY29uZmlnIGludG8NCj4gbXBjODV4eF9zbXBfZGVmY29uZmlnIGFuZCBtcGM4NXh4
X2RlZmNvbmZpZw0KPiANCj4gT24gVHVlLCAyMDEzLTExLTEyIGF0IDE2OjQ5IC0wNjAwLCBaYW5n
IFJveS1SNjE5MTEgd3JvdGU6DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4gPiBGcm9tOiBMaW51eHBwYy1kZXYgW21haWx0bzpsaW51eHBwYy1kZXYtYm91bmNlcyt0
aWUtDQo+ID4gPiBmZWkuemFuZz1mcmVlc2NhbGUuY29tQGxpc3RzLm96bGFicy5vcmddIE9uIEJl
aGFsZiBPZiBTY290dCBXb29kDQo+ID4gPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxMiwgMjAx
MyA0OjA1IFBNDQo+ID4gPiBUbzogUGFuIExpanVuLUI0NDMwNg0KPiA+ID4gQ2M6IGxpbnV4cHBj
LWRldkBvemxhYnMub3JnDQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIFYyXSBwb3dlcnBjLzg1
eHg6IE1lcmdlIDg1eHgvcDEwMjNfZGVmY29uZmlnDQo+ID4gPiBpbnRvIG1wYzg1eHhfc21wX2Rl
ZmNvbmZpZyBhbmQgbXBjODV4eF9kZWZjb25maWcNCj4gPiA+DQo+ID4gPiBPbiBNb24sIDIwMTMt
MTEtMTEgYXQgMTM6MjUgLTA2MDAsIExpanVuIFBhbiB3cm90ZToNCj4gPiA+ID4gbXBjODV4eF9z
bXBfZGVmY29uZmlnIGFuZCBtcGM4NXh4X2RlZmNvbmZpZyBhbHJlYWR5IGhhdmUNCj4gPiA+IENP
TkZJR19QMTAyM1JEUz15Lg0KPiA+ID4gPiBNZXJnZSBDT05GSUdfUDEwMjNSREI9eSBhbmQgb3Ro
ZXIgcmVsZXZhbnQgY29uZmlndXJhdGlvbnMgaW50bw0KPiA+ID4gbXBjODV4eF9zbXBfZGVmY29u
ZmlnIGFuZCBtcGM4NV9kZWZjb25maWcuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IExpanVuIFBhbiA8TGlqdW4uUGFuQGZyZWVzY2FsZS5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4g
PiAgYXJjaC9wb3dlcnBjL2NvbmZpZ3MvODV4eC9wMTAyM19kZWZjb25maWcgIHwgIDE4OA0KPiA+
ID4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gLS0tLS0tLS0NCj4gPiA+ID4gIGFyY2gv
cG93ZXJwYy9jb25maWdzL21wYzg1eHhfZGVmY29uZmlnICAgICB8ICAgMTggKysrDQo+ID4gPiA+
ICBhcmNoL3Bvd2VycGMvY29uZmlncy9tcGM4NXh4X3NtcF9kZWZjb25maWcgfCAgIDE3ICsrKw0K
PiA+ID4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCAxODggZGVsZXRpb25z
KC0pICBkZWxldGUgbW9kZQ0KPiA+ID4gPiAxMDA2NDQgYXJjaC9wb3dlcnBjL2NvbmZpZ3MvODV4
eC9wMTAyM19kZWZjb25maWcNCj4gPiA+DQo+ID4gPiBBcmUgd2Ugc3RpbGwgZ29pbmcgdG8gd2Fu
dCB0byBoYXZlIG9uZSBkZWZjb25maWcgaWYgYW5kIHdoZW4gd2UNCj4gPiA+IGZpbmFsbHkgZ2V0
IGRhdGFwYXRoIHN1cHBvcnQgdXBzdHJlYW0/ICBUaGF0J3MgYSBsb3Qgb2YgY29kZSB0byBhZGQN
Cj4gPiA+IHRvIHRoZSA4NXh4IGNvbmZpZyBqdXN0IGZvciB0aGlzIG9uZSBjaGlwLg0KPiA+IFAx
MDIzIGhhcyBkcGFhLg0KPiA+IFdpbGwgbXBjODV4eF9kZWZjb25maWcgb3IgbXBjODV4eF9zbXBf
ZGVmY29uZmlnIHN1cHBvcnQgZHBhYT8NCj4gDQo+IFRoYXQncyB0aGUgcXVlc3Rpb24gSSdtIGFz
a2luZy4gIFRob3VnaCBJIHN1cHBvc2Ugd2UgY291bGQgdGFrZSBhIHBhdGNoDQo+IGxpa2UgdGhp
cyBvbmUgZm9yIG5vdywgYW5kIHRoZW4gaW50cm9kdWNlIG1wYzg1eHhfZHBhYV9kZWZjb25maWcg
d2hlbiBpdA0KPiBiZWNvbWVzIHJlbGV2YW50ICh3aGljaCB3b3VsZCBtYWtlIGNsZWFyIHdoeSB0
aGUgZGVmY29uZmlnIGlzIHNlcGFyYXRlKS4NCj4gcDEwMjMgd291bGQgc3RpbGwgd29yayB3aXRo
IHRoZSBub24tZHBhYSBkZWZjb25maWdzLCBidXQgd2l0aG91dCBkcGFhDQo+IHN1cHBvcnQuDQoN
Ckl0IHdpbGwgYmUgaGFyZCB0byBmaW5kIGEgc2VhdCBmb3IgUDEwMjMgaW4gbXBjODV4eF9kcGFh
X2RlZmNvbmZpZy4NClAxMDIzIGRvZXMgbm90IGhhdmUgY29yZW5ldC4gIEl0IGhhcyBlNTAwdjIg
Y29yZS4gQWxsIHRoZSAgb3RoZXIgRFBBQSBTT0NzIGhhdmUgY29yZW5ldC4NCkkgc3VnZ2VzdCAg
bGVhdmluZyBwMTAyMyBkZWZjb25maWcgc3RhbmRhbG9uZS4NClJveQ0K
