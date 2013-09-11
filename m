Return-Path: <seiji.aguchi@hds.com>
Received: from usindpps04.hds.com (usindpps04.hds.com [207.126.252.17])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 477F92C00DB
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Sep 2013 04:58:15 +1000 (EST)
From: Seiji Aguchi <seiji.aguchi@hds.com>
To: "Luck, Tony" <tony.luck@intel.com>, Aruna Balakrishnaiah
 <aruna@linux.vnet.ibm.com>, "linuxppc-dev@ozlabs.org"
 <linuxppc-dev@ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "keescook@chromium.org"
 <keescook@chromium.org>
Subject: RE: [PATCH 1/3] pstore: Adjust buffer size for compression for
 smaller registered buffers
Date: Wed, 11 Sep 2013 18:57:54 +0000
Message-ID: <A5ED84D3BB3A384992CBB9C77DEDA4D443EC2753@USINDEM103.corp.hds.com>
References: <20130911120639.27730.8671.stgit@aruna-ThinkPad-T420>
 <3908561D78D1C84285E8C5FCA982C28F31CF4C85@ORSMSX106.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F31CF4C85@ORSMSX106.amr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "jkenisto@linux.vnet.ibm.com" <jkenisto@linux.vnet.ibm.com>,
 "mahesh@linux.vnet.ibm.com" <mahesh@linux.vnet.ibm.com>,
 "ccross@android.com" <ccross@android.com>,
 "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PisJLyogYnVmZmVyIHJhbmdlIGZvciBlZml2YXJzICovDQo+KwljYXNlIDEwMDAgLi4uIDIwMDA6
DQo+KwkJY21wciA9IDU2Ow0KPisJCWJyZWFrOw0KDQo+IFNlaWppOiBsZXQgbWUga25vdyBob3cg
dGhlIGVmaXZhcnMgdGVzdHMgZ28uDQoNCmVmaXZhcnMgd29ya3MgZmluZS4NClVuY29tcHJlc3Nl
ZCBzaXplIGFib3V0IDE4MDAgYnl0ZXMuIEl0IG1hdGNoZXMgdGhlIHZhbHVlIG9mIGNtcHIsIDU2
LiANCg0KUGxlYXNlIGZlZWwgZnJlZSB0byBhZGQgbXkgIlRlc3RlZC1ieSIgdG8gYWxsIHRocmVl
IHBhdGNoZXMuDQoNClRlc3RlZC1ieTogU2VpamkgQWd1Y2hpIDxzZWlqaS5hZ3VjaGlAaGRzLmNv
bT4NCg0K
