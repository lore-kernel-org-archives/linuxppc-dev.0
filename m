Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0118.outbound.protection.outlook.com [157.56.110.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ADA621A0145
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 12:51:43 +1000 (AEST)
From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>, "shawnguo@kernel.org"
 <shawnguo@kernel.org>, Jin Jason <Jason.Jin@freescale.com>, Huan Wang
 <alison.wang@freescale.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Zhao C.H.
 <chenhui.zhao@freescale.com>, Yuantian Tang <Yuantian.Tang@freescale.com>
Subject: RE: [PATCH v3 1/2] fsl: Add binding for RCPM
Date: Fri, 25 Sep 2015 02:51:36 +0000
Message-ID: <SN1PR0301MB16165FD739C5CD90FB4352149D420@SN1PR0301MB1616.namprd03.prod.outlook.com>
References: <1443083354-37369-1-git-send-email-dongsheng.wang@freescale.com>
 <1443123009.32298.29.camel@freescale.com>
 <SN1PR0301MB161653CC69BB78A0A8B565569D420@SN1PR0301MB1616.namprd03.prod.outlook.com>
 <1443149032.32298.102.camel@freescale.com>
In-Reply-To: <1443149032.32298.102.camel@freescale.com>
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

PiBPbiBUaHUsIDIwMTUtMDktMjQgYXQgMjE6MzggLTA1MDAsIFdhbmcgRG9uZ3NoZW5nLUI0MDUz
NCB3cm90ZToNCj4gPiA+ID4gKyogRnJlZXNjYWxlIFJDUE0gV2FrZXVwIFNvdXJjZSBEZXZpY2Ug
VHJlZSBCaW5kaW5ncw0KPiA+ID4gPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiA+ID4gPiArUmVxdWlyZWQgcmNwbS13YWtldXAgcHJvcGVydHkgc2hvdWxk
IGJlIGFkZGVkIHRvIGEgZGV2aWNlIG5vZGUgaWYgdGhlDQo+ID4gPiA+IGRldmljZQ0KPiA+ID4g
PiArY2FuIGJlIHVzZWQgYXMgYSB3YWtldXAgc291cmNlLg0KPiA+ID4gPiArDQo+ID4gPiA+ICsg
IC0gcmNwbS13YWtldXA6IFRoZSB2YWx1ZSBvZiB0aGUgcHJvcGVydHkgY29uc2lzdHMgb2YgY2Vs
bHMsIHRoZQ0KPiA+ID4gPiBudW1iZXIgb2YNCj4gPiA+ID4gKyAgICAgY2VsbHMgZGVmaW5lZCBp
biAiZnNsLCNyY3BtLXdha2V1cC1jZWxscyIuIFRoZSBmaXJzdCBjZWxsIGlzIGENCj4gPiA+ID4g
cG9pbnRlcg0KPiA+ID4gPiArICAgICB0byB0aGUgcmNwbSBub2RlLCB0aGUgc2Vjb25kIGNlbGwg
aXMgdGhlIGJpdCBtYXNrIHRoYXQgc2hvdWxkIGJlDQo+ID4gPiA+IHNldA0KPiA+ID4gPiArICAg
ICBpbiBJUFBERVhQQ1IwLCBhbmQgdGhlIHRoaXJkIGNlbGwgaXMgZm9yIElQUERFWFBDUjEsIGFu
ZCBzbyBvbi4NCj4gPiA+DQo+ID4gPiBUaGUgcGhhbmRsZSBzaG91bGQgbm90IGJlIGluY2x1ZGVk
IGluIHRoZSBjZWxsIGNvdW50Lg0KPiA+ID4NCj4gPg0KPiA+IFllcywgdGhlIGZpcnN0IGNlbGwg
IiZyY3BtIiBzaG91bGQgYmUgaW4gdGhlIGNlbGwgY291bnQsIHJpZ2h0Pw0KPiANCj4gTm8uICBO
b25lIG9mIHRoZSBvdGhlciAjZm9vLWNlbGxzIHdvcmsgdGhhdCB3YXkuDQo+IA0KDQpTb3JyeSBh
IHR5cGUgd3JvbmcuIEkgbWVhbnMgdGhlIGZpcnN0IGNlbGwgIiZyY3BtIiBzaG91bGQgKk5PVCog
YmUgaW4gdGhlIGNlbGwgY291bnQuDQoNClJlZ2FyZHMsDQotRG9uZ3NoZW5nDQo=
