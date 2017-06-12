Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmbdc67xQzDqL2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 00:59:15 +1000 (AEST)
Date: Mon, 12 Jun 2017 10:59:05 -0400 (EDT)
Message-Id: <20170612.105905.1031273319008486521.davem@davemloft.net>
To: yuval.shaia@oracle.com
Cc: michael.chan@broadcom.com, f.fainelli@gmail.com,
 siva.kallam@broadcom.com, prashant@broadcom.com, madalin.bucur@nxp.com,
 leoli@freescale.com, sebastian.hesselbarth@gmail.com,
 sergei.shtylyov@cogentembedded.com, grygorii.strashko@ti.com,
 w-kwok2@ti.com, m-karicheri2@ti.com, andrew@lunn.ch,
 woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
 vivien.didelot@savoirfairelinux.com, arnd@arndb.de, tremyfr@gmail.com,
 jarod@redhat.com, horms+renesas@verge.net.au,
 kazuya.mizuguchi.ks@renesas.com, dan.carpenter@oracle.com,
 niklas.soderlund+renesas@ragnatech.se, johan@kernel.org,
 masaru.nagai.vx@renesas.com, geert+renesas@glider.be,
 laurent.pinchart@ideasonboard.com, chris.brandt@renesas.com,
 ivan.khoronzhuk@linaro.org, mugunthanvnm@ti.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] net: phy: Make phy_ethtool_ksettings_get return void
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170612.102525.1159274040679939960.davem@davemloft.net>
References: <20170612141508.29229-1-yuval.shaia@oracle.com>
 <20170612.102525.1159274040679939960.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogRGF2aWQgTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0Pg0KRGF0ZTogTW9uLCAxMiBK
dW4gMjAxNyAxMDoyNToyNSAtMDQwMCAoRURUKQ0KDQo+IEZyb206IFl1dmFsIFNoYWlhIDx5dXZh
bC5zaGFpYUBvcmFjbGUuY29tPg0KPiBEYXRlOiBNb24sIDEyIEp1biAyMDE3IDE3OjE1OjA4ICsw
MzAwDQo+IA0KPj4gTWFrZSByZXR1cm4gdmFsdWUgdm9pZCBzaW5jZSBmdW5jdGlvbiBuZXZlciBy
ZXR1cm4gbWVhbmluZ2Z1bGwgdmFsdWUNCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogWXV2YWwgU2hh
aWEgPHl1dmFsLnNoYWlhQG9yYWNsZS5jb20+DQo+PiBBY2tlZC1ieTogU2VyZ2VpIFNodHlseW92
IDxzZXJnZWkuc2h0eWx5b3ZAY29nZW50ZW1iZWRkZWQuY29tPg0KPj4gLS0tDQo+PiB2MCAtPnYx
Og0KPj4gCSogVGhlc2UgZmlsZXMgd2VyZSBtaXNzaW5nIGluIHYwDQo+PiAJCSogZHJpdmVycy9u
ZXQvZXRoZXJuZXQvcmVuZXNhcy9yYXZiX21haW4uYw0KPj4gCQkqIGRyaXZlcnMvbmV0L2V0aGVy
bmV0L3JlbmVzYXMvc2hfZXRoLmMNCj4+IAkJKiBkcml2ZXJzL25ldC9ldGhlcm5ldC90aS9uZXRj
cF9ldGhzcy5jDQo+PiAJKiBBZGQgQWNrZWQtYnk6IFNlcmdlaSBTaHR5bHlvdg0KPj4gdjEgLT4g
djI6DQo+PiAJKiBBZGp1c3QgdG8gbmV0LW5leHQgdHJlZQ0KPiANCj4gQXBwbGllZCwgdGhhbmsg
eW91Lg0KDQpSZXZlcnRlZCwgcGxlYXNlIHRlc3QgeW91ciBidWlsZCBwcm9wZXJseToNCg0KZHJp
dmVycy9uZXQvZXRoZXJuZXQvYXBtL3hnZW5lL3hnZW5lX2VuZXRfZXRodG9vbC5jOiBJbiBmdW5j
dGlvbiCheGdlbmVfZ2V0X2xpbmtfa3NldHRpbmdzojoNCmRyaXZlcnMvbmV0L2V0aGVybmV0L2Fw
bS94Z2VuZS94Z2VuZV9lbmV0X2V0aHRvb2wuYzoxMzQ6MTA6IGVycm9yOiB2b2lkIHZhbHVlIG5v
dCBpZ25vcmVkIGFzIGl0IG91Z2h0IHRvIGJlDQogICByZXR1cm4gcGh5X2V0aHRvb2xfa3NldHRp
bmdzX2dldChwaHlkZXYsIGNtZCk7DQogICAgICAgICAgXg0KZHJpdmVycy9uZXQvZXRoZXJuZXQv
YXBtL3hnZW5lL3hnZW5lX2VuZXRfZXRodG9vbC5jOjE0MDoxMTogZXJyb3I6IHZvaWQgdmFsdWUg
bm90IGlnbm9yZWQgYXMgaXQgb3VnaHQgdG8gYmUNCiAgICByZXR1cm4gcGh5X2V0aHRvb2xfa3Nl
dHRpbmdzX2dldChwaHlkZXYsIGNtZCk7DQogICAgICAgICAgIF4NCnNjcmlwdHMvTWFrZWZpbGUu
YnVpbGQ6MzAyOiByZWNpcGUgZm9yIHRhcmdldCAnZHJpdmVycy9uZXQvZXRoZXJuZXQvYXBtL3hn
ZW5lL3hnZW5lX2VuZXRfZXRodG9vbC5vJyBmYWlsZWQNCg==
