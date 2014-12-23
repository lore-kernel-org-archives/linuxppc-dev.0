Return-Path: <Shaohui.Xie@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0137.outbound.protection.outlook.com [65.55.169.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CCB671A050B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 19:17:20 +1100 (AEDT)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH] [v2] power/fsl: add MDIO dt binding for FMan
Date: Tue, 23 Dec 2014 08:17:06 +0000
Message-ID: <DM2PR0301MB0864B0B8C1648A0ED8B0EB9AE2570@DM2PR0301MB0864.namprd03.prod.outlook.com>
References: <1415958800-9867-1-git-send-email-shh.xie@gmail.com>
 <1416966592.15957.172.camel@freescale.com>
 <DM2PR0301MB08641FB289DBA17AD59FBEA0E26A0@DM2PR0301MB0864.namprd03.prod.outlook.com>
 <1418940078.5581.143.camel@freescale.com>
 <DM2PR0301MB0864AA31CD1A7438F476020FE26B0@DM2PR0301MB0864.namprd03.prod.outlook.com>
 <1419030955.5581.154.camel@freescale.com>
 <DM2PR0301MB086427C10254A0A749CD1326E2560@DM2PR0301MB0864.namprd03.prod.outlook.com>
 <5497D466.9090804@Freescale.com> <1419237176.5581.159.camel@freescale.com>
 <5497E645.7010500@Freescale.com> <1419241330.5581.162.camel@freescale.com>
 <5497FBAB.4010206@Freescale.com> <1419283551.5581.172.camel@freescale.com>
 <DM2PR0301MB08642FFDB6207DE205731547E2570@DM2PR0301MB0864.namprd03.prod.outlook.com>
 <1419322085.5581.182.camel@freescale.com>
In-Reply-To: <1419322085.5581.182.camel@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Emilian Medve <Emilian.Medve@freescale.com>,
 "Igal.Liberman@freescale.com" <Igal.Liberman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXb29kIFNjb3R0LUIwNzQyMQ0K
PiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAyMywgMjAxNCA0OjA4IFBNDQo+IFRvOiBYaWUgU2hh
b2h1aS1CMjE5ODkNCj4gQ2M6IE1lZHZlIEVtaWxpYW4tRU1NRURWRTE7IGxpbnV4cHBjLWRldkBs
aXN0cy5vemxhYnMub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgTGliZXJtYW4g
SWdhbC1CMzE5NTANCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gW3YyXSBwb3dlci9mc2w6IGFkZCBN
RElPIGR0IGJpbmRpbmcgZm9yIEZNYW4NCj4gDQo+IE9uIFR1ZSwgMjAxNC0xMi0yMyBhdCAwMToz
NSAtMDYwMCwgWGllIFNoYW9odWktQjIxOTg5IHdyb3RlOg0KPiA+ICstIGJ1cy1mcmVxdWVuY3kN
Cj4gPiArCQlVc2FnZTogb3B0aW9uYWwNCj4gPiArCQlWYWx1ZSB0eXBlOiA8dTMyPg0KPiA+ICsJ
CURlZmluaXRpb246IFNwZWNpZmllcyBleHRlcm5hbCBNRElPIGJ1cyBjbG9jayBzcGVlZCB3aGlj
aCBpcw0KPiA+ICsJCWRpZmZlcmVudCBmcm9tIE1ESU8gc3RhbmRhcmQgMi41TUh6LiBTaG91bGQg
YmUgZGVmaW5lZCBmb3INCj4gU29Dcw0KPiA+ICsJCW9uIHdoaWNoIHRoZSBzdGFuZGFyZCBvbmUg
Y2Fubm90IHdvcmsuDQo+ID4NCj4gPiBXaGF0IHNob3VsZCBJIHJlcGhyYXNlIGl0PyBSZXBsYWNl
IHRoZSBsYXN0IHNlbnRlbmNlIHdpdGggIlNob3VsZCBiZQ0KPiA+IGRlZmluZWQgRm9yIFNvQ3Mg
b24gd2hpY2ggYSBsb3dlciBmcmVxdWVuY3kgdGhhbiB0aGUgc3RhbmRhcmQgaXMNCj4gcmVxdWly
ZWQuIj8NCj4gDQo+IE5laXRoZXIgb2YgdGhlc2Ugd29yayB3aXRoIEVtaWwncyBzY2VuYXJpbyBv
ZiBhIHN5c3RlbSB0aGF0IGFsbG93cyBhDQo+IGZhc3Rlci10aGFuLXN0YW5kYXJkIHNwZWVkLg0K
PiANCj4gSG93IGFib3V0OiAiRGVmaW5pdGlvbjogU3BlY2lmaWVzIHRoZSBleHRlcm5hbCBNRElP
IGJ1cyBjbG9jayBzcGVlZCB0byBiZQ0KPiB1c2VkLCBpZiBkaWZmZXJlbnQgZnJvbSB0aGUgc3Rh
bmRhcmQgMi41IE1Iei4gIFRoaXMgbWF5IGJlIGR1ZSB0byB0aGUNCj4gc3RhbmRhcmQgc3BlZWQg
YmVpbmcgdW5zdXBwb3J0ZWQgKGUuZy4gZHVlIHRvIGEgaGFyZHdhcmUgcHJvYmxlbSksIG9yIHRv
DQo+IGFkdmVydGlzZSB0aGF0IGFsbCByZWxldmFudCBjb21wb25lbnRzIGluIHRoZSBzeXN0ZW0g
c3VwcG9ydCBhIGZhc3Rlcg0KPiBzcGVlZC4iDQpbUy5IXSBPSy4gSSdsbCB1c2UgdGhpcyBpbiBW
My4NCg0KPiANCj4gPiBIb3cgYWJvdXQgdGhlIHZhbHVlIHVzZWQgaW4gZXhhbXBsZT8NCj4gPiBT
aG91bGQgMi41TUh6IGJlIHVzZWQgb3IgYSBsb3dlciBvbmU/DQo+IA0KPiBJZiB5b3UgZG9uJ3Qg
aGF2ZSBhIHJlYWxpc3RpYyBleGFtcGxlIHRvIHVzZSwgZG9uJ3QgcHV0IGl0IGluIHRoZSBleGFt
cGxlDQo+IGF0IGFsbC4gIDIuNU1IeiBpcyB0aGUgd29yc3QgZXhhbXBsZSB0byB1c2UgYmVjYXVz
ZSB0aGF0J3MgdGhlIGRlZmF1bHQNCj4gYW5kIHRoZXJlJ2QgYmUgbm8gcmVhc29uIHRvIHVzZSB0
aGUgcHJvcGVydHkgYXQgYWxsLg0KW1MuSF0gT0suIFRoZSBWMyB3aWxsIG5vdCBoYXZlIHRoaXMg
aW4gZXhhbXBsZS4NCg0KVGhhbmsgeW91IGFsbCBmb3IgcmV2aWV3aW5nIQ0KU2hhb2h1aQ0K
