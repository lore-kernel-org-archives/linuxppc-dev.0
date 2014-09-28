Return-Path: <jingchang.lu@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0116.outbound.protection.outlook.com [65.55.169.116])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 595C01A0074
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Sep 2014 20:01:20 +1000 (EST)
From: Jingchang Lu <jingchang.lu@freescale.com>
To: "Laurentiu.Tudor@freescale.com" <Laurentiu.Tudor@freescale.com>,
 "mturquette@linaro.org" <mturquette@linaro.org>
Subject: RE: [PATCHv4] clk: ppc-corenet: rename to ppc-qoriq and add
 CLK_OF_DECLARE support
Date: Sun, 28 Sep 2014 10:01:10 +0000
Message-ID: <1760763ea8a0468e817d082f95e4016b@BL2PR03MB467.namprd03.prod.outlook.com>
References: <1411454806-8214-1-git-send-email-jingchang.lu@freescale.com>
 <542410D3.2060507@freescale.com>
In-Reply-To: <542410D3.2060507@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogVHVkb3IgTGF1cmVudGl1LUIxMDcx
Ng0KPlNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMjUsIDIwMTQgODo1NiBQTQ0KPlRvOiBMdSBK
aW5nY2hhbmctQjM1MDgzOyBtdHVycXVldHRlQGxpbmFyby5vcmcNCj5DYzogV29vZCBTY290dC1C
MDc0MjE7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBsaW51eC0NCj5rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj5TdWJq
ZWN0OiBSZTogW1BBVENIdjRdIGNsazogcHBjLWNvcmVuZXQ6IHJlbmFtZSB0byBwcGMtcW9yaXEg
YW5kIGFkZA0KPkNMS19PRl9ERUNMQVJFIHN1cHBvcnQNCj4NCj5IaSBKaW5nY2hhbmcsDQo+DQo+
T24gMDkvMjMvMjAxNCAwOTo0NiBBTSwgSmluZ2NoYW5nIEx1IHdyb3RlOg0KPj4gVGhlIElQIGlz
IHNoYXJlZCBieSBQUEMgYW5kIEFSTSwgdGhpcyByZW5hbWVzIGl0IHRvIHFvcmlxIGZvciBiZXR0
ZXINCj4+IHJlcHJlc2VudGlvbiwgYW5kIHRoaXMgYWxzbyBhZGRzIHRoZSBDTEtfT0ZfREVDTEFS
RSBzdXBwb3J0IGZvciBiZWluZw0KPj4gaW5pdGlhbGl6ZWQgYnkgb2ZfY2xrX2luaXQoKSBvbiBB
Uk0uDQo+Pg0KPg0KPkkgdGhpbmsgeW91IG5lZWQgdG8gYWxzbyB1cGRhdGUgZHJpdmVycy9jcHVm
cmVxL0tjb25maWcucG93ZXJwYyB0byB1c2UgdGhlDQo+cmVuYW1lZCBjb25maWcgb3B0aW9uLg0K
Pg0KDQpUaGFua3MsIEkgd2lsbCB1cGRhdGUgdGhhdCBzZWxlY3RlZCBjb25maWcgb3B0aW9uIG9m
IENMS19QUENfQ09SRU5FVC4NCg0KQmVzdCBSZWdhcmRzLA0KSmluZ2NoYW5nDQo+LS0tDQo+QmVz
dCBSZWdhcmRzLCBMYXVyZW50aXUNCg0KDQo=
