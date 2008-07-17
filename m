Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 178A7DDF94
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 01:51:54 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 82xx performance
Date: Thu, 17 Jul 2008 10:52:28 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B04B34BE7@ismail.innsys.innovsys.com>
In-Reply-To: <200807171747.28624.arnd@arndb.de>
References: <DCEAAC0833DD314AB0B58112AD99B93B04AE61BC@ismail.innsys.innovsys.com>
	<200807170032.36564.arnd@arndb.de>
	<DCEAAC0833DD314AB0B58112AD99B93B04B34B71@ismail.innsys.innovsys.com>
	<200807171747.28624.arnd@arndb.de>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Arnd Bergmann" <arnd@arndb.de>,
	<linuxppc-dev@ozlabs.org>
Cc: Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> Seeing more hits in handle_mm_fault suggests that you have
> a higher page fault rate. A trivial reason for this might
> be that the amount of memory was misdetected in the new
> code (maybe broken device tree). What is the content of
> /proc/meminfo after a fresh boot?

I also just realized that the /aprch/ppc was set up without high-mem
support (using all 1G as lowmem), while the arch/powerpc was set up with
hightmem. I'm retrying a compile without highmem support and 1 G lowmem
on arch/powerpc now to see if it makes a difference.
