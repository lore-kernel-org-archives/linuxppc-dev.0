Return-Path: <B29983@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0F4152C0146
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Oct 2013 12:59:43 +1100 (EST)
From: Tang Yuantian-B29983 <B29983@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH v5] powerpc/mpc85xx: Update the clock nodes in device tree
Date: Tue, 15 Oct 2013 01:59:33 +0000
Message-ID: <D07C73A334FF604B95B3CBD2A545D07B150C2B08@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1381300704-4238-1-git-send-email-Yuantian.Tang@freescale.com>
 <20131010100331.GE26954@e106331-lin.cambridge.arm.com>
 <D07C73A334FF604B95B3CBD2A545D07B150BD137@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131011092526.GE3910@e106331-lin.cambridge.arm.com>
 <1381518433.7979.536.camel@snotra.buserror.net>
 <D07C73A334FF604B95B3CBD2A545D07B150C24BD@039-SN2MPN1-013.039d.mgd.msft.net>
 <1381788786.7979.643.camel@snotra.buserror.net>
In-Reply-To: <1381788786.7979.643.camel@snotra.buserror.net>
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFdvb2QgU2NvdHQtQjA3NDIx
DQo+IFNlbnQ6IDIwMTPlubQxMOaciDE15pelIOaYn+acn+S6jCA2OjEzDQo+IFRvOiBUYW5nIFl1
YW50aWFuLUIyOTk4Mw0KPiBDYzogV29vZCBTY290dC1CMDc0MjE7IE1hcmsgUnV0bGFuZDsgZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3Jn
OyBMaSBZYW5nLUxlby1SNTg0NzINCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NV0gcG93ZXJwYy9t
cGM4NXh4OiBVcGRhdGUgdGhlIGNsb2NrIG5vZGVzIGluIGRldmljZQ0KPiB0cmVlDQo+IA0KPiBP
biBGcmksIDIwMTMtMTAtMTEgYXQgMjE6NTIgLTA1MDAsIFRhbmcgWXVhbnRpYW4tQjI5OTgzIHdy
b3RlOg0KPiA+IFRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBXb29kIFNjb3R0LUIwNzQyMQ0KPiA+ID4gU2Vu
dDogMjAxM+W5tDEw5pyIMTLml6Ug5pif5pyf5YWtIDM6MDcNCj4gPiA+IFRvOiBNYXJrIFJ1dGxh
bmQNCj4gPiA+IENjOiBUYW5nIFl1YW50aWFuLUIyOTk4MzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4cHBjLQ0KPiA+ID4gZGV2QGxpc3RzLm96bGFicy5vcmc7IExpIFlhbmctTGVv
LVI1ODQ3Mg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2NV0gcG93ZXJwYy9tcGM4NXh4OiBV
cGRhdGUgdGhlIGNsb2NrIG5vZGVzIGluDQo+ID4gPiBkZXZpY2UgdHJlZQ0KPiA+ID4NCj4gPiA+
IEknbSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQgdGhlICJfMCIvIl8xIiBwYXJ0LCB0aG91Z2guICBE
b2Vzbid0IGVhY2gNCj4gPiA+IFBMTCBqdXN0IGhhdmUgb25lIG91dHB1dCwgd2hpY2ggdGhlIGNv
bnN1bWVyIG1heSBjaG9vc2UgdG8gZGl2aWRlIGJ5DQo+ID4gPiAyIChvciBpbiBzb21lIGNhc2Vz
IDQpPyAgV2h5IGRvZXMgdGhhdCBkaXZpc2lvbiBuZWVkIHRvIGJlIGV4cG9zZWQNCj4gPiA+IGlu
IHRoZSBkZXZpY2UgdHJlZSBhcyBzZXBhcmF0ZSBjb25uZWN0aW9ucyB0byB0aGUgcGFyZW50IGNs
b2NrPw0KPiA+ID4NCj4gPiBUaGUgZGV2aWNlIHRyZWUgbWFrZXMgdGhhdCBxdWl0ZSBjbGVhci4N
Cj4gDQo+IFlvdSBjaG9zZSB0byBtb2RlbCBpdCB0aGF0IHdheSBpbiB0aGUgZGV2aWNlIHRyZWU7
IHRoYXQgZG9lc24ndCBtYWtlIGl0DQo+IGNsZWFyIHRoYXQgdGhlIGhhcmR3YXJlIHdvcmtzIHRo
YXQgd2F5IG9yIHRoYXQgaXQncyBhIGdvb2Qgd2F5IHRvIG1vZGVsDQo+IGl0Lg0KPiANCj4gPiBF
YWNoIFBMTCBoYXMgc2V2ZXJhbCBvdXRwdXQgd2hpY2ggTVVYIG5vZGUgY2FuIHRha2UgZnJvbS4N
Cj4gDQo+IFBvaW50IG91dCB3aGVyZSBpbiB0aGUgaGFyZHdhcmUgZG9jdW1lbnRhdGlvbiBpdCBz
YXlzIHRoaXMuICBXaGF0IEkgc2VlDQo+IGlzIGEgUExMIHRoYXQgaGFzIG9uZSBvdXRwdXQsIGFu
ZCBhIE1VWCByZWdpc3RlciB0aGF0IGNhbiBjaG9vc2UgZnJvbQ0KPiBtdWx0aXBsZSBQTEwgYW5k
IGRpdmlkZXIgb3B0aW9ucy4NCj4gDQpUYWtlIFQ0MjQwIGZvciBleGFtcGxlOiBzZWUgc2VjdGlv
biA0LjYuNS4xICwgKFBhZ2UgMTQxKSBpbiBUNDI0MFJNIFJldi4gRCwgMDkvMjAxMi4NCg0KPiA+
ICBJdCBpcyBub3QgYSBydW50aW1lIGRlY2lzaW9uLg0KPiANCj4gSG1tPyAgSXQncyBhIHJlZ2lz
dGVyIHlvdSB3cml0ZSB0by4NCj4gDQpJIG1lYW4gdGhlIG51bWJlciBvZiBQTEwgb3V0cHV0IG9y
IHRoZSBkaXZpc2lvbiBvZiBQTEwgaXMgbm90IGEgcnVudGltZSBkZWNpc2lvbi4NCldoaWNoIG91
dHB1dCBvZiBQTEwgdGhlIE1VWCBjYW4gdGFrZSBpcyBhIHJ1bnRpbWUgZGVjaXNpb24uDQoNClJl
Z2FyZHMsDQpZdWFudGlhbg0KDQo+IC1TY290dA0KPiANCg0K
