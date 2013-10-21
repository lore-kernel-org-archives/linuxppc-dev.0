Return-Path: <B47053@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 97C6B2C025E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Oct 2013 15:15:50 +1100 (EST)
From: Xiubo Li-B47053 <B47053@freescale.com>
To: =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>
Subject: RE: [PATCHv1 5/8] ASoC: sgtl5000: Revise the bugs about the
 sgt15000 codec.
Date: Mon, 21 Oct 2013 04:15:12 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F82866756@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-6-git-send-email-Li.Xiubo@freescale.com>
 <20131017121721.43e1b34b@ipc1.ka-ro>
In-Reply-To: <20131017121721.43e1b34b@ipc1.ka-ro>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "tiwai@suse.de" <tiwai@suse.de>, Wang Huan-B18965 <B18965@freescale.com>,
 "timur@tabi.org" <timur@tabi.org>, "perex@perex.cz" <perex@perex.cz>,
 Guo Shawn-R65073 <r65073@freescale.com>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 Chen Guangyu-B42378 <B42378@freescale.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "oskar@scara.com" <oskar@scara.com>,
 Estevam Fabio-R49496 <r49496@freescale.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob@landley.net" <rob@landley.net>,
 Jin Zhengxiong-R64188 <R64188@freescale.com>,
 "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiA+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmMgYi9zb3VuZC9zb2Mv
Y29kZWNzL3NndGw1MDAwLmMNCj4gPiBpbmRleCAxZjQwOTNmLi40ZTJlNGM5IDEwMDY0NA0KPiA+
IC0tLSBhL3NvdW5kL3NvYy9jb2RlY3Mvc2d0bDUwMDAuYw0KPiA+ICsrKyBiL3NvdW5kL3NvYy9j
b2RlY3Mvc2d0bDUwMDAuYw0KPiA+IEBAIC04ODMsMTQgKzg4MywxOSBAQCBzdGF0aWMgaW50IGxk
b19yZWd1bGF0b3JfcmVnaXN0ZXIoc3RydWN0DQo+IHNuZF9zb2NfY29kZWMgKmNvZGVjLA0KPiA+
ICAJCQkJc3RydWN0IHJlZ3VsYXRvcl9pbml0X2RhdGEgKmluaXRfZGF0YSwNCj4gPiAgCQkJCWlu
dCB2b2x0YWdlKQ0KPiA+ICB7DQo+ID4gKyNpZmRlZiBDT05GSUdfU05EX1NPQ19GU0xfU0dUTDUw
MDANCj4gPiArCXJldHVybiAwOw0KPiA+ICsjZWxzZQ0KPiA+ICAJZGV2X2Vycihjb2RlYy0+ZGV2
LCAidGhpcyBzZXR1cCBuZWVkcyByZWd1bGF0b3Igc3VwcG9ydCBpbiB0aGUNCj4ga2VybmVsXG4i
KTsNCj4gPiAgCXJldHVybiAtRUlOVkFMOw0KPiA+ICsjZW5kaWYNCj4gPg0KPiBUaGlzIGxvb2tz
IHdyb25nIHRvIG1lLCBhcyB0aGlzIHdpbGwgZGlzYWJsZSB0aGUgZXJyb3IgZm9yIHVuc29saWNp
dGVkDQo+IHBsYXRmb3JtcyBpbiBhIG11bHRpIGFyY2gga2VybmVsIQ0KPiANCg0KVGhlIENPTkZJ
R19TTkRfU09DX0ZTTF9TR1RMNTAwMCBtaWNybyB3aWxsIGJlIHJlbmFtZWQgdG8gQ09ORklHX1NO
RF9TT0NfRlNMX1NHVEw1MDAwX1ZGNjEwLg0KSW4gVkY2MTAsIHRoZXJlIGhhcyBub3QgUG93ZXIg
TWFuYWdlciBNb2R1bGUsIHNvIHdoZXRoZXIgdGhlIENPTkZJR19SRUdVTEFUT1IgaXMgZW5hYmxl
IG9yIA0KRGlzYWJsZWQsIHRoZXJlIHdpbGwgYWx3YXlzIHNvbWUgZXJyb3JzIGJvb3RpbmcuLi4N
Cg0KDQo+ID4gIHN0YXRpYyBpbnQgbGRvX3JlZ3VsYXRvcl9yZW1vdmUoc3RydWN0IHNuZF9zb2Nf
Y29kZWMgKmNvZGVjKSAgew0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPiArDQo+ID4gICNl
bmRpZg0KPiA+DQo+IFdoeSBkbyB5b3UgYWRkIGFuIGV4dHJhIGVtcHR5IGxpbmUgaGVyZT8NCj4g
DQoNClRoaXMgd2lsbCBiZSByZW1vdmUgbGF0ZXIuDQoNCg0K
