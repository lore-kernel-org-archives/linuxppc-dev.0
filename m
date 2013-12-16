Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0236.outbound.protection.outlook.com [207.46.163.236])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C5AD72C009B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2013 17:08:30 +1100 (EST)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: "Bharat.Bhushan@freescale.com" <Bharat.Bhushan@freescale.com>, Scott Wood
 <scottwood@freescale.com>
Subject: RE: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20 state and
 altivec idle
Date: Mon, 16 Dec 2013 05:53:19 +0000
Message-ID: <0ba4966fa6b54478b2885a0b97f4c2bf@BY2PR03MB191.namprd03.prod.outlook.com>
References: <1381828871-17110-1-git-send-email-dongsheng.wang@freescale.com>
 <1381828871-17110-4-git-send-email-dongsheng.wang@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071C08E4@039-SN2MPN1-013.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010B1799@039-SN2MPN1-021.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071C3279@039-SN2MPN1-013.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010B189E@039-SN2MPN1-021.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071C34C1@039-SN2MPN1-013.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010B195F@039-SN2MPN1-021.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071C362B@039-SN2MPN1-013.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010B33C3@039-SN2MPN1-021.039d.mgd.msft.net>
 <1382124094.7979.885.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010BBC86@039-SN2MPN1-021.039d.mgd.msft.net>
 <1383601901.25829.33.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010BC83B@039-SN2MPN1-021.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071E442A@039-SN2MPN1-013.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010BD119@039-SN2MPN1-021.039d.mgd.msft.net>
 <1383787214.23598.96.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010BF40C@039-SN2MPN1-021.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071EEABB@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D071EEABB@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmh1c2hhbiBCaGFyYXQt
UjY1Nzc3DQo+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMTEsIDIwMTMgMTI6MTEgUE0NCj4gVG86
IFdhbmcgRG9uZ3NoZW5nLUI0MDUzNDsgV29vZCBTY290dC1CMDc0MjENCj4gQ2M6IGxpbnV4cHBj
LWRldkBsaXN0cy5vemxhYnMub3JnDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjUgNC80XSBwb3dl
cnBjLzg1eHg6IGFkZCBzeXNmcyBmb3IgcHcyMCBzdGF0ZSBhbmQgYWx0aXZlYw0KPiBpZGxlDQo+
IA0KPiA+ID4gVGhvc2UgY29kZXMganVzdCBmb3IgZGlzY3VzcyB3aXRoIEJoYXJhdC4gSGUgd2Fu
dCB0byBtYWtlIG9uZSBmbG93IGF0DQo+ID4gPiAic2hvd19wdzIwX3dhaXRfdGltZSIvIiBzaG93
X2FsdGl2ZWNfaWRsZV93YWl0X3RpbWUiIGZ1bmN0aW9uLiBJZiB3ZQ0KPiA+ID4gZG8gdGhhdCwg
d2UgbmVlZCB0byBpbml0aWFsaXplIHB3MjBfd3QvYWx0aXZlY19pZGxlX3d0Lg0KPiA+ID4NCj4g
PiBJIHdpbGwga2VlcCB0aGlzIHN0dWZmIGF0ICJzaG93X3B3MjBfd2FpdF90aW1lIi8ic2hvd19h
bHRpdmVjX2lkbGVfd2FpdF90aW1lIg0KPiA+IGFuZCBhZGQgYSBjb21tZW50IGJlZm9yZSBvdXIg
ZGlzY3Vzc2lvbi4NCj4gPg0KPiA+IC8qDQo+ID4gICogSWYgdGhlICJ2YWx1ZSIgbGVzcyB0aGFu
IDEwLCB0aGlzIHdpbGwgb3ZlcmZsb3cuDQo+ID4gICogRnJvbSBiZW5jaG1hcmsgdGVzdCwgdGhl
IGRlZmF1bHQgd2FpdCBiaXQgd2lsbCBub3QgYmUgc2V0IGxlc3MgdGhhbiAxMGJpdC4NCj4gPiAg
KiBCZWNhdXNlIDEwIGJpdCBjb3JyZXNwb25kcyB0byB0aGUgd2FpdCBlbnRyeSB0aW1lIGlzIDQz
OTM3NTU3MzQwMTk5OTYwOShucyksDQo+ID4gICogZm9yIHdhaXQtZW50cnktaWRsZSB0aW1lIHRo
aXMgdmFsdWUgbG9va3MgdG9vIGxvbmcsIGFuZCB3ZSBjYW5ub3QgdXNlIHRob3NlDQo+ID4gICog
ImxvbmciIHRpbWUgYXMgYSBkZWZhdWx0IHdhaXQtZW50cnkgdGltZS4gU28gb3ZlcmZsb3cgY291
bGQgbm90IGhhdmUNCj4gaGFwcGVuZWQNCj4gPiAgKiBhbmQgd2UgdXNlIHRoaXMgY2FsY3VsYXRp
b24gbWV0aG9kIHRvIGdldCB3YWl0LWVudHJ5LWlkbGUgdGltZS4NCj4gPiAgKi8NCj4gDQo+IEkg
dGhpbmsgbm93IHdlIHdpbGwgdXNlIHNhbWUgY2FsY3VsYXRpb24gY29kZSBmb3IgZGVmYXVsdCB2
YWx1ZSBhbmQgdXNlciBzZXQNCj4gdmFsdWUsIHNvIGFkZGluZyB0aGUgY29tbWVudCBpcyBub3Qg
c3VmZmljaWVudCwgd2Ugc2hvdWxkIGVycm9yIG91dCBmcm9tIHRoZQ0KPiBjb2RlIGlmIHZhbHVl
IGlzIGxlc3MgdGhhbiAxMC4gQXMgZGVmYXVsdCB2YWx1ZSBpcyBub3QgbGVzcyB0aGFuIDEwIHNv
IHRoaXMgd2lsbA0KPiBhbHdheXMgd29yayB3aXRoIGRlZmF1bHQgdmFsdWUgYnV0IGlmIHVzZXIg
dHJpZXMgdG8gc2V0IGxlc3MgdGhhbiAxMCB0aGVuIGVycm9yDQo+IG91dCBhbmQgYXNrIHVzZXIg
dG8gdHJ5IG1vcmUgdGhhbiA5Lg0KPiANCkFnYWluLCBvbmNlIHRoZSB1c2VyIGhhcyBzZXQgdXAg
YSB0aW1lLCB0aGUgY29kZSB3aWxsIGdvIHRvIGFub3RoZXIgYnJhbmNoLg0KDQplbHNlIHsNCgl0
aW1lID0gcHcyMF93dDsNCn0NCg0KV2UgZG8gc28gbXVjaCBmb3IgdGhpcyBhIGxpdHRsZSBmdW5j
dGlvbiBwcm9jZXNzaW5nIGlzIG5vdCB3b3J0aCBpdC4gSWYgd2UgY2FuJ3QNCmFncmVlIG9uIHRo
aXMgc3lzIGludGVyZmFjZS4gSSB3aWxsIGNoYW5nZSB0aGlzIHN5cyBpbnRlcmZhY2UgdG8gc2hv
d19wdzIwX3dhaXRfYml0LiA6KQ0KDQpjb2RlIGUuZzoNCnN0YXRpYyBzc2l6ZV90IHNob3dfcHcy
MF93YWl0X2JpdChzdHJ1Y3QgZGV2aWNlICpkZXYsDQogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpDQp7DQogICAg
ICAgIHUzMiBlbnRyeV9iaXQ7DQogICAgICAgIHVuc2lnbmVkIGludCBjcHUgPSBkZXYtPmlkOw0K
DQogICAgICAgIHNtcF9jYWxsX2Z1bmN0aW9uX3NpbmdsZShjcHUsIGRvX3Nob3dfcHdybWd0Y3Iw
LCAmZW50cnlfYml0LCAxKTsNCiAgICAgICAgZW50cnlfYml0ID0gKGVudHJ5X2JpdCAmIFBXUk1H
VENSMF9QVzIwX0VOVCkgPj4NCiAgICAgICAgICAgICAgICBQV1JNR1RDUjBfUFcyMF9FTlRfU0hJ
RlQ7DQoNCiAgICAgICAgcmV0dXJuIHNwcmludGYoYnVmLCAiJXVcbiIsIGVudHJ5X2JpdCk7DQp9
DQoNCi1kb25nc2hlbmcNCg0KPiAtQmhhcmF0DQo=
