Return-Path: <B29983@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BE1A52C0199
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Oct 2013 13:57:18 +1100 (EST)
From: Tang Yuantian-B29983 <B29983@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH v5] powerpc/mpc85xx: Update the clock nodes in device tree
Date: Wed, 16 Oct 2013 02:57:07 +0000
Message-ID: <D07C73A334FF604B95B3CBD2A545D07B150C312F@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1381300704-4238-1-git-send-email-Yuantian.Tang@freescale.com>
 <20131010100331.GE26954@e106331-lin.cambridge.arm.com>
 <D07C73A334FF604B95B3CBD2A545D07B150BD137@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131011092526.GE3910@e106331-lin.cambridge.arm.com>
 <1381518433.7979.536.camel@snotra.buserror.net>
 <D07C73A334FF604B95B3CBD2A545D07B150C24BD@039-SN2MPN1-013.039d.mgd.msft.net>
 <1381788786.7979.643.camel@snotra.buserror.net>
 <D07C73A334FF604B95B3CBD2A545D07B150C2B08@039-SN2MPN1-013.039d.mgd.msft.net>
 <1381858855.7979.693.camel@snotra.buserror.net>
In-Reply-To: <1381858855.7979.693.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-Leo-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiA+ID4gPiA+DQo+ID4gPiA+IFRoZSBkZXZpY2UgdHJlZSBtYWtlcyB0aGF0IHF1aXRlIGNsZWFy
Lg0KPiA+ID4NCj4gPiA+IFlvdSBjaG9zZSB0byBtb2RlbCBpdCB0aGF0IHdheSBpbiB0aGUgZGV2
aWNlIHRyZWU7IHRoYXQgZG9lc24ndCBtYWtlDQo+ID4gPiBpdCBjbGVhciB0aGF0IHRoZSBoYXJk
d2FyZSB3b3JrcyB0aGF0IHdheSBvciB0aGF0IGl0J3MgYSBnb29kIHdheSB0bw0KPiA+ID4gbW9k
ZWwgaXQuDQo+ID4gPg0KPiA+ID4gPiBFYWNoIFBMTCBoYXMgc2V2ZXJhbCBvdXRwdXQgd2hpY2gg
TVVYIG5vZGUgY2FuIHRha2UgZnJvbS4NCj4gPiA+DQo+ID4gPiBQb2ludCBvdXQgd2hlcmUgaW4g
dGhlIGhhcmR3YXJlIGRvY3VtZW50YXRpb24gaXQgc2F5cyB0aGlzLiAgV2hhdCBJDQo+ID4gPiBz
ZWUgaXMgYSBQTEwgdGhhdCBoYXMgb25lIG91dHB1dCwgYW5kIGEgTVVYIHJlZ2lzdGVyIHRoYXQg
Y2FuIGNob29zZQ0KPiA+ID4gZnJvbSBtdWx0aXBsZSBQTEwgYW5kIGRpdmlkZXIgb3B0aW9ucy4N
Cj4gPiA+DQo+ID4gVGFrZSBUNDI0MCBmb3IgZXhhbXBsZTogc2VlIHNlY3Rpb24gNC42LjUuMSAs
IChQYWdlIDE0MSkgaW4gVDQyNDBSTSBSZXYuDQo+IEQsIDA5LzIwMTIuDQo+IA0KPiBUaGF0IHNo
b3dzIHRoZSBkaXZpZGVycyBhcyBiZWluZyBzb21ld2hlcmUgaW4gYmV0d2VlbiB0aGUgUExMIGFu
ZCB0aGUgTVVYLg0KPiBUaGUgTVVYIGlzIHdoZXJlIHRoZSBkaXZpZGVyIGlzIHNlbGVjdGVkLiAg
VGhlcmUncyBub3RoaW5nIGluIHRoZSBQTEwncw0KPiBwcm9ncmFtbWluZyBpbnRlcmZhY2UgdGhh
dCByZWxhdGVzIHRvIHRoZSBkaXZpZGVycy4gIEFzIHN1Y2ggaXQncyBzaW1wbGVyDQo+IHRvIG1v
ZGVsIGl0IGFzIGJlaW5nIHBhcnQgb2YgdGhlIE1VWC4NCj4gDQo+IC1TY290dA0KPiANCkkgZG9u
J3Qga25vdyB3aGV0aGVyIGl0IGlzIHNpbXBsZXIsIGJ1dCAibW9kZWxpbmcgZGl2aWRlciBhcyBi
ZWluZyBwYXJ0IG9mIHRoZSBNVVgiDQppcyB5b3VyIGd1ZXNzLCByaWdodD8NCklmIHRoZSAiZGl2
aWRlciIgaXMgaW5jbHVkZWQgaW4gTVVYLCB0aGUgTVVYIHdvdWxkIG5vdCBiZSBjYWxsZWQgIk1V
WCIuDQpJIGRvbid0IGtub3cgd2hldGhlciAiZGl2aWRlciIgbW9kdWxlIGV4aXN0cyBvciBub3Qu
IElmIGl0IGV4aXN0cywgaXQgc2hvdWxkIGJlIHBhcnQNCm9mIFBMTCBvciBiZXR3ZWVuIFBMTCBh
bmQgTVVYLiB3aGVyZXZlciBpdCB3YXMsIHRoZSBkZXZpY2UgdHJlZSBiaW5kaW5nIGlzIGFwcHJv
cHJpYXRlLg0KVGhlIFAzMDQxUk0gc2hvd3MgZXhhY3RseSBlYWNoIFBMTCBoYXMgMiBvdXRwdXRz
IHdoaWNoIGRlZmluaXRlbHkgaGF2ZSBubyAiZGl2aWRlciIgYXQgYWxsLg0KDQpSZWdhcmRzLA0K
WXVhbnRpYW4NCg==
