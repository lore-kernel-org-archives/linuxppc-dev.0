Return-Path: <tony.luck@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by ozlabs.org (Postfix) with ESMTP id 3B47B2C03B2
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Sep 2013 03:43:59 +1000 (EST)
From: "Luck, Tony" <tony.luck@intel.com>
To: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>, "linuxppc-dev@ozlabs.org"
 <linuxppc-dev@ozlabs.org>, "seiji.aguchi@hds.com" <seiji.aguchi@hds.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "keescook@chromium.org" <keescook@chromium.org>
Subject: RE: [PATCH v2] pstore: Adjust buffer size for compression for
 smaller registered buffers
Date: Thu, 12 Sep 2013 17:43:56 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F31CF6AB8@ORSMSX106.amr.corp.intel.com>
References: <20130912064832.15340.52422.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130912064832.15340.52422.stgit@aruna-ThinkPad-T420>
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

KwlkZWZhdWx0Og0KKwkJY21wciA9IDYwOw0KKwkJYnJlYWs7DQorCX0NCiANCklzIHRoaXMgdGhl
IHJpZ2h0ICJkZWZhdWx0Ij8gIEl0IG1heSBiZSBhIGdvb2QgY2hvaWNlIGZvciBhIGJhY2tlbmQg
d2l0aCBhIHJlYWxseQ0KdGlueSBidWZmZXIgKDEgLi4uIDk5OSkuICBCdXQgbGVzcyBnb29kIGZv
ciBhICh0aGVvcmV0aWNhbCkgYmFja2VuZCB3aXRoIGEgbGFyZ2VyDQpidWZmZXIgKDEwMDAxIC4u
LiBpbmZpbml0eSBhbmQgYmV5b25kKS4gIFdoaWNoIGFyZSB5b3UgdHJ5aW5nIHRvIGNhdGNoIGhl
cmU/DQoNCi1Ub255DQoNCg==
