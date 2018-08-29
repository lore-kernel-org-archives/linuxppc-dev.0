Return-Path: <qiang.zhao@nxp.com>
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::606])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420ff45nJJzF315
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 18:57:47 +1000 (AEST)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Rob Herring <robh@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
CC: Leo Li <leoyang.li@nxp.com>, Andy Gross <andy.gross@linaro.org>, David
 Brown <david.brown@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thierry
 Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-soc@vger.kernel.org"
 <linux-soc@vger.kernel.org>
Subject: RE: [PATCH] soc: Convert to using %pOFn instead of device_node.name
Date: Wed, 29 Aug 2018 08:57:40 +0000
Message-ID: <VI1PR04MB3247DA20AA7C6242B90FA6DA91090@VI1PR04MB3247.eurprd04.prod.outlook.com>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-43-robh@kernel.org>
In-Reply-To: <20180828015252.28511-43-robh@kernel.org>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCkRhdGU6IDIwMTjE6jjUwjI4yNUg
OTo1Mw0KPiBUbzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogUWlhbmcgWmhh
byA8cWlhbmcuemhhb0BueHAuY29tPjsgTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+OyBBbmR5
DQo+IEdyb3NzIDxhbmR5Lmdyb3NzQGxpbmFyby5vcmc+OyBEYXZpZCBCcm93biA8ZGF2aWQuYnJv
d25AbGluYXJvLm9yZz47IEhlaWtvDQo+IFN0dWVibmVyIDxoZWlrb0BzbnRlY2guZGU+OyBUaGll
cnJ5IFJlZGluZyA8dGhpZXJyeS5yZWRpbmdAZ21haWwuY29tPjsNCj4gSm9uYXRoYW4gSHVudGVy
IDxqb25hdGhhbmhAbnZpZGlhLmNvbT47IFNhbnRvc2ggU2hpbGlta2FyDQo+IDxzc2FudG9zaEBr
ZXJuZWwub3JnPjsgbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7DQo+IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtc29jQHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBbUEFUQ0hdIHNvYzogQ29udmVydCB0byB1c2luZyAlcE9GbiBpbnN0ZWFkIG9mIGRl
dmljZV9ub2RlLm5hbWUNCj4gDQo+IEluIHByZXBhcmF0aW9uIHRvIHJlbW92ZSB0aGUgbm9kZSBu
YW1lIHBvaW50ZXIgZnJvbSBzdHJ1Y3QgZGV2aWNlX25vZGUsDQo+IGNvbnZlcnQgcHJpbnRmIHVz
ZXJzIHRvIHVzZSB0aGUgJXBPRm4gZm9ybWF0IHNwZWNpZmllci4NCj4gDQo+IENjOiBRaWFuZyBa
aGFvIDxxaWFuZy56aGFvQG54cC5jb20+DQo+IENjOiBMaSBZYW5nIDxsZW95YW5nLmxpQG54cC5j
b20+DQo+IENjOiBBbmR5IEdyb3NzIDxhbmR5Lmdyb3NzQGxpbmFyby5vcmc+DQo+IENjOiBEYXZp
ZCBCcm93biA8ZGF2aWQuYnJvd25AbGluYXJvLm9yZz4NCj4gQ2M6IEhlaWtvIFN0dWVibmVyIDxo
ZWlrb0BzbnRlY2guZGU+DQo+IENjOiBUaGllcnJ5IFJlZGluZyA8dGhpZXJyeS5yZWRpbmdAZ21h
aWwuY29tPg0KPiBDYzogSm9uYXRoYW4gSHVudGVyIDxqb25hdGhhbmhAbnZpZGlhLmNvbT4NCj4g
Q2M6IFNhbnRvc2ggU2hpbGlta2FyIDxzc2FudG9zaEBrZXJuZWwub3JnPg0KPiBDYzogbGludXhw
cGMtZGV2QGxpc3RzLm96bGFicy5vcmcNCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZw0KPiBDYzogbGludXgtc29jQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2Zm
LWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvc29j
L2RvdmUvcG11LmMgICAgICAgICAgICB8ICA4ICsrKy0tLQ0KPiAgZHJpdmVycy9zb2MvZnNsL3Fl
L3FlX3RkbS5jICAgICAgIHwgIDQgKy0tDQo+ICBkcml2ZXJzL3NvYy9xY29tL2Fwci5jICAgICAg
ICAgICAgfCAgMiArLQ0KPiAgZHJpdmVycy9zb2Mvcm9ja2NoaXAvcG1fZG9tYWlucy5jIHwgNDQg
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQ0KPiAgZHJpdmVycy9zb2MvdGVncmEvcG1j
LmMgICAgICAgICAgIHwgMTIgKysrKy0tLS0tDQo+ICBkcml2ZXJzL3NvYy90aS9rbmF2X2RtYS5j
ICAgICAgICAgfCAgOCArKystLS0NCj4gIGRyaXZlcnMvc29jL3RpL2tuYXZfcW1zc19xdWV1ZS5j
ICB8ICA4ICsrKy0tLQ0KPiAgNyBmaWxlcyBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspLCA0MyBk
ZWxldGlvbnMoLSkNCg0KRm9yIHFlX3RkbSBwYXJ0DQpBY2tlZC1ieTogUWlhbmcgWmhhbyA8cWlh
bmcuemhhb0BueHAuY29tPg0KDQo=
