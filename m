Return-Path: <B21284@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A318C2C0096
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Sep 2013 21:06:40 +1000 (EST)
Received: from mail102-ch1 (localhost [127.0.0.1])	by
 mail102-ch1-R.bigfish.com (Postfix) with ESMTP id 0497B1000A6	for
 <linuxppc-dev@ozlabs.org>; Tue, 17 Sep 2013 11:06:36 +0000 (UTC)
Received: from CH1EHSMHS043.bigfish.com (snatpool3.int.messaging.microsoft.com
 [10.43.68.226])	by mail102-ch1.bigfish.com (Postfix) with ESMTP id
 3F8CA36024C	for <linuxppc-dev@ozlabs.org>; Tue, 17 Sep 2013 11:06:34 +0000
 (UTC)
From: Hu Mingkai-B21284 <B21284@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH] powerpc/85xx: DTS - re-organize the SPI partitions
 property
Date: Tue, 17 Sep 2013 11:06:33 +0000
Message-ID: <CF6CBFBA8EBBB949B6E321556F6E15090A14E997@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1378454743-17637-1-git-send-email-Mingkai.Hu@freescale.com>
 <1378856005.12204.372.camel@snotra.buserror.net>
 <CF6CBFBA8EBBB949B6E321556F6E15090A135F45@039-SN2MPN1-011.039d.mgd.msft.net>
 <1378948542.12204.490.camel@snotra.buserror.net>
In-Reply-To: <1378948542.12204.490.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

U2NvdHQsDQpTb3JyeSBmb3IgdGhlIGRlbGF5ZWQgcmVzcG9uc2UuDQpQbGVhc2UgZmluZSBteSBj
b21tZW50cy4NClRoYW5rcywNCk1pbmdrYWkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiBXb29kIFNjb3R0LUIwNzQyMQ0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVy
IDEyLCAyMDEzIDk6MTYgQU0NCj4gVG86IEh1IE1pbmdrYWktQjIxMjg0DQo+IENjOiBXb29kIFNj
b3R0LUIwNzQyMTsgbGludXhwcGMtZGV2QG96bGFicy5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SF0gcG93ZXJwYy84NXh4OiBEVFMgLSByZS1vcmdhbml6ZSB0aGUgU1BJIHBhcnRpdGlvbnMNCj4g
cHJvcGVydHkNCj4gDQo+IE9uIFR1ZSwgMjAxMy0wOS0xMCBhdCAyMTowNyAtMDUwMCwgSHUgTWlu
Z2thaS1CMjEyODQgd3JvdGU6DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4gPiBGcm9tOiBXb29kIFNjb3R0LUIwNzQyMQ0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCBT
ZXB0ZW1iZXIgMTEsIDIwMTMgNzozMyBBTQ0KPiA+ID4gVG86IEh1IE1pbmdrYWktQjIxMjg0DQo+
ID4gPiBDYzogbGludXhwcGMtZGV2QG96bGFicy5vcmcNCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFU
Q0hdIHBvd2VycGMvODV4eDogRFRTIC0gcmUtb3JnYW5pemUgdGhlIFNQSQ0KPiA+ID4gcGFydGl0
aW9ucyBwcm9wZXJ0eQ0KPiA+ID4NCj4gPiA+IFdoYXQgaGFwcGVucyB0byBleHN0aW5nIHVzZXJz
IHdob3NlIGZsYXNoIGlzIGxhaWQgb3V0IHRoZSBleGlzdGluZw0KPiA+ID4gd2F5LCB3aGVuIHRo
ZXkgdXBncmFkZSB0byB0aGVzZSBkZXZpY2UgdHJlZXM/DQo+ID4gPg0KPiA+DQo+ID4gVGhlIFNQ
SSBmbGFzaCBsYXlvdXQgc2hvdWxkIGJlIG1hcHBpbmcgdGhlIG5ldyBkZXZpY2UgdHJlZS4NCj4g
Pg0KPiA+IElmIHRoZSBleGlzdGluZyBkZXZpY2UgdHJlZSBpcyB1c2VkIHRvIGRlcGxveSB0aGUg
U1BJIGZsYXNoLCB0aGUNCj4gPiBmb2xsb3dpbmcgaXNzdWVzIG11c3QgYmUgcnVuIGludG8gYXMg
dGhlIGNvbW1pdCBtZXNzYWdlIGRlc2NyaWJlZDoNCj4gPg0KPiA+IDEuIEtlcm5lbCBpbWFnZXMg
d291bGQgYmUgb3ZlcmxhcHBlZCB3aXRoIFUtQm9vdCBpbWFnZS4NCj4gPiAyLiBLZXJuZWwgaW1h
Z2VzIHdvdWxkIGJlIG92ZXJsYXBwZWQgd2l0aCBGTUFOIHVjb2RlLg0KPiA+IDMuIFNhdmluZyBl
bnZpcm9ubWVudCB2YXJpYWJsZXMgd2lsbCBjcmFzaCB0aGUga2VybmVsIGltYWdlLg0KPiANCj4g
SGFzIHRoZSBTUEkgVS1Cb290IGltYWdlIGFsd2F5cyBiZWVuIGxhcmdlciB0aGFuIDUxMksgZm9y
IGFsbCB0aGVzZQ0KPiBwbGF0Zm9ybXM/ICBXaHksIGdpdmVuIHRoYXQgd2UncmUgdW5kZXIgNTEy
SyBmb3Igb3RoZXIgYm9vdCBtb2Rlcz8NCj4gDQoNCkZvciBEUEFBIHBsYXRmb3JtLCB0aGUgbGQg
c2NyaXB0IHVzZWQgdG8gbGluayB0aGUgdS1ib290IGltYWdlIGlzIA0KIi4vYXJjaC9wb3dlcnBj
L2NwdS9tcGM4NXh4L3UtYm9vdC5sZHMiIHdoaWNoIHdpbGwgZ2VuZXJhdGUgdGhlIDUxMksgdS1i
b290DQpJbWFnZS4gVGhpcyBpbWFnZSB3aWxsIGJlIHNwbGl0IGludG8gNjRieXRlcyBhbmQgYXBw
ZW5kZWQgUEJMIGNvbW1hbmQgZm9yIA0KRWFjaCA2NGJ5dGVzIHBpZWNlcywgc28gdGhlIHNpemUg
b2YgZmluYWwgaW1hZ2UgbXVzdCBiZSBncmVhdGVyIHRoYW4gNTEySy4NCg0KVGhlIHNhbWUgYXBw
bGllcyB0byB0aGUgbm9uLURQQUEgcGxhdGZvcm0gd2hpY2ggZG9lc24ndCBzdXBwb3J0IFRQTC4N
Cg0KRm9yIG5vbi1EUEFBIHBsYXRmb3JtIHdoaWNoIHN1cHBvcnQgVFBMLCB0aGUgaW1hZ2Ugc2l6
ZSBpcyBhbHNvIGdyZWF0ZXIgdGhhbiA1MTJLLg0KDQo+ID4gPiBXZSByZWFsbHkgc2hvdWxkIG5v
dCBiZSBwdXR0aW5nIHBhcnRpdGlvbiBsYXlvdXQgaW5mbyBpbiB0aGUgZGV2aWNlDQo+ID4gPiB0
cmVlIHRvIGJlZ2luIHdpdGguLi4NCj4gPiA+DQo+ID4gT0ssIEkgd2lsbCByZW1vdmUgdGhlIGxh
eW91dCBkaWFncmFtIGluIHRoZSBjb21taXQgbWVzc2FnZS4NCj4gDQo+IFRoYXQncyBub3Qgd2hh
dCBJIG1lYW50LiAgSSBtZWFudCB0aGF0IHRoZSBkdHMgc2hvdWxkIGJlIGRlc2NyaWJpbmcNCj4g
aGFyZHdhcmUsIGFuZCB0aGlzIGlzIHRoZSBzb3J0IG9mIHRyb3VibGUgd2UgcnVuIGludG8gd2hl
biB3ZSBkZXZpYXRlDQo+IGZyb20gdGhhdC4gIEEgYmV0dGVyIHdheSB3b3VsZCBiZSB0byB1c2Ug
dGhlIG10ZHBhcnRzIGNvbW1hbmQgbGluZSBvcHRpb24uDQo+IEV2ZW4gYmV0dGVyIHdvdWxkIGJl
IHNvbWUgc29ydCBvZiBvbi1mbGFzaCBwYXJ0aXRpb24gdGFibGUuDQo+IA0KDQpZb3UncmUgcmln
aHQsIGJ1dCBtYXliZSBzb21lIGN1c3RvbWVyIGhhcyBhbHJlYWR5IHVzZWQgdGhlIGRldmljZSB0
cmVlIHBhcnRpdGlvbiB0YWJsZS4uLg0KDQpUaGFua3MsDQpNaW5na2FpDQoNCg==
