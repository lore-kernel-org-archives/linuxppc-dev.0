Return-Path: <Varun.Sethi@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4CFF42C007E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 14:09:31 +1100 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH] iommu/fsl_pamu: use physical cpu index to find the
 matched cpu nodes
Date: Tue, 19 Nov 2013 03:09:08 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D0A5B971D@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1384457440.2144.15.camel@haiying-laptop>
 <1384467025.1403.210.camel@snotra.buserror.net>
 <C5ECD7A89D1DC44195F34B25E172658D0A5B0AE8@039-SN2MPN1-012.039d.mgd.msft.net>
 <1384803449.1403.313.camel@snotra.buserror.net>
 <C5ECD7A89D1DC44195F34B25E172658D0A5B966D@039-SN2MPN1-012.039d.mgd.msft.net>
 <1384830256.1403.340.camel@snotra.buserror.net>
In-Reply-To: <1384830256.1403.340.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "joro@8bytes.org" <joro@8bytes.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTksIDIwMTMgODozNCBBTQ0KPiBUbzogU2V0
aGkgVmFydW4tQjE2Mzk1DQo+IENjOiBXYW5nIEhhaXlpbmctUjU0OTY0OyBqb3JvQDhieXRlcy5v
cmc7IGlvbW11QGxpc3RzLmxpbnV4LQ0KPiBmb3VuZGF0aW9uLm9yZzsgbGludXhwcGMtZGV2QGxp
c3RzLm96bGFicy5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gaW9tbXUvZnNsX3BhbXU6IHVz
ZSBwaHlzaWNhbCBjcHUgaW5kZXggdG8gZmluZCB0aGUNCj4gbWF0Y2hlZCBjcHUgbm9kZXMNCj4g
DQo+IE9uIE1vbiwgMjAxMy0xMS0xOCBhdCAyMDo0MiAtMDYwMCwgVmFydW4gU2V0aGkgd3JvdGU6
DQo+ID4gRm9yIHRoZSBEU1AgY2FzZSBhZ2FpbiB3ZSBoYXZlIHRvIHNldCB1cCB0aGUgc3Rhc2gg
YXR0cmlidXRlLiBBcmUgeW91DQo+IHNheWluZyB0aGF0IHRoaXMgc2hvdWxkIGJlIGEgc2VwYXJh
dGUgYXR0cmlidXRlPw0KPiANCj4gTm90IG5lY2Vzc2FyaWx5IGEgc2VwYXJhdGUgYXR0cmlidXRl
LCBidXQgdGhlcmUgc2hvdWxkIGJlIHNvbWUgd2F5IHRvDQo+IGRpc3Rpbmd1aXNoIHdoZXRoZXIg
eW91J3JlIHByb3ZpZGluZyBhIExpbnV4IGNwdSBudW1iZXIgb3Igc29tZSBleHRlcm5hbA0KPiBz
dGFzaCBkZXN0aW5hdGlvbi4NClllcywgdGhlIGN1cnJlbnQgaWRlYSBpcyB0byB1c2UgYSBzZXBh
cmF0ZSBMMiBjYWNoZSB0eXBlIGZvciB0aGUgRFNQIGNvcmVzIChQQU1VX0RTUF9MMl9DQUNIRSku
IERTUCBjb3JlcyBjYW4gc3Rhc2ggb25seSB0byB0aGUgTDIgY2FjaGUuDQoNCi1WYXJ1bg0KDQoN
Cg==
