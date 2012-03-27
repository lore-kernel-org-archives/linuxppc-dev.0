Return-Path: <tony.luck@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by ozlabs.org (Postfix) with ESMTP id 56084B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2012 09:03:30 +1100 (EST)
From: "Luck, Tony" <tony.luck@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>
Subject: RE: [PATCH 05/14] IA64: adapt for dma_map_ops changes
Date: Tue, 27 Mar 2012 21:53:01 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F15B724D8@ORSMSX104.amr.corp.intel.com>
References: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
 <1324643253-3024-6-git-send-email-m.szyprowski@samsung.com>
 <CA+8MBbLAafFbVwviFmkjD0DNz5RsCbB_TNLL67wEi2k-hyXkXA@mail.gmail.com>
In-Reply-To: <CA+8MBbLAafFbVwviFmkjD0DNz5RsCbB_TNLL67wEi2k-hyXkXA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Jonathan Corbet <corbet@lwn.net>,
 "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 "microblaze-uclinux@itee.uq.edu.au" <microblaze-uclinux@itee.uq.edu.au>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "discuss@x86-64.org" <discuss@x86-64.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> until part 5 (when ia64 sees the changes to match).  You could either mer=
ge part
> 5 into part 2 (to make a combined x86+ia64 piece

Doh! I see that you already did this in the re-post you did a few hours
ago (which my mail client had filed away in my linux-arch folder).

-Tony
=20
