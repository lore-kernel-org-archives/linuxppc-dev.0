Return-Path: <vabhav.sharma@nxp.com>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0083.outbound.protection.outlook.com [104.47.0.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421DpN50TXzF36r
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 17:36:56 +1000 (AEST)
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: Scott Wood <oss@buserror.net>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "mturquette@baylibre.com"
 <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org"
 <viresh.kumar@linaro.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "linux-kernel-owner@vger.kernel.org"
 <linux-kernel-owner@vger.kernel.org>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de"
 <arnd@arndb.de>, "kstewart@linuxfoundation.org"
 <kstewart@linuxfoundation.org>, "yamada.masahiro@socionext.com"
 <yamada.masahiro@socionext.com>
CC: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>, Andy Tang
 <andy.tang@nxp.com>, Udit Kumar <udit.kumar@nxp.com>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support for lx2160a
Date: Thu, 30 Aug 2018 07:36:48 +0000
Message-ID: <VI1PR04MB4800E8B1E8541FCA9221A1CFF3080@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-4-git-send-email-vabhav.sharma@nxp.com>
 <4a9ea6b451683ec98c92e86a5ae6b91213a6afcf.camel@buserror.net>
In-Reply-To: <4a9ea6b451683ec98c92e86a5ae6b91213a6afcf.camel@buserror.net>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgta2VybmVsLW93
bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsLQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5v
cmc+IE9uIEJlaGFsZiBPZiBTY290dCBXb29kDQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDI5
LCAyMDE4IDU6NDkgQU0NCj4gVG86IFZhYmhhdiBTaGFybWEgPHZhYmhhdi5zaGFybWFAbnhwLmNv
bT47IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgbGlu
dXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyBzYm95ZEBrZXJuZWwub3JnOw0K
PiByandAcmp3eXNvY2tpLm5ldDsgdmlyZXNoLmt1bWFyQGxpbmFyby5vcmc7IGxpbnV4LWNsa0B2
Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
LW93bmVyQHZnZXIua2VybmVsLm9yZzsNCj4gY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGwu
ZGVhY29uQGFybS5jb207DQo+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBhcm5kQGFybmRi
LmRlOw0KPiBrc3Rld2FydEBsaW51eGZvdW5kYXRpb24ub3JnOyB5YW1hZGEubWFzYWhpcm9Ac29j
aW9uZXh0LmNvbQ0KPiBDYzogWW9nZXNoIE5hcmF5YW4gR2F1ciA8eW9nZXNobmFyYXlhbi5nYXVy
QG54cC5jb20+OyBBbmR5IFRhbmcNCj4gPGFuZHkudGFuZ0BueHAuY29tPjsgVWRpdCBLdW1hciA8
dWRpdC5rdW1hckBueHAuY29tPjsNCj4gbGludXhAYXJtbGludXgub3JnLnVrOyBWYXJ1biBTZXRo
aSA8Vi5TZXRoaUBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNV0gZHJpdmVyczog
Y2xrLXFvcmlxOiBBZGQgY2xvY2tnZW4gc3VwcG9ydCBmb3IgbHgyMTYwYQ0KPiANCj4gT24gTW9u
LCAyMDE4LTA4LTIwIGF0IDEyOjE3ICswNTMwLCBWYWJoYXYgU2hhcm1hIHdyb3RlOg0KPiA+IEZy
b206IFlvZ2VzaCBHYXVyIDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT4NCj4gPg0KPiA+IEFk
ZCBjbG9ja2dlbiBzdXBwb3J0IGZvciBseDIxNjBhLg0KPiA+IEFkZGVkIGVudHJ5IGZvciBjb21w
YXQgJ2ZzbCxseDIxNjBhLWNsb2NrZ2VuJy4NCj4gPiBBcyBMWDIxNjBBIGlzIDE2IGNvcmUsIHNv
IG1vZGlmaWVkIHZhbHVlIGZvciBOVU1fQ01VWA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGFu
ZyBZdWFudGlhbiA8YW5keS50YW5nQG54cC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogWW9nZXNo
IEdhdXIgPHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFZh
YmhhdiBTaGFybWEgPHZhYmhhdi5zaGFybWFAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVy
cy9jbGsvY2xrLXFvcmlxLmMgICAgICAgICB8IDE0ICsrKysrKysrKysrKystDQo+ID4gIGRyaXZl
cnMvY3B1ZnJlcS9xb3JpcS1jcHVmcmVxLmMgfCAgMSArDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwg
MTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvY2xrL2Nsay1xb3JpcS5jIGIvZHJpdmVycy9jbGsvY2xrLXFvcmlxLmMgaW5kZXgNCj4g
PiAzYTE4MTJmLi5mYzZlMzA4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL2Nsay1xb3Jp
cS5jDQo+ID4gKysrIGIvZHJpdmVycy9jbGsvY2xrLXFvcmlxLmMNCj4gPiBAQCAtNjAsNyArNjAs
NyBAQCBzdHJ1Y3QgY2xvY2tnZW5fbXV4aW5mbyB7ICB9Ow0KPiA+DQo+ID4gICNkZWZpbmUgTlVN
X0hXQUNDRUwJNQ0KPiA+IC0jZGVmaW5lIE5VTV9DTVVYCTgNCj4gPiArI2RlZmluZSBOVU1fQ01V
WAkxNg0KPiA+DQo+ID4gIHN0cnVjdCBjbG9ja2dlbjsNCj4gPg0KPiA+IEBAIC01NzAsNiArNTcw
LDE3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgY2xvY2tnZW5fY2hpcGluZm8gY2hpcGluZm9bXSA9
IHsNCj4gPiAgCQkuZmxhZ3MgPSBDR19WRVIzIHwgQ0dfTElUVExFX0VORElBTiwNCj4gPiAgCX0s
DQo+ID4gIAl7DQo+ID4gKwkJLmNvbXBhdCA9ICJmc2wsbHgyMTYwYS1jbG9ja2dlbiIsDQo+ID4g
KwkJLmNtdXhfZ3JvdXBzID0gew0KPiA+ICsJCQkmY2xvY2tnZW4yX2NtdXhfY2dhMTIsICZjbG9j
a2dlbjJfY211eF9jZ2INCj4gPiArCQl9LA0KPiA+ICsJCS5jbXV4X3RvX2dyb3VwID0gew0KPiA+
ICsJCQkwLCAwLCAwLCAwLCAxLCAxLCAxLCAxLCAtMQ0KPiA+ICsJCX0sDQo+ID4gKwkJLnBsbF9t
YXNrID0gMHgzNywNCj4gPiArCQkuZmxhZ3MgPSBDR19WRVIzIHwgQ0dfTElUVExFX0VORElBTiwN
Cj4gPiArCX0sDQo+IA0KPiBXaHkgYXJlIHlvdSBpbmNyZWFzaW5nIE5VTV9DTVVYIGJleW9uZCA4
IGZvciBhIGNoaXAgdGhhdCBvbmx5IGhhcyA4DQo+IGVudHJpZXMgaW4gY211eF90b19ncm91cD8N
CkNvbmZpZ3VyYXRpb24gaXMgMTYgY29yZXMsOCBjbHVzdGVyIHdpdGggMiBjb3JlcyBpbiBlYWNo
IGNsdXN0ZXINCj4gDQo+IC1TY290dA0KDQo=
