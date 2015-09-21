Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F2A361A006B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 19:56:53 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Brian King' <brking@linux.vnet.ibm.com>, "Matthew R. Ochs"
 <mrochs@linux.vnet.ibm.com>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>, James Bottomley
 <James.Bottomley@HansenPartnership.com>, "Nicholas A. Bellinger"
 <nab@linux-iscsi.org>, Ian Munsie <imunsie@au1.ibm.com>, Daniel Axtens
 <dja@ozlabs.au.ibm.com>, Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Shane Seymour <shane.seymour@hp.com>
CC: Michael Neuling <mikey@neuling.org>, "Manoj N. Kumar"
 <manoj@linux.vnet.ibm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v2 12/30] cxlflash: Refine host/device attributes
Date: Mon, 21 Sep 2015 09:55:56 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CB9BE15@AcuExch.aculab.com>
References: <1442438635-49044-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1442438954-49663-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <55FC8371.5010900@linux.vnet.ibm.com>
In-Reply-To: <55FC8371.5010900@linux.vnet.ibm.com>
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

RnJvbTogQnJpYW4gS2luZw0KPiBTZW50OiAxOCBTZXB0ZW1iZXIgMjAxNSAyMjozNQ0KLi4uDQo+
ID4gKwlmb3IgKGkgPSAwOyBpIDwgQ1hMRkxBU0hfTlVNX1ZMVU5TOyBpKyssIGJ1ZiArPSAyMikN
Cj4gDQo+IFJhdGhlciB0aGFuIHRoaXMgYnVnIHByb25lIGhhcmQgY29kZWQgMjIsIGhvdyBhYm91
dCBuZXZlciBpbmNyZW1lbnRpbmcgYnVmIGFuZCBkbyBzb21ldGhpbmcNCj4gc2ltaWxhciB0byB0
aGlzOg0KPiANCj4gPiArCQlieXRlcyArPSBzY25wcmludGYoYnVmLCBQQUdFX1NJWkUsICIlMDNk
OiAlMDE2bGxYXG4iLA0KPiA+ICsJCQkJICAgaSwgcmVhZHFfYmUoJmZjX3BvcnRbaV0pKTsNCj4g
DQo+IAkJYnl0ZXMgKz0gc2NucHJpbnRmKCZidWZbYnl0ZXNdLCBQQUdFX1NJWkUsICIlMDNkOiAl
MDE2bGxYXG4iLA0KPiAJCQkJICAgaSwgcmVhZHFfYmUoJmZjX3BvcnRbaV0pKTsNCi4uLg0KDQoJ
Ynl0ZXMgKz0gc2NucHJpbnRmKGJ1ZiArIGJ5dGVzLCBQQUdFX1NJWkUgLSBieXRlcywgLi4uLg0K
DQpZb3UgbmVlZCB0byBjaGVjayBzY25wcmludGYoKSdzIHJldHVybiB2YWx1ZSB0aG91Z2guDQpU
aGUgYWJvdmUgaXMgd3JvbmcgZm9yIGxpYmMncyBzbnByaW50ZigpLg0KDQoJRGF2aWQNCg0K
