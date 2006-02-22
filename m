Return-Path: <luming.yu@intel.com>
Received: from orsfmr003.jf.intel.com (fmr18.intel.com [134.134.136.17])
	by ozlabs.org (Postfix) with ESMTP id 5BB3F679F0
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Feb 2006 13:39:24 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 2.6.16-rc4: known regressions
Date: Wed, 22 Feb 2006 10:39:01 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840AFD52B2@pdsmsx403>
From: "Yu, Luming" <luming.yu@intel.com>
To: "Adrian Bunk" <bunk@stusta.de>, "Linus Torvalds" <torvalds@osdl.org>,
	"Andrew Morton" <akpm@osdl.org>
Cc: "Brown, Len" <len.brown@intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-acpi@vger.kernel.org, John Stultz <johnstul@us.ibm.com>,
	Meelis Roos <mroos@linux.ee>, gregkh@suse.de,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, linux-input@atrey.karlin.mff.cuni.cz,
	Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
>Subject    : S3 sleep hangs the second time - 600X
>References : http://bugzilla.kernel.org/show_bug.cgi?id=3D5989
>Submitter  : Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
>Status     : problematic commit identified,
>             further discussion is in the bug

The real problem is there are some bugs hidden by ec_intr=3D0.
ec_intr=3D1 just get these bug  just exposed, and we need to fix them.=20

Thanks,
Luming
