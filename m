Return-Path: <tony.luck@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by ozlabs.org (Postfix) with ESMTP id 7C6BB2C00D5
 for <linuxppc-dev@ozlabs.org>; Thu,  5 Sep 2013 02:11:24 +1000 (EST)
From: "Luck, Tony" <tony.luck@intel.com>
To: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>, Seiji Aguchi
 <seiji.aguchi@hds.com>
Subject: RE: [RFC PATCH v2 04/11] pstore: Add compression support to pstore
Date: Wed, 4 Sep 2013 16:11:13 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F31CDB23E@ORSMSX106.amr.corp.intel.com>
References: <20130816131403.3338.82330.stgit@aruna-ThinkPad-T420>
 <20130816131805.3338.68767.stgit@aruna-ThinkPad-T420>
 <A5ED84D3BB3A384992CBB9C77DEDA4D443E8F0D7@USINDEM103.corp.hds.com>
 <3908561D78D1C84285E8C5FCA982C28F31CC7AC0@ORSMSX106.amr.corp.intel.com>
 <521C36F4.8030607@linux.vnet.ibm.com>
 <A5ED84D3BB3A384992CBB9C77DEDA4D443E9E24D@USINDEM103.corp.hds.com>
 <5226CC9D.30904@linux.vnet.ibm.com>
In-Reply-To: <5226CC9D.30904@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "jkenisto@linux.vnet.ibm.com" <jkenisto@linux.vnet.ibm.com>,
 "keescook@chromium.org" <keescook@chromium.org>,
 "mahesh@linux.vnet.ibm.com" <mahesh@linux.vnet.ibm.com>,
 "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "ccross@android.com" <ccross@android.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> The reason behind compression failure is the size of big_oops_buf which i=
s too
> big for efivars case. I will do some experiments with different kind of t=
exts
> for buffer size 1024 to check if 100/53 suits for all the cases.
...

> Yes this can be changed to zlib_inflateInit2().

Original patch series was just pulled by Linus ... so we'll need a patch on=
 top
of current Linus git tree to fix these issues.  But let's make sure that ef=
ivars, erst,
etc. are all happy with the changes we make before I ask Linus to pull anot=
her
pstore piece.

Thanks

-Tony
