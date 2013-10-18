Return-Path: <B47053@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6CEAD2C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2013 14:19:54 +1100 (EST)
From: Xiubo Li-B47053 <B47053@freescale.com>
To: =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>
Subject: RE: [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
Date: Fri, 18 Oct 2013 03:19:42 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F82865423@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <20131017114208.595a4224@ipc1.ka-ro>
In-Reply-To: <20131017114208.595a4224@ipc1.ka-ro>
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

SGksDQoNCj4gPiArCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNF
X01FTSwgMCk7DQo+ID4gKwlzYWktPmJhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoJnBkZXYt
PmRldiwgcmVzKTsNCj4gPiArCWlmIChJU19FUlIoc2FpLT5iYXNlKSkgew0KPiA+ICsJCXJldCA9
IFBUUl9FUlIoc2FpLT5iYXNlKTsNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+DQo+IGNvdWxkIGJl
Og0KPiAJCXJldHVybiBQVFJfRVJSKHNhaS0+YmFzZSk7DQo+DQoNClllc++8jFRoaXMgbG9va3Mg
YmV0dGVyLg0KDQogDQo+ID4gKyNkZWZpbmUgRlNMX1NBSV9ETUFCVUZfU0laRQkoMzIgKiAxMDI0
KQ0KPiA+ICsjZGVmaW5lIFRDRF9OVU1CRVIJCTQNCj4gPiArI2RlZmluZSBFRE1BX1BSSU9fSElH
SCAgICAgICAgICA2DQo+ID4gKw0KPiBzdHJhbmdlIGluZGVudGF0aW9uIHdpdGggbWl4ZWQgc3Bh
Y2VzIGFuZCB0YWJzLg0KPiANCg0KVGhpcyB3aWxsIGJlIHJldmlzZWQgaW4gdGhlIG5leHQgdmVy
c2lvbi4NCg0KDQoNCj4gPiArI2RlZmluZSBTQUlfQ1IyX01TRUxfTUNMSzMJKEJJVCgyNil8QklU
KDI3KSkNCj4gPg0KPiBzcGFjZXMgYXJvdW5kICd8Jz8NCj4gDQoNCkFuZCB0aGlzIHRvby4NCg0K
DQoNCg0KLS0NCkJSUywNClhpdWJvDQo=
