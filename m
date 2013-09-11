Return-Path: <tony.luck@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by ozlabs.org (Postfix) with ESMTP id 395682C0112
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Sep 2013 04:35:27 +1000 (EST)
From: "Luck, Tony" <tony.luck@intel.com>
To: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>, "linuxppc-dev@ozlabs.org"
 <linuxppc-dev@ozlabs.org>, "seiji.aguchi@hds.com" <seiji.aguchi@hds.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "keescook@chromium.org" <keescook@chromium.org>
Subject: RE: [PATCH 1/3] pstore: Adjust buffer size for compression for
 smaller registered buffers
Date: Wed, 11 Sep 2013 18:34:59 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F31CF4C85@ORSMSX106.amr.corp.intel.com>
References: <20130911120639.27730.8671.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130911120639.27730.8671.stgit@aruna-ThinkPad-T420>
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

LQliaWdfb29wc19idWZfc3ogPSAocHNpbmZvLT5idWZzaXplICogMTAwKSAvIDQ1Ow0KKwliaWdf
b29wc19idWZfc3ogPSAocHNpbmZvLT5idWZzaXplICogMTAwKSAvIGNtcHI7DQoNClRlc3RlZCBv
biBhbiBFUlNUIGJhY2tlZCBzeXN0ZW0uICBTZWVtcyB0byBiZSB3b3JraW5nICh3ZSBzYXZlIGEg
bGl0dGxlIGxlc3MgaW5mb3JtYXRpb24NCnBlciBFUlNUIHJlY29yZCB0aGFuIGJlZm9yZSB0aGlz
IGNoYW5nZSAodW5jb21wcmVzc2VkIHNpemUgZ29lcyBkb3duIGZyb20gfjE3NTAwIHRvDQp+MTY0
MDAgYnl0ZXMpIC0gYnV0IHRoaXMgcGF0Y2ggc3dpdGNoZWQgdGhlIGRlbm9taW5hdG9yIGZyb20g
NDUgdG8gNDggKGZvciBFUlNUKSAtIHNvIHRoYXQNCnNlZW1zIHBsYXVzaWJsZS4NCg0KU2Vpamk6
IGxldCBtZSBrbm93IGhvdyB0aGUgZWZpdmFycyB0ZXN0cyBnby4NCg0KLVRvbnkNCg==
