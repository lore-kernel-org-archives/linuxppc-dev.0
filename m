Return-Path: <jacmet@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 3999CDDDE6
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 22:58:00 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so1781339uge.0
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 03:57:59 -0800 (PST)
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 7/7] [POWERPC] Xilinx: Update booting-without-of.
References: <1197589413-5965-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-3-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-4-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-5-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-6-git-send-email-stephen.neuendorffer@xilinx.com>
	<20071213234151.D0B3DE80061@mail20-sin.bigfish.com>
	<20071217041455.GA3477@localhost.localdomain>
	<fa686aa40712162030q6f0e6d87j5e6e5379cbd0d54e@mail.gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Mon, 17 Dec 2007 12:57:36 +0100
In-Reply-To: <fa686aa40712162030q6f0e6d87j5e6e5379cbd0d54e@mail.gmail.com>
	(Grant Likely's message of "Sun\, 16 Dec 2007 21\:30\:21 -0700")
Message-ID: <87d4t5a5zj.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org, simekm2@fel.cvut.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:

Hi,

 >> > 3) Uartlite requires a port-number property for the console to work.
 >> 
 >> Why?  In general we try to avoid magical sequence numbers - cell-index
 >> should *only* be used when it's needed to index or program some shared
 >> register.

 Grant> Aliases is probably the correct construct for this.
 Grant> port-number was a bad idea and I never should have gone that
 Grant> direction.

Perhaps it would make more sense to add a _find_match_or_unused(port)
like 8250.c and make the initialization order define the index instead
of explicitly setting it?

Now we're at it - Why isn't the uartlite of glue handled by of_serial.c?

-- 
Bye, Peter Korsgaard
