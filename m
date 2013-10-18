Return-Path: <B29983@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 336A52C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2013 13:06:23 +1100 (EST)
From: Tang Yuantian-B29983 <B29983@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH v5] powerpc/mpc85xx: Update the clock nodes in device tree
Date: Fri, 18 Oct 2013 02:06:09 +0000
Message-ID: <D07C73A334FF604B95B3CBD2A545D07B150C5CAB@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1381300704-4238-1-git-send-email-Yuantian.Tang@freescale.com>
 <20131010100331.GE26954@e106331-lin.cambridge.arm.com>
 <D07C73A334FF604B95B3CBD2A545D07B150BD137@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131011092526.GE3910@e106331-lin.cambridge.arm.com>
 <1381518433.7979.536.camel@snotra.buserror.net>
 <D07C73A334FF604B95B3CBD2A545D07B150C24BD@039-SN2MPN1-013.039d.mgd.msft.net>
 <1381788786.7979.643.camel@snotra.buserror.net>
 <D07C73A334FF604B95B3CBD2A545D07B150C2B08@039-SN2MPN1-013.039d.mgd.msft.net>
 <1381858855.7979.693.camel@snotra.buserror.net>
 <D07C73A334FF604B95B3CBD2A545D07B150C312F@039-SN2MPN1-013.039d.mgd.msft.net>
 <1381942009.7979.727.camel@snotra.buserror.net>
 <D07C73A334FF604B95B3CBD2A545D07B150C4600@039-SN2MPN1-013.039d.mgd.msft.net>
 <1382027085.7979.774.camel@snotra.buserror.net>
In-Reply-To: <1382027085.7979.774.camel@snotra.buserror.net>
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

PiBPbiBXZWQsIDIwMTMtMTAtMTYgYXQgMjE6MDggLTA1MDAsIFRhbmcgWXVhbnRpYW4tQjI5OTgz
IHdyb3RlOg0KPiA+ID4gPiA+IFRoYXQgc2hvd3MgdGhlIGRpdmlkZXJzIGFzIGJlaW5nIHNvbWV3
aGVyZSBpbiBiZXR3ZWVuIHRoZSBQTEwNCj4gPiA+ID4gPiBhbmQgdGhlDQo+ID4gPiBNVVguDQo+
ID4gPiA+ID4gVGhlIE1VWCBpcyB3aGVyZSB0aGUgZGl2aWRlciBpcyBzZWxlY3RlZC4gIFRoZXJl
J3Mgbm90aGluZyBpbg0KPiA+ID4gPiA+IHRoZSBQTEwncyBwcm9ncmFtbWluZyBpbnRlcmZhY2Ug
dGhhdCByZWxhdGVzIHRvIHRoZSBkaXZpZGVycy4NCj4gPiA+ID4gPiBBcyBzdWNoIGl0J3Mgc2lt
cGxlciB0byBtb2RlbCBpdCBhcyBiZWluZyBwYXJ0IG9mIHRoZSBNVVguDQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiAtU2NvdHQNCj4gPiA+ID4gPg0KPiA+ID4gPiBJIGRvbid0IGtub3cgd2hldGhlciBp
dCBpcyBzaW1wbGVyLCBidXQgIm1vZGVsaW5nIGRpdmlkZXIgYXMgYmVpbmcNCj4gPiA+ID4gcGFy
dA0KPiA+ID4gb2YgdGhlIE1VWCINCj4gPiA+ID4gaXMgeW91ciBndWVzcywgcmlnaHQ/DQo+ID4g
PiA+IElmIHRoZSAiZGl2aWRlciIgaXMgaW5jbHVkZWQgaW4gTVVYLCB0aGUgTVVYIHdvdWxkIG5v
dCBiZSBjYWxsZWQNCj4gIk1VWCIuDQo+ID4gPg0KPiA+ID4gSXQncyBzdGlsbCBzZWxlY3Rpbmcg
ZnJvbSBtdWx0aXBsZSBQTExzLg0KPiA+ID4NCj4gPiA+ID4gSSBkb24ndCBrbm93IHdoZXRoZXIg
ImRpdmlkZXIiIG1vZHVsZSBleGlzdHMgb3Igbm90LiBJZiBpdCBleGlzdHMsDQo+ID4gPiA+IGl0
IHNob3VsZCBiZSBwYXJ0IG9mIFBMTCBvciBiZXR3ZWVuIFBMTCBhbmQgTVVYLiB3aGVyZXZlciBp
dCB3YXMsDQo+ID4gPiA+IHRoZQ0KPiA+ID4gZGV2aWNlIHRyZWUgYmluZGluZyBpcyBhcHByb3By
aWF0ZS4NCj4gPiA+DQo+ID4gPiBUaGUgZGV2aWNlIHRyZWUgYmluZGluZyBpcyB1bm5lY2Vzc2Fy
aWx5IGNvbXBsaWNhdGVkLg0KPiA+ID4NCj4gPiA+ID4gVGhlIFAzMDQxUk0gc2hvd3MgZXhhY3Rs
eSBlYWNoIFBMTCBoYXMgMiBvdXRwdXRzIHdoaWNoIGRlZmluaXRlbHkNCj4gPiA+ID4gaGF2ZQ0K
PiA+ID4gbm8gImRpdmlkZXIiIGF0IGFsbC4NCj4gPiA+DQo+ID4gPiBUaGF0IGRpYWdyYW0gaXMg
YSBiaXQgd2VpcmQgLS0gb25lIG9mIHRoZSBvdXRwdXRzIGlzIHVzZWQgYXMgaXMsIGFuZA0KPiA+
ID4gdGhlIG90aGVyIGlzIHNwbGl0IGludG8gMS8yIGFuZCAxLzQuICBJdCBkb2Vzbid0IHJlYWxs
eSBtYXR0ZXINCj4gPiA+IHRob3VnaDsgdGhlIGVuZCByZXN1bHQgaXMgdGhlIHNhbWUuICBXZSdy
ZSBkZXNjcmliaW5nIHRoZQ0KPiA+ID4gcHJvZ3JhbW1pbmcgaW50ZXJmYWNlLCBub3QgYXJ0d29y
ayBjaG9pY2VzIGluIHRoZSBtYW51YWwuDQo+ID4gPg0KPiA+ID4gLVNjb3R0DQo+ID4gPg0KPiA+
IElmIHRoZSBkZXZpY2UgdHJlZSBuZWVkcyB0byBiZSBtb2RpZmllZCwgY291bGQgeW91IGdpdmUg
bWUgeW91cg0KPiBzdWdnZXN0aW9ucz8NCj4gDQo+IE15IHN1Z2dlc3Rpb24gaXMgdG8gaGF2ZSBv
bmx5IG9uZSBvdXRwdXQgcGVyIFBMTCBub2RlLiAgVGhlIE1VWCBub2RlDQo+IHdvdWxkIGhhdmUg
b25lIGlucHV0IHBlciBQTEwuICBEaXZpZGVycyB3b3VsZCBiZSBoYW5kbGVkIGludGVybmFsbHkg
dG8NCj4gdGhlIE1VWCBkcml2ZXIuDQo+IA0KPiAtU2NvdHQNCj4gDQpJIGRvbid0IHRoaW5rIHlv
dXIgc3VnZ2VzdGlvbiBpcyBjb25zdHJ1Y3RpdmUuDQpZb3VyIHN1Z2dlc3Rpb24gaXMgb24gdGhl
IHByZW1pc2Ugb2YgdGhhdCB0aGUgImRpdmlkZXIiIGlzIHBhcnQgb2YgTVVYLA0KQW5kIEkgdGhp
bmsgaXQgc2hvdWxkIGJlIHBhcnQgb2YgUExMLg0KTVVYIGNhbid0IENSRUFURSBjbG9jayB3aGlj
aCBQTEwgY2FuLiBTbyBteSB0aG91Z2h0IGlzIG1vcmUgcmVhc29uYWJsZS4NCklmIHRoZSBkZXZp
Y2UgdHJlZSBkb2N1bWVudHMgbGlrZSB3aGF0IHlvdSBzYWlkLCBpdCB3b3VsZCBoYXZlIGZldyBo
ZWxwIGZvciBkcml2ZXIuDQpUaGUgcmVhc29uIGlzIG9idmlvdXMgdGhhdCB0aGUgZHJpdmVyIGlz
IHN0aWxsIGdvaW5nIHRvIGRlYWwgd2l0aCB0aGUgImRpdmlkZXIiIA0KZGV0YWlsIHdoaWNoIHZh
cmllcyBmcm9tIHBsYXRmb3JtIHRvIHBsYXRmb3JtLg0KSSB3aWxsIGRvY3VtZW50IGFzIGl0IHdh
cyB1bmxlc3MgeW91IHByb3ZlIHlvdXIgc3VnZ2VzdGlvbi4NCg0KVGhhbmtzLA0KWXVhbnRpYW4N
Cg==
