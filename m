Return-Path: <Adam.Thomson.Opensource@diasemi.com>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlxgV5pZTzF0jM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 21:29:19 +1100 (AEDT)
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Joel Stanley
 <joel@jms.id.au>, Nicolas Ferre <nicolas.ferre@microchip.com>, "Alexandre
 Belloni" <alexandre.belloni@free-electrons.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden
 <sbranden@broadcom.com>, "bcm-kernel-feedback-list@broadcom.com"
 <bcm-kernel-feedback-list@broadcom.com>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>, Linus Walleij
 <linus.walleij@linaro.org>, Support Opensource
 <Support.Opensource@diasemi.com>, Baruch Siach <baruch@tkos.co.il>, "William
 Breathitt Gray" <vilhelm.gray@gmail.com>, Jimmy Vance <jimmy.vance@hpe.com>,
 Keguang Zhang <keguang.zhang@gmail.com>, Joachim Eastwood
 <manabian@gmail.com>, Tomas Winkler <tomas.winkler@intel.com>, "Johannes
 Thumshirn" <morbidrsa@gmail.com>, Andreas Werner <andreas.werner@men.de>,
 Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Wan ZongShun
 <mcuos.com@gmail.com>, Michal Simek <michal.simek@xilinx.com>, "Vladimir
 Zapolskiy" <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>,
 "Kukjin Kim" <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 "Zwane Mwaikambo" <zwanem@gmail.com>, Jim Cromie <jim.cromie@gmail.com>,
 Barry Song <baohua@kernel.org>, Patrice Chotard <patrice.chotard@st.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Marc
 Gonzalez <marc.w.gonzalez@free.fr>, Mans Rullgard <mans@mansr.com>, Thierry
 Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 "Masahiro Yamada" <yamada.masahiro@socionext.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie
 <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-rpi-kernel@lists.infradead.org"
 <linux-rpi-kernel@lists.infradead.org>,
 "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>, "linux-mips@linux-mips.org"
 <linux-mips@linux-mips.org>, "linux-amlogic@lists.infradead.org"
 <linux-amlogic@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org"
 <linux-samsung-soc@vger.kernel.org>, "linux-tegra@vger.kernel.org"
 <linux-tegra@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "patches@opensource.cirrus.com"
 <patches@opensource.cirrus.com>
Subject: RE: [PATCH] watchdog: add SPDX identifiers for watchdog subsystem
Date: Tue, 20 Feb 2018 10:29:12 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1C3ADA@SW-EX-MBX01.diasemi.com>
References: <20180220093119.23720-1-marcus.folkesson@gmail.com>
In-Reply-To: <20180220093119.23720-1-marcus.folkesson@gmail.com>
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

T24gMjAgRmVicnVhcnkgMjAxOCAwOTozMSwgTWFyY3VzIEZvbGtlc3NvbiB3cm90ZToNCg0KPiAt
IEFkZCBTUERYIGlkZW50aWZpZXINCj4gLSBSZW1vdmUgYm9pbGVyIHBsYXRlIGxpY2Vuc2UgdGV4
dA0KPiAtIElmIE1PRFVMRV9MSUNFTlNFIGFuZCBib2lsZXIgcGxhdGUgZG9lcyBub3QgbWF0Y2gs
IGdvIGZvciBib2lsZXIgcGxhdGUNCj4gICBsaWNlbnNlDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBN
YXJjdXMgRm9sa2Vzc29uIDxtYXJjdXMuZm9sa2Vzc29uQGdtYWlsLmNvbT4NCj4gLS0tDQoNClsu
Li5dDQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvd2F0Y2hkb2cvZGE5MDUyX3dkdC5jIGIvZHJp
dmVycy93YXRjaGRvZy9kYTkwNTJfd2R0LmMNCj4gaW5kZXggZDZkNTAwNmVmYTcxLi5lMjYzYmFk
OTk1NzQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvd2F0Y2hkb2cvZGE5MDUyX3dkdC5jDQo+ICsr
KyBiL2RyaXZlcnMvd2F0Y2hkb2cvZGE5MDUyX3dkdC5jDQo+IEBAIC0xLDMgKzEsNCBAQA0KPiAr
Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArDQo+ICAvKg0KPiAgICogU3lzdGVt
IG1vbml0b3JpbmcgZHJpdmVyIGZvciBEQTkwNTIgUE1JQ3MuDQo+ICAgKg0KPiBAQCAtNSwxMSAr
Niw2IEBADQo+ICAgKg0KPiAgICogQXV0aG9yOiBBbnRob255IE9sZWNoIDxBbnRob255Lk9sZWNo
QGRpYXNlbWkuY29tPg0KPiAgICoNCj4gLSAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJl
OyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5DQo+IC0gKiBpdCB1bmRlciB0
aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBi
eQ0KPiAtICogdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBv
ZiB0aGUgTGljZW5zZSwgb3INCj4gLSAqIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNp
b24uDQo+IC0gKg0KPiAgICovDQo+IA0KPiAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy93YXRjaGRvZy9kYTkwNTVfd2R0LmMgYi9kcml2ZXJzL3dhdGNo
ZG9nL2RhOTA1NV93ZHQuYw0KPiBpbmRleCA1MGJkZDEwMjIxODYuLjI2YTViMjk4NDA5NCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy93YXRjaGRvZy9kYTkwNTVfd2R0LmMNCj4gKysrIGIvZHJpdmVy
cy93YXRjaGRvZy9kYTkwNTVfd2R0LmMNCj4gQEAgLTEsMyArMSw0IEBADQo+ICsvLyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsNCj4gIC8qDQo+ICAgKiBTeXN0ZW0gbW9uaXRvcmlu
ZyBkcml2ZXIgZm9yIERBOTA1NSBQTUlDcy4NCj4gICAqDQo+IEBAIC01LDExICs2LDYgQEANCj4g
ICAqDQo+ICAgKiBBdXRob3I6IERhdmlkIERhanVuIENoZW4gPGRjaGVuQGRpYXNlbWkuY29tPg0K
PiAgICoNCj4gLSAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlz
dHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5DQo+IC0gKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhl
IEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQ0KPiAtICogdGhlIEZy
ZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwg
b3INCj4gLSAqIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uDQo+IC0gKg0KPiAg
ICovDQo+IA0KPiAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy93YXRjaGRvZy9kYTkwNjJfd2R0LmMgYi9kcml2ZXJzL3dhdGNoZG9nL2RhOTA2Ml93ZHQu
Yw0KPiBpbmRleCA4MTRkZmY2MDQ1YTQuLmEwMDE3ODJiYmZkYiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy93YXRjaGRvZy9kYTkwNjJfd2R0LmMNCj4gKysrIGIvZHJpdmVycy93YXRjaGRvZy9kYTkw
NjJfd2R0LmMNCj4gQEAgLTEsMTYgKzEsOCBAQA0KPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjArDQo+ICAvKg0KPiAgICogV2F0Y2hkb2cgZGV2aWNlIGRyaXZlciBmb3IgREE5
MDYyIGFuZCBEQTkwNjEgUE1JQ3MNCj4gICAqIENvcHlyaWdodCAoQykgMjAxNSAgRGlhbG9nIFNl
bWljb25kdWN0b3IgTHRkLg0KPiAgICoNCj4gLSAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3
YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3INCj4gLSAqIG1vZGlmeSBpdCB1bmRl
ciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlDQo+IC0gKiBhcyBw
dWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24g
Mg0KPiAtICogb2YgdGhlIExpY2Vuc2UsIG9yIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZl
cnNpb24uDQo+IC0gKg0KPiAtICogVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBo
b3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsDQo+IC0gKiBidXQgV0lUSE9VVCBBTlkgV0FSUkFO
VFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZg0KPiAtICogTUVSQ0hBTlRB
QklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQ0KPiAt
ICogR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4NCj4gICAqLw0K
PiANCj4gICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
d2F0Y2hkb2cvZGE5MDYzX3dkdC5jIGIvZHJpdmVycy93YXRjaGRvZy9kYTkwNjNfd2R0LmMNCj4g
aW5kZXggMmEyMGZjMTYzZWQwLi5iMTdhYzFiYjFmMjggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
d2F0Y2hkb2cvZGE5MDYzX3dkdC5jDQo+ICsrKyBiL2RyaXZlcnMvd2F0Y2hkb2cvZGE5MDYzX3dk
dC5jDQo+IEBAIC0xLDMgKzEsNCBAQA0KPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQ
TC0yLjArDQo+ICAvKg0KPiAgICogV2F0Y2hkb2cgZHJpdmVyIGZvciBEQTkwNjMgUE1JQ3MuDQo+
ICAgKg0KPiBAQCAtNSwxMCArNiw2IEBADQo+ICAgKg0KPiAgICogQXV0aG9yOiBNYXJpdXN6IFdv
anRhc2lrIDxtYXJpdXN6LndvanRhc2lrQGRpYXNlbWkuY29tPg0KPiAgICoNCj4gLSAqIFRoaXMg
cHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSAgaXQgYW5kL29y
IG1vZGlmeSBpdA0KPiAtICogdW5kZXIgIHRoZSB0ZXJtcyBvZiAgdGhlIEdOVSBHZW5lcmFsICBQ
dWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkgdGhlDQo+IC0gKiBGcmVlIFNvZnR3YXJlIEZv
dW5kYXRpb247ICBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSAgTGljZW5zZSwgb3IgKGF0IHlvdXIN
Cj4gLSAqIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uDQo+ICAgKi8NCg0KRm9yIERpYWxvZyBk
cml2ZXJzLA0KDQpBY2tlZC1ieTogQWRhbSBUaG9tc29uIDxBZGFtLlRob21zb24uT3BlbnNvdXJj
ZUBkaWFzZW1pLmNvbT4NCg==
