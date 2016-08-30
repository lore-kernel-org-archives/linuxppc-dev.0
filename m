Return-Path: <wente.wang@nxp.com>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00064.outbound.protection.outlook.com [40.107.0.64])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sNnth0ZS2zDqXr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 22:31:06 +1000 (AEST)
From: Wente Wang <wente.wang@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 0/2] Support non-ssi cpu-dai for sgtl5000
Date: Tue, 30 Aug 2016 12:31:00 +0000
Message-ID: <AM3PR04MB5299DB1A46C9EB79B5131BA8FE00@AM3PR04MB529.eurprd04.prod.outlook.com>
References: <1472467915-21317-1-git-send-email-wente.wang@nxp.com>
 <CAOMZO5B3FDPxm301Hwb+ZVOwYDAMU0vjcVAG0hH36Rf2+s0VDA@mail.gmail.com>
In-Reply-To: <CAOMZO5B3FDPxm301Hwb+ZVOwYDAMU0vjcVAG0hH36Rf2+s0VDA@mail.gmail.com>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIFttYWls
dG86ZmVzdGV2YW1AZ21haWwuY29tXQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAvMl0gU3VwcG9y
dCBub24tc3NpIGNwdS1kYWkgZm9yIHNndGw1MDAwDQo+IA0KPiBPbiBNb24sIEF1ZyAyOSwgMjAx
NiBhdCA3OjUxIEFNLCBXaW50ZXIgV2FuZyA8d2VudGUud2FuZ0BueHAuY29tPiB3cm90ZToNCj4g
PiBUaGVzZSBwYXRjaGVzIHN1cHBvcnQgc2d0bDUwMDAgdG8gYmUgYXR0YWNoZWQgdG8gb3RoZXIg
bm9uLXNzaSBjcHUtZGFpcw0KPiBsaWtlIFNBSS4NCj4gDQo+IERvIHdlIHJlYWxseSBuZWVkIHRo
aXM/DQo+IA0KPiBXZSBjYW4gdXNlIFNBSSB3aXRoIHNndGw1MDAwIGp1c3QgZmluZSB2aWEgc2lt
cGxlIGNhcmQuIFRha2UgYSBsb29rIGF0Og0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL2NnaXQv
bGludXgva2VybmVsL2dpdC9zaGF3bmd1by9saW51eC5naXQvY29tbWl0L2FyY2gvDQo+IGFybS9i
b290L2R0cy9pbXg2dWwtMTR4MTQtDQo+IGV2ay5kdHM/aD1pbXgvZml4ZXMmaWQ9YmYzMjUxZTEx
MmEwMTM5YzhkZWM3OTZjOWYxMmYyZThmMDFhNzNjYQ0KDQpUaGFua3MsIHRoYXQncyBhbm90aGVy
IGFwcHJvYWNoLiANClRoaXMgcGF0Y2ggc2V0IGlzIG5vdCBuZWVkZWQuDQo=
