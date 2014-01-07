Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0187.outbound.protection.outlook.com [207.46.163.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F02D32C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2014 20:35:24 +1100 (EST)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas
 <bhelgaas@google.com>
Subject: RE: [RFC] linux/pci: move pci_platform_pm_ops to linux/pci.h
Date: Tue, 7 Jan 2014 09:35:16 +0000
Message-ID: <121c487959fe4d73897b7003ad8554a4@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1387533832-34554-1-git-send-email-dongsheng.wang@freescale.com>
 <CAErSpo7+8sLZVi24fi+xxTEW2_DTJ2_zUrW+vobMGsvCEFwY_Q@mail.gmail.com>
 <2276888.ovWFBgDtau@vostro.rjw.lan>
In-Reply-To: <2276888.ovWFBgDtau@vostro.rjw.lan>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Linux PM list <linux-pm@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29j
a2kgW21haWx0bzpyandAcmp3eXNvY2tpLm5ldF0NCj4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDA2
LCAyMDE0IDg6MTMgUE0NCj4gVG86IEJqb3JuIEhlbGdhYXMNCj4gQ2M6IFdhbmcgRG9uZ3NoZW5n
LUI0MDUzNDsgWmFuZyBSb3ktUjYxOTExOyBXb29kIFNjb3R0LUIwNzQyMTsgS3VtYXIgR2FsYTsg
TGludXgNCj4gUE0gbGlzdDsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXhwcGMtZGV2
DQo+IFN1YmplY3Q6IFJlOiBbUkZDXSBsaW51eC9wY2k6IG1vdmUgcGNpX3BsYXRmb3JtX3BtX29w
cyB0byBsaW51eC9wY2kuaA0KPiANCj4gT24gRnJpZGF5LCBEZWNlbWJlciAyMCwgMjAxMyAwOTo0
Mjo1OSBBTSBCam9ybiBIZWxnYWFzIHdyb3RlOg0KPiA+IE9uIEZyaSwgRGVjIDIwLCAyMDEzIGF0
IDM6MDMgQU0sIERvbmdzaGVuZyBXYW5nDQo+ID4gPGRvbmdzaGVuZy53YW5nQGZyZWVzY2FsZS5j
b20+IHdyb3RlOg0KPiA+ID4gRnJvbTogV2FuZyBEb25nc2hlbmcgPGRvbmdzaGVuZy53YW5nQGZy
ZWVzY2FsZS5jb20+DQo+ID4gPg0KPiA+ID4gbWFrZSBGcmVlc2NhbGUgcGxhdGZvcm0gdXNlIHBj
aV9wbGF0Zm9ybV9wbV9vcHMgc3RydWN0Lg0KPiA+DQo+ID4gVGhpcyBjaGFuZ2Vsb2cgZG9lc24n
dCBzYXkgYW55dGhpbmcgYWJvdXQgd2hhdCB0aGUgcGF0Y2ggZG9lcy4NCj4gPg0KPiA+IEkgaW5m
ZXIgdGhhdCB5b3Ugd2FudCB0byB1c2UgcGNpX3BsYXRmb3JtX3BtX29wcyBmcm9tIHNvbWUgRnJl
ZXNjYWxlDQo+ID4gY29kZS4gIFRoaXMgcGF0Y2ggc2hvdWxkIGJlIHBvc3RlZCBhbG9uZyB3aXRo
IHRoZSBwYXRjaGVzIHRoYXQgYWRkDQo+ID4gdGhhdCBGcmVlc2NhbGUgY29kZSwgc28gd2UgY2Fu
IHNlZSBob3cgeW91IGludGVuZCB0byB1c2UgaXQuDQo+ID4NCj4gPiBUaGUgZXhpc3RpbmcgdXNl
IGlzIGluIGRyaXZlcnMvcGNpL3BjaS1hY3BpLmMsIHNvIGl0J3MgcG9zc2libGUgdGhhdA0KPiA+
IHlvdXIgbmV3IHVzZSBzaG91bGQgYmUgYWRkZWQgaW4gdGhlIHNhbWUgd2F5LCBpbiBkcml2ZXJz
L3BjaSwgc28gd2UNCj4gPiBkb24ndCBoYXZlIHRvIG1ha2UgcGNpX3BsYXRmb3JtX3BtX29wcyBw
YXJ0IG9mIHRoZSBwdWJsaWMgUENJDQo+ID4gaW50ZXJmYWNlIGluIGluY2x1ZGUvbGludXgvcGNp
LmguDQo+ID4NCj4gPiBUaGF0IHNhaWQsIGlmIFJhcGhhZWwgdGhpbmtzIHRoaXMgbWFrZXMgc2Vu
c2UsIGl0J3MgT0sgd2l0aCBtZS4NCj4gDQo+IFdlbGwsIEknZCBsaWtlIHRvIGtub3cgd2h5IGV4
YWN0bHkgdGhlIGNoYW5nZSBpcyBuZWVkZWQgaW4gdGhlIGZpcnN0IHBsYWNlLg0KPiANClRoYW5r
cyBmb3IgcmV2aWV3LCBJIHRoaW5rIHRoZSBpZGVhIGlzIG5vdCBzdWl0YWJsZSBmb3IgZnJlZXNj
YWxlIHBsYXRmb3JtDQppbXBsZW1lbnRhdGlvbiBvZiB0aGUgcmlnaHQgbm93Lg0KDQpJIHdpbGwg
ZHJvcCB0aGlzIFJGQyBwYXRjaC4NCg0KLURvbmdzaGVuZw0KDQo+IFRoYW5rcyENCj4gDQo+IC0t
DQo+IEkgc3BlYWsgb25seSBmb3IgbXlzZWxmLg0KPiBSYWZhZWwgSi4gV3lzb2NraSwgSW50ZWwg
T3BlbiBTb3VyY2UgVGVjaG5vbG9neSBDZW50ZXIuDQo+IA0KDQo=
