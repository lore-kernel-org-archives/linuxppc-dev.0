Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id 5F7EA67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Mar 2005 10:39:36 +1100 (EST)
Date: Tue, 8 Mar 2005 16:39:33 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
Message-ID: <20050308163933.E8434@cox.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B8592ED@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B8592ED@ismail.innsys.innovsys.com>;
	from runet@innovsys.com on Tue, Mar 08, 2005 at 05:35:19PM -0600
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Lots of memory on 826x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Mar 08, 2005 at 05:35:19PM -0600, Rune Torgersen wrote:
> I can use 1GB of RAM now, if I move kernel base to 0xA0000000 and set 
> lowmem size to 1GB. (No Highmem at all)
 
Yup, that's one of many many options. Since TASK_SIZE is only
0x80000000 by default on ppc32, there's no loss anyway.

-Matt
