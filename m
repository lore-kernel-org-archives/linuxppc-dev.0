Return-Path: <Jason.Jin@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0187.outbound.protection.outlook.com [207.46.163.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E1D7214008C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Apr 2014 11:23:05 +1100 (EST)
From: "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH 2/2] Make the diu driver work without board level
 initilization
Date: Wed, 2 Apr 2014 00:22:58 +0000
Message-ID: <7c1942cca80d410280e693e7890d74e6@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1395920287-5204-1-git-send-email-Jason.Jin@freescale.com>
 <1305603ae9b846d9bc4c78f21a8c0494@BY2PR03MB505.namprd03.prod.outlook.com>
 <57b9d96d00f64eff90ae6c109c9dec90@BLUPR03MB373.namprd03.prod.outlook.com>
 <1396388317.32034.14.camel@snotra.buserror.net>
In-Reply-To: <1396388317.32034.14.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "timur@tabi.org" <timur@tabi.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQo+ID4gVGhhbmtzLCBUaGlzIGhhcyBiZWVuIGZpeGVkIGluIHRoZSB1cGRhdGUgdmVyc2lvbiwg
cGxlYXNlIGhlbHAgdG8NCj4gcmV2aWV3IGl0IGF0Og0KPiA+IGh0dHA6Ly9wYXRjaHdvcmsub3ps
YWJzLm9yZy9wYXRjaC8zMzUyMjUvDQo+ID4gSSBmb3Jnb3QgdG8gYWRkIHRoZSBWMiBpbmZvcm1h
dGlvbiBpbiB0aGUgc3ViamVjdCBpbiB0aGUgdXBkYXRlIHBhdGNoDQo+IHNvIHRoaXMgbWF5IGNv
bmZ1c2UgdGhlIHJldmlld2VyLCBzb3JyeSBmb3IgdGhhdC4NCj4gDQo+IEl0IGlzIG5vdCBmaXhl
ZCBpbiB0aGF0IHBhdGNoIChvciBkaWQgeW91IGxpbmsgdGhlIHdyb25nIHZlcnNpb24/KS4gIFlv
dQ0KPiBzaG91bGQgbmV2ZXIgdXNlIFwgdG8gY29udGludWUgYSBsaW5lIGluIEMsIG90aGVyIHRo
YW4gaW4gbWFjcm9zLg0KPiANCj4gRnVydGhlciwgaXQgaXMgbm90IHBlcm1pdHRlZCB0byB3cmFw
IGtlcm5lbCBvdXRwdXQgc3RyaW5ncy4gIFRoaXMgaXMgYW4NCj4gZXhjZXB0aW9uIHRvIHRoZSA4
MC1jb2x1bW4gcnVsZS4gIENoZWNrcGF0Y2ggc2hvdWxkIGhhdmUgdG9sZCB5b3UgdGhpcy4NCltK
YXNvbiBKaW4tUjY0MTg4XSBUaGFua3MgZm9yIHBvaW50aW5nIG91dCB0aGlzLCBJIGNvbmZ1c2Vk
IHRoZSBpbnRlcm5hbCB2ZXJzaW9uIGFuZCBleHRlcm5hbCB2ZXJzaW9uLiBJJ2xsIGZpeCBpdCBp
biBuZXh0IHZlcnNpb24uIFRoYW5rcy4NCg==
