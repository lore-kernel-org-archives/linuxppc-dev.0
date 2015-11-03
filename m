Return-Path: <raghav@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0107.outbound.protection.outlook.com [65.55.169.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0EDF01A01CB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 17:49:58 +1100 (AEDT)
From: Dogra Raghav <raghav@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: Kushwaha Prabhakar <prabhakar@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 1/2] mpc85xx/lbc: modify suspend/resume entry sequence
Date: Tue, 3 Nov 2015 06:33:56 +0000
Message-ID: <BY2PR0301MB07750650283AD03A00191EDFD22B0@BY2PR0301MB0775.namprd03.prod.outlook.com>
References: <1446186299-2921-1-git-send-email-raghav@freescale.com>
 <BY2PR0301MB0775A3A01F8585352ED5EFADD22C0@BY2PR0301MB0775.namprd03.prod.outlook.com>
 <1446505257.22185.43.camel@freescale.com>
 <BY2PR0301MB077529F563722A726BC39804D22B0@BY2PR0301MB0775.namprd03.prod.outlook.com>
 <1446529190.22185.51.camel@freescale.com>
 <BY2PR0301MB0775900A89741E58FA3822D9D22B0@BY2PR0301MB0775.namprd03.prod.outlook.com>
 <1446531228.22185.60.camel@freescale.com>
In-Reply-To: <1446531228.22185.60.camel@freescale.com>
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

DQpIaSBTY290dCwNCg0KSSBqdXN0IGNoZWNrZWQgb24gcGF0Y2h3b3JrIGFuZCBub3RpY2VkIHRo
YXQgdGhlIG9yaWdpbmFsIHBhdGNoIGhhcyBiZWVuIG1vZGlmaWVkIGFzIHNvbWVob3cgbXkgb3Jp
Z2luYWwgY29tbWVudCBoYXMgYmVjb21lIHBhcnQgb2YgdGhlIHBhdGNoOg0KKwlpZiAoIWxiYykN
CisJCWdvdG8gb3V0Ow0KIA0KIAljdHJsLT5zYXZlZF9yZWdzID0ga21hbGxvYyhzaXplb2Yoc3Ry
dWN0IGZzbF9sYmNfcmVncyksIEdGUF9LRVJORUwpOw0KIAlpZiAoIWN0cmwtPnNhdmVkX3JlZ3Mp
DQogCQlyZXR1cm4gLUVOT01FTTsNCltEb2dyYSBSYWdoYXYtQjQ2MTg0XSBUaGlzIGlzIHRoZSBl
eGlzdGluZyB1cHN0cmVhbSBjb2RlLiBBcmUgeW91IHN1Z2dlc3RpbmcgdG8gbW9kaWZ5IHRoZSB1
cHN0cmVhbSBjb2RlIHRvIHRha2UgY2FyZSBvZiBpbmRpdmlkdWFsIHJlZ2lzdGVycz8NCiANCiAJ
X21lbWNweV9mcm9taW8oY3RybC0+c2F2ZWRfcmVncywgbGJjLCBzaXplb2Yoc3RydWN0IGZzbF9s
YmNfcmVncykpOw0KKw0KVGhlIHBhdGNod29yayBpcyBhbHNvIHNob3dpbmcgdHdvIGxpbmtzIGZv
ciB0aGUgcGF0Y2guIFBsZWFzZSBhcHBseSB0aGUgb3JpZ2luYWwgcGF0Y2ggcHJlc2VudCBhdDoN
Cmh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcGF0Y2gvNTM4NjA1Lw0KDQpJIHdpbGwgbG9v
ayBpbnRvIGhvdyB0aGlzIGhhcHBlbmVkIHRvIGF2b2lkIHN1Y2ggaW5jaWRlbnRzIGluIGZ1dHVy
ZS4NCg0KUmVnYXJkcywNClJhZ2hhdg0K
