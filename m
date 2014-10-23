Return-Path: <Geoff.Thorpe@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 331E41A01C9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Oct 2014 01:07:18 +1100 (AEDT)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0104.outbound.protection.outlook.com [207.46.100.104])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3C8BC140095
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2014 01:07:16 +1100 (AEDT)
From: Geoff Thorpe <Geoff.Thorpe@freescale.com>
To: Mark Rutland <mark.rutland@arm.com>, Emilian Medve
 <Emilian.Medve@freescale.com>
Subject: RE: [PATCH 3/4] dt/bindings: Introduce the FSL QorIQ DPAA QMan
Date: Thu, 23 Oct 2014 13:51:14 +0000
Message-ID: <ba62c24cde48435bbcc2d72d76156225@BL2PR03MB483.namprd03.prod.outlook.com>
References: <1413986972-621-1-git-send-email-Emilian.Medve@Freescale.com>
 <1413986972-621-3-git-send-email-Emilian.Medve@Freescale.com>
 <20141022143732.GB4010@leverpostej> <54480DF8.3070604@Freescale.com>
 <20141023112628.GC13690@leverpostej>
In-Reply-To: <20141023112628.GC13690@leverpostej>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Pawel Moll <Pawel.Moll@arm.com>,
 "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "galak@codeaurora.org" <galak@codeaurora.org>,
 Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

VGhvdWdodCBJJ2QgY29tbWVudCB0b28gb24gdGhlIGludGVycnVwdCBxdWVzdGlvbiBmb3IgdGhl
IGJsb2NrLWxldmVsIChub3QgcG9ydGFsLWxldmVsKSBub2RlOw0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmsgUnV0bGFuZCBbbWFpbHRvOm1hcmsucnV0bGFuZEBh
cm0uY29tXQ0KPiBTZW50OiBPY3RvYmVyLTIzLTE0IDc6MjYgQU0NCj4gVG86IE1lZHZlIEVtaWxp
YW4tRU1NRURWRTENCj4gDQo+IFsuLi5dDQo+IA0KPiA+ID4gWW91IGFsc28gc2VlbSB0byBoYXZl
IGFuIGludGVycnVwdCBpbiB0aGUgZXhhbXBsZS4gSG93IG1hbnkgZG8geW91DQo+ID4gPiBleHBl
Y3QsIGFuZCB3aGF0IGFyZSB0aGVpciB0aGVpciBsb2dpY2FsIGZ1bmN0aW9ucz8NCj4gPg0KPiA+
IFRoYXQncyB0aGUgZXJyb3IgaW50ZXJydXB0IGFuZCBob3BlZnVsbHkgaXQgbmV2ZXIgdHJpZ2dl
cnMuIEkgZGlkbid0DQo+IGFkZA0KPiA+IFttYW55XSB3b3JkcyBhYm91dCBpdCBhcyBpdCdzIGEg
c3RhbmRhcmQgcHJvcGVydHkNCj4gDQo+IFdoaWxlIHRoZSBpbnRlcnJ1cHRzIHByb3BlcnR5IGlz
IHN0YW5kYXJkLCBpdCBpcyBvbmx5IHN0YW5kYXJkIGluIHRoZQ0KPiBzZW5zZSB0aGF0IHRoZSBu
YW1lIGFuZCBmb3JtYXQgYXJlIHN0YW5kYXJkLiBOb3QgZXZlcnkgYmlkbmluZyBoYXMgYW4NCj4g
aW50ZXJydXB0cyBwcm9wZXJ0eSwgYW5kIHRoZSBzZXQgb2YgaW50ZXJydXB0cyBkZXNjcmliZWQg
YXJlIHNwZWNpZmljDQo+IHRvDQo+IHRoZSBiaW5kaW5nLiBQbGVhc2UgZGVzY3JpYmUgdGhlIHNl
dCBvZiBpbnRlcnJ1cHRzIHlvdSBleHBlY3QuDQo+IA0KPiBEb2VzIHRoZSBkZXZpY2Ugb25seSBo
YXZlIHRoZSBlcnJvciBpbnRlcnJ1cHQsIG9yIGlzIHRoYXQgdGhlIG9ubHkNCj4gaW50ZXJydXB0
IHlvdSBjYXJlIGFib3V0Pw0KDQpTbyBhcyB3aXRoIHRoZSBwb3J0YWxzLCB0aGUgYmxvY2tzIHRo
ZW1zZWx2ZXMgZWFjaCBoYXZlIGEgc2luZ2xlIGludGVycnVwdCBsaW5lLCBidXQgYSBudW1iZXIg
b2YgdGhlIChDQ1NSKSByZWdpc3RlcnMgYXJlIHJlbGF0ZWQgdG8gdGhhdCBpbnRlcnJ1cHQgdG8g
Y2FwdHVyZSB0aGUgY29kZXMgYW5kIGF0dHJpYnV0ZXMgb2YgdGhlIHZhcmlvdXMgZXJyb3IgY29u
ZGl0aW9ucyBiZWluZyByZXBvcnRlZCwgYmVjYXVzZSBhIHdpZGUgdmFyaWV0eSBvZiBldmVudHMg
YW5kIGluZm9ybWF0aW9uIGNhbiBiZSBjb252ZXllZCB0aHJvdWdoIHRoYXQgaW50ZXJydXB0IGxp
bmUuIEluIGdlbmVyYWwsIHllcywgdGhpcyBpbnRlcnJ1cHQgbGluZSBpcyBvbmx5IGZvciAiZXJy
b3JzIiwgYnV0IHNvbWUgZXJyb3JzIGFyZSBtb3JlIGVxdWFsIHRoYW4gb3RoZXJzLiBFZy4gdGhl
cmUgaXMgdGhlIHVzdWFsIGNsYXNzIG9mIGNhdGFzdHJvcGhpYyBETUEtZmFpbHVyZSwgRUNDLCBo
YXJkd2FyZS1pbnRlcm5hbC1pbmNvbnNpc3RlbmN5IHR5cGVzIG9mIGVycm9ycyB0aGF0IGRldmlj
ZXMgdGVuZCB0byBzaG91dCBhYm91dC4gQnV0IHRoZXJlIGFyZSBhbHNvIHRocmVzaG9sZC1iYXNl
ZCAicmVzb3VyY2Ugc3RhcnZhdGlvbiIgdHlwZXMgb2YgImVycm9ycyIgdG9vLCB3aGljaCBhcmUg
bm90IHJlYWxseSBlcnJvcnMgcGVyIHNlLCB1bmxlc3MgdGhlIHN5c3RlbSBjb25maWd1cmF0aW9u
IGFuZCB1c2UtY2FzZSBpcyBleHBsaWNpdGx5IGVuZ2luZWVyZWQgYW5kIGNvbnN0cmFpbmVkIHN1
Y2ggdGhhdCB0aGUgdGhyZXNob2xkcyBzaG91bGRuJ3QgZXZlciBnZXQgdHJpcHBlZC4NCg0KU28g
dGhlIGhhbmRsaW5nIG9mIHRoZSBpbnRlcnJ1cHQgaW52b2x2ZXMgaW50ZXJyb2dhdGluZyByZWdp
c3RlcnMgdG8gY2xhc3NpZnkgdGhlIHdoeSwgaG93LCBhbmQgd2hhdCwgYW5kIHRoZSByZWFjdGlv
biB0byBpdCAod2hldGhlciBhIHdyaXRlLXRvLWNsZWFyIGlzIG5lZWRlZCwgd2hldGhlciBpdCBz
aG91bGQgYmUgbWFza2VkLCB3aGV0aGVyIGZ1bmN0aW9uYWxpdHkgc2hvdWxkIGJlIGhhbHRlZCwg
Li4uKSBpcyBhbHNvIGEgZmFpcmx5IGVsYWJvcmF0ZSBxdWVzdGlvbi4NCg0KSSBkb24ndCBrbm93
IHdoYXQgdGhlIGV4cGVjdGF0aW9ucyBhcmUgZm9yIHRoZXNlICJiaW5kaW5ncyIgZG9jcywgYnV0
IHRoZSByZXF1ZXN0IHRvICJkZXNjcmliZSB0aGUgc2V0IG9mIGludGVycnVwdHMgeW91IGV4cGVj
dCIgZG9lcyByaXNrIG9wZW5pbmcgYSBmYWlybHkgZWxhYm9yYXRlIGNhbiBvZiB3b3JtcyAodGhh
dCBtYXkgYmUgYmV0dGVyIGNvbmZpbmVkIHRvIHRoZSBkcml2ZXIpLiBVbmxlc3MgSSBtaXN1bmRl
cnN0b29kIHRoZSByZXF1ZXN0LCB3aGljaCBpcyBhbHdheXMgcXVpdGUgcG9zc2libGUgYmVmb3Jl
IG15IHNlY29uZCBjb2ZmZWUuLi4NCg0KQ2hlZXJzLA0KR2VvZmYNCg0KDQo=
