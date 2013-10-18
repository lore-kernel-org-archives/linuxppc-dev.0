Return-Path: <B47053@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C885E2C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2013 14:27:15 +1100 (EST)
From: Xiubo Li-B47053 <B47053@freescale.com>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: RE: [PATCHv1 8/8] Documentation: Add device tree bindings for
 Freescale VF610 sound.
Date: Fri, 18 Oct 2013 03:27:03 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F82865447@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-9-git-send-email-Li.Xiubo@freescale.com>
 <1382003190.4093.38.camel@weser.hi.pengutronix.de>
In-Reply-To: <1382003190.4093.38.camel@weser.hi.pengutronix.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "tiwai@suse.de" <tiwai@suse.de>, Wang Huan-B18965 <B18965@freescale.com>,
 "timur@tabi.org" <timur@tabi.org>, "perex@perex.cz" <perex@perex.cz>,
 Guo Shawn-R65073 <r65073@freescale.com>,
 "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 Chen Guangyu-B42378 <B42378@freescale.com>,
 "oskar@scara.com" <oskar@scara.com>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
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

SGksDQoNCg0KDQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL2Zz
bC1zZ3RsNTAwMC50eHQNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3Mvc291bmQvZnNsLXNndGw1MDAwLnR4dA0KPiA+IGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL2ZzbC1zZ3RsNTAwMC50eHQNCj4gPiBuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAuLjQzZTM1MGYNCj4gPiAtLS0gL2Rldi9u
dWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL2Zz
bC1zZ3RsNTAwMC50eHQNCj4gDQo+IFRoaXMgZG9jdW1lbnQgbmFtZSBpcyBvdmVybHkgZ2VuZXJp
YywgdGhlcmUgYXJlIG1vcmUgdGhhbiBvbmUgRlNMDQo+IHBsYXRmb3JtcyB3aXRoIFNHVEw1MDAw
IGNvZGVjcy4gUGxlYXNlIGluY2x1ZGUgdGhlIHZmNjEwIGhlcmUuDQo+IA0KDQpZZXMsIGl0IGlz
Lg0KDQpUaGlzIHdpbGwgYmUgcmVuYW1lZCB0byAiZnNsX3ZmNjEwX2F1ZGlvX3NndDE1MDAwLnR4
dCIgb3Igb3RoZXJzLg0KDQoNClRoYW5rcywNCi0tDQpCUlMsDQpYaXVibw0K
