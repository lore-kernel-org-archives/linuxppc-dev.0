Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.185])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHBvj4SZNzDrG0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 23:58:55 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'SF Markus Elfring' <elfring@users.sourceforge.net>, Joe Perches
 <joe@perches.com>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
CC: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "Stefan
 Berger" <stefanb@linux.vnet.ibm.com>, Alexander Steffen
 <Alexander.Steffen@infineon.com>, Nayna Jain <nayna@linux.vnet.ibm.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Jarkko Sakkinen
 <jarkko.sakkinen@linux.intel.com>, James Bottomley
 <James.Bottomley@HansenPartnership.com>, Julia Lawall <julia.lawall@lip6.fr>,
 Corentin Labbe <clabbe.montjoie@gmail.com>, Kenneth Goldman
 <kgold@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 =?utf-8?B?UGV0ZXIgSMO8d2U=?= <PeterHuewe@gmx.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: Adjusting further size determinations?
Date: Wed, 18 Oct 2017 12:58:43 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD009ACE3@AcuExch.aculab.com>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <20171016183139.otyh3m5c5yurtmow@linux.intel.com>
 <20171016183512.3bz6x4b6lbhpbkje@linux.intel.com>
 <20171017085124.pkrjzghcf5wmcydc@mwanda>
 <f9b35a67-bd7f-b140-bdc1-cb4886a6b1ea@users.sourceforge.net>
 <1508255833.3129.33.camel@HansenPartnership.com>
 <1508280210.6530.32.camel@perches.com>
 <bf7fc26c-bdc9-c752-72c7-f44c22f4a328@users.sourceforge.net>
 <1508318326.6806.1.camel@perches.com>
 <026d582729b849b780fbaa06fb8bc79e@infineon.com>
 <alpine.DEB.2.20.1710181154390.3524@hadrien>
 <1508322510.6806.3.camel@perches.com>
 <ab5730c4-fb69-4791-a2a6-c726493d4564@users.sourceforge.net>
 <1508327383.6806.7.camel@perches.com>
 <0fc1f522-8772-d859-a9b0-cb3b6931c862@users.sourceforge.net>
In-Reply-To: <0fc1f522-8772-d859-a9b0-cb3b6931c862@users.sourceforge.net>
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

RnJvbTogU0YgTWFya3VzIEVsZnJpbmcNCj4gPj4+PiBVbnBsZWFzYW50IGNvbnNlcXVlbmNlcyBh
cmUgcG9zc2libGUgaW4gYm90aCBjYXNlcy4NCj4gPj4gSG93IG11Y2ggZG8geW91IGNhcmUgdG8g
cmVkdWNlIHRoZSBmYWlsdXJlIHByb2JhYmlsaXR5IGZ1cnRoZXI/DQo+ID4NCj4gPiBaZXJvLg0K
PiANCj4gSSBhbSBpbnRlcmVzdGVkIHRvIGltcHJvdmUgdGhlIHNvZnR3YXJlIHNpdHVhdGlvbiBh
IGJpdCBtb3JlIGhlcmUuDQoNClRoZXJlIGFyZSBwcm9iYWJseSBiZXR0ZXIgcGxhY2VzIHRvIHNw
ZW5kIHlvdXIgdGltZSENCg0KSWYgeW91IHdhbnQgJ3NlY3VyaXR5JyBmb3Iga21hbGxvYygpIHRo
ZW46DQoNCiNkZWZpbmUgS01BTExPQ19UWVBFKGZsYWdzKSAodHlwZSAqKWttYWxsb2Moc2l6ZW9m
ICh0eXBlKSwgZmxhZ3MpDQojZGVmaW5lIEtNQUxMT0MocHRyLCBmbGFncykgKihwdHIpID0gS01B
TExPQ19UWVBFKHR5cGVvZiAqKHB0ciksIGZsYWdzKQ0KDQphbmQgY2hhbmdlOg0KCXB0ciA9IGtt
YWxsb2Moc2l6ZW9mICpwdHIsIGZsYWdzKTsNCnRvOg0KCUtNQUxMT0MoJnB0ciwgZmxhZ3MpOw0K
DQpCdXQgaXQgaXMgYWxsIGNodXJuIGZvciBjaHVybidzIHNha2UuDQoNCglEYXZpZA0KDQo=
