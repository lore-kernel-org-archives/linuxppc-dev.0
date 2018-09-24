Return-Path: <vabhav.sharma@nxp.com>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0079.outbound.protection.outlook.com [104.47.0.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42JjN33rMBzF1S0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 21:56:16 +1000 (AEST)
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: Scott Wood <oss@buserror.net>, "sudeep.holla@arm.com"
 <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org"
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
CC: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, Yogesh Narayan Gaur
 <yogeshnarayan.gaur@nxp.com>, Andy Tang <andy.tang@nxp.com>
Subject: RE: [PATCH v2 3/5] drivers: clk-qoriq: Add clockgen support for
 lx2160a
Date: Mon, 24 Sep 2018 11:56:08 +0000
Message-ID: <VI1PR04MB4800CA1AFEB6EB7B56680CBBF3170@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <1536871075-3732-1-git-send-email-vabhav.sharma@nxp.com>
 <1536871075-3732-4-git-send-email-vabhav.sharma@nxp.com>
 <4fa10f679ad4b1b619daa521a8641c145cf8537e.camel@buserror.net>
In-Reply-To: <4fa10f679ad4b1b619daa521a8641c145cf8537e.camel@buserror.net>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2NvdHQgV29vZCA8b3Nz
QGJ1c2Vycm9yLm5ldD4NCj4gU2VudDogU3VuZGF5LCBTZXB0ZW1iZXIgMTYsIDIwMTggMTI6NTQg
QU0NCj4gVG86IFZhYmhhdiBTaGFybWEgPHZhYmhhdi5zaGFybWFAbnhwLmNvbT47IHN1ZGVlcC5o
b2xsYUBhcm0uY29tOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gbWFyay5ydXRsYW5kQGFy
bS5jb207IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBsaW51eC1hcm0tDQo+IGtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnOyBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsgc2JveWRAa2Vy
bmVsLm9yZzsNCj4gcmp3QHJqd3lzb2NraS5uZXQ7IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOyBs
aW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gcG1Admdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWwtb3duZXJAdmdlci5rZXJuZWwub3JnOw0KPiBjYXRhbGluLm1hcmluYXNAYXJt
LmNvbTsgd2lsbC5kZWFjb25AYXJtLmNvbTsNCj4gZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7
IGFybmRAYXJuZGIuZGU7IGtzdGV3YXJ0QGxpbnV4Zm91bmRhdGlvbi5vcmc7DQo+IHlhbWFkYS5t
YXNhaGlyb0Bzb2Npb25leHQuY29tDQo+IENjOiBsaW51eEBhcm1saW51eC5vcmcudWs7IFZhcnVu
IFNldGhpIDxWLlNldGhpQG54cC5jb20+OyBVZGl0IEt1bWFyDQo+IDx1ZGl0Lmt1bWFyQG54cC5j
b20+OyBZb2dlc2ggTmFyYXlhbiBHYXVyDQo+IDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT47
IEFuZHkgVGFuZyA8YW5keS50YW5nQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIg
My81XSBkcml2ZXJzOiBjbGstcW9yaXE6IEFkZCBjbG9ja2dlbiBzdXBwb3J0IGZvciBseDIxNjBh
DQo+IA0KPiBPbiBGcmksIDIwMTgtMDktMTQgYXQgMDI6MDcgKzA1MzAsIFZhYmhhdiBTaGFybWEg
d3JvdGU6DQo+ID4gRnJvbTogWW9nZXNoIEdhdXIgPHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29t
Pg0KPiA+DQo+ID4gQWRkIGNsb2NrZ2VuIHN1cHBvcnQgZm9yIGx4MjE2MGEuDQo+ID4gQWRkZWQg
ZW50cnkgZm9yIGNvbXBhdCAnZnNsLGx4MjE2MGEtY2xvY2tnZW4nLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogVGFuZyBZdWFudGlhbiA8YW5keS50YW5nQG54cC5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogWW9nZXNoIEdhdXIgPHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFZhYmhhdiBTaGFybWEgPHZhYmhhdi5zaGFybWFAbnhwLmNvbT4NCj4gPiBBY2tl
ZC1ieTogU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPg0KPiA+IC0tLQ0KPiA+ICBkcml2
ZXJzL2Nsay9jbGstcW9yaXEuYyAgICAgICAgIHwgMTQgKysrKysrKysrKysrKy0NCj4gPiAgZHJp
dmVycy9jcHVmcmVxL3FvcmlxLWNwdWZyZXEuYyB8ICAxICsNCj4gPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAxNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9jbGsvY2xrLXFvcmlxLmMgYi9kcml2ZXJzL2Nsay9jbGstcW9yaXEuYyBpbmRleA0K
PiA+IDNhMTgxMmYuLmU5YWU3MGIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jbGsvY2xrLXFv
cmlxLmMNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9jbGstcW9yaXEuYw0KPiA+IEBAIC03OSw3ICs3
OSw3IEBAIHN0cnVjdCBjbG9ja2dlbl9jaGlwaW5mbyB7DQo+ID4gIAljb25zdCBzdHJ1Y3QgY2xv
Y2tnZW5fbXV4aW5mbyAqY211eF9ncm91cHNbMl07DQo+ID4gIAljb25zdCBzdHJ1Y3QgY2xvY2tn
ZW5fbXV4aW5mbyAqaHdhY2NlbFtOVU1fSFdBQ0NFTF07DQo+ID4gIAl2b2lkICgqaW5pdF9wZXJp
cGgpKHN0cnVjdCBjbG9ja2dlbiAqY2cpOw0KPiA+IC0JaW50IGNtdXhfdG9fZ3JvdXBbTlVNX0NN
VVhdOyAvKiAtMSB0ZXJtaW5hdGVzIGlmIGZld2VyIHRoYW4NCj4gPiBOVU1fQ01VWCAqLw0KPiA+
ICsJaW50IGNtdXhfdG9fZ3JvdXBbTlVNX0NNVVgrMV07IC8qIC0xIHRlcm1pbmF0ZSBpZiBmZXdl
ciB0bw0KPiA+IE5VTV9DTVVYKzEgKi8NCj4gDQo+IFlvdSBuZWVkIHRvIGFkZCB0aGUgLTEgdGVy
bWluYXRvciB0byBwNDA4MCwgYW5kIHJlbW92ZSB0aGUgImlmIGZld2VyIg0KPiBjb21tZW50IHNp
bmNlIHRoZSB3aG9sZSBwb2ludCBvZiB0aGlzIGlzIHRoYXQgZXZlcnkgYXJyYXkgZ2V0cyAtMSB0
ZXJtaW5hdGVkLg0KT2ssIFVwZGF0ZWQNCj4gDQo+IFdoeSBkaWQgeW91IGNoYW5nZSAidGVybWlu
YXRlcyIgdG8gInRlcm1pbmF0ZSIgYW5kICJ0aGFuIiB0byAidG8iPw0KPiANCj4gVGhpcyArMSBj
aGFuZ2Ugc2hvdWxkIGJlIGEgc2VwYXJhdGUgcGF0Y2ggZnJvbSBseDIxNjBhIHN1cHBvcnQuDQpT
dXJlLCBTZW5kaW5nIGFzIHNlcGFyYXRlIHBhdGNoDQo+IA0KPiAtU2NvdHQNCg0K
