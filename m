Return-Path: <hongtao.jia@nxp.com>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30069.outbound.protection.outlook.com [40.107.3.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNtrG0MFMzDvxF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 18:14:37 +1100 (AEDT)
From: Troy Jia <hongtao.jia@nxp.com>
To: Scott Wood <oss@buserror.net>, "rui.zhang@intel.com"
 <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, Scott Wood <scott.wood@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V3 1/2] powerpc/mpc85xx: Update TMU device tree node for
 T1040/T1042
Date: Wed, 23 Nov 2016 07:14:30 +0000
Message-ID: <AM4PR0401MB18433E61BF1550676423E255EBB70@AM4PR0401MB1843.eurprd04.prod.outlook.com>
References: <1477361742-589-1-git-send-email-hongtao.jia@nxp.com>
 <1479884833.21746.44.camel@buserror.net>
In-Reply-To: <1479884833.21746.44.camel@buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2NvdHQgV29vZCBbbWFp
bHRvOm9zc0BidXNlcnJvci5uZXRdDQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMjMsIDIw
MTYgMzowNyBQTQ0KPiBUbzogVHJveSBKaWEgPGhvbmd0YW8uamlhQG54cC5jb20+OyBydWkuemhh
bmdAaW50ZWwuY29tOyBlZHViZXp2YWxAZ21haWwuY29tOw0KPiByb2JoK2R0QGtlcm5lbC5vcmc7
IFNjb3R0IFdvb2QgPHNjb3R0Lndvb2RAbnhwLmNvbT47IHNoYXduZ3VvQGtlcm5lbC5vcmcNCj4g
Q2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJz
Lm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDEvMl0gcG93ZXJw
Yy9tcGM4NXh4OiBVcGRhdGUgVE1VIGRldmljZSB0cmVlIG5vZGUgZm9yDQo+IFQxMDQwL1QxMDQy
DQo+IA0KPiBPbiBUdWUsIDIwMTYtMTAtMjUgYXQgMTA6MTUgKzA4MDAsIEppYSBIb25ndGFvIHdy
b3RlOg0KPiA+IEZyb206IEhvbmd0YW8gSmlhIDxob25ndGFvLmppYUBueHAuY29tPg0KPiA+DQo+
ID4gVXBkYXRlICN0aGVybWFsLXNlbnNvci1jZWxscyBmcm9tIDAgdG8gMSBhY2NvcmRpbmcgdG8g
dGhlIG5ldyBiaW5kaW5nLg0KPiA+IFRoZSBzZW5zb3Igc3BlY2lmaWVyIGFkZGVkIGlzIHRoZSBt
b25pdG9yaW5nIHNpdGUgSUQsIGFuZCByZXByZXNlbnRzDQo+ID4gdGhlICJuIiBpbiBUUklUU1Ju
IGFuZCBUUkFUU1JuLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmlhIEhvbmd0YW8gPGhvbmd0
YW8uamlhQG54cC5jb20+DQo+IA0KPiBXaGVyZSBjYW4gSSBmaW5kIHRoaXMgbmV3IGJpbmRpbmc/
IMKgQXMgb2YgdGhlIGN1cnJlbnQgbGludXgtbmV4dCBJIGRvbid0IHNlZSBhbnl0aGluZw0KPiBp
biBxb3JpcS10aGVybWFsLnR4dCBhYm91dCB0aGlzLg0KDQpIaSBSdWkgWmhhbmcsDQoNCkFzIHdl
IGRpc2N1c3NlZCBiZWZvcmUuIFRoZSB0aW1lIHdhcyBpbmFwcHJvcHJpYXRlIGFzIG1lcmdlIHdp
bmRvdyB3YXMgYWJvdXQgdG8gY2xvc2UuDQpTbyBkbyB5b3UgaGF2ZSBhbnkgcGxhbiBmb3IgYXBw
bHlpbmcgdGhlIGJpbmRpbmcgZmlsZSByZWNlbnRseT8NCg0KLUhvbmd0YW8uDQoNCg==
