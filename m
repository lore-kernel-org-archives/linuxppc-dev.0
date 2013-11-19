Return-Path: <Varun.Sethi@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2185F2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 13:42:19 +1100 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH] iommu/fsl_pamu: use physical cpu index to find the
 matched cpu nodes
Date: Tue, 19 Nov 2013 02:42:09 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D0A5B966D@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1384457440.2144.15.camel@haiying-laptop>
 <1384467025.1403.210.camel@snotra.buserror.net>
 <C5ECD7A89D1DC44195F34B25E172658D0A5B0AE8@039-SN2MPN1-012.039d.mgd.msft.net>
 <1384803449.1403.313.camel@snotra.buserror.net>
In-Reply-To: <1384803449.1403.313.camel@snotra.buserror.net>
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

Rm9yIHRoZSBEU1AgY2FzZSBhZ2FpbiB3ZSBoYXZlIHRvIHNldCB1cCB0aGUgc3Rhc2ggYXR0cmli
dXRlLiBBcmUgeW91IHNheWluZyB0aGF0IHRoaXMgc2hvdWxkIGJlIGEgc2VwYXJhdGUgYXR0cmli
dXRlPyANCg0KLVZhcnVuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
V29vZCBTY290dC1CMDc0MjENCj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTksIDIwMTMgMTow
NyBBTQ0KPiBUbzogU2V0aGkgVmFydW4tQjE2Mzk1DQo+IENjOiBXYW5nIEhhaXlpbmctUjU0OTY0
OyBqb3JvQDhieXRlcy5vcmc7IGlvbW11QGxpc3RzLmxpbnV4LQ0KPiBmb3VuZGF0aW9uLm9yZzsg
bGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gaW9t
bXUvZnNsX3BhbXU6IHVzZSBwaHlzaWNhbCBjcHUgaW5kZXggdG8gZmluZCB0aGUNCj4gbWF0Y2hl
ZCBjcHUgbm9kZXMNCj4gDQo+IE9uIFRodSwgMjAxMy0xMS0xNCBhdCAyMToxNiAtMDYwMCwgU2V0
aGkgVmFydW4tQjE2Mzk1IHdyb3RlOg0KPiA+IEhhaXlpbmcvU2NvdHQsDQo+ID4gRm9yZ290IHRv
IG1lbnRpb24gdGhpcywgdGhlIFBBTVUgZHJpdmVyIGhhcyB0byBoYW5kbGUgc3Rhc2gNCj4gPiBk
ZXN0aW5hdGlvbiBzZXR0aW5ncyBib3RoIGZvciBwb3dlciBhbmQgZHNwIGNvcmVzIChvbiBCNCBw
bGF0Zm9ybSkuDQo+ID4gRm9yIHRoZSBkc3AgY29yZXMgd2Ugd291bGQgZXhwZWN0IHRoZSBwaHlz
aWNhbCBjb3JlIGlkIChub3QgY29udHJvbGxlZA0KPiBieSBMaW51eCkuDQo+ID4gVG8gbWFrZSB0
aGUgaW50ZXJmYWNlIGNvbnNpc3RlbnQsIEkgd291bGQgZXhwZWN0IHRoZSBjYWxsZXIgKGZvcg0K
PiA+IGlvbW11X3NldF9hdHRyKSB0byBwYXNzIHRoZSBwaHlzaWNhbCBjb3JlIGlkLg0KPiANCj4g
VGhhdCBzb3VuZHMgbGlrZSB5b3UgbmVlZCB0d28gZGlmZmVyZW50IGludGVyZmFjZXMuDQo+IA0K
PiAtU2NvdHQNCj4gDQoNCg==
