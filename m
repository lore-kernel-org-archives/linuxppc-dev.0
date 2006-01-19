Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CCD17689DA
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jan 2006 21:42:41 +1100 (EST)
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0JAgYDZ007764
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jan 2006 02:42:34 -0800
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k0JAgXEc000994
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jan 2006 02:42:33 -0800
Date: Thu, 19 Jan 2006 02:42:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: linuxppc-dev@ozlabs.org
Subject: Fw: [Bugme-new] [Bug 5679] New: Kernel fails to boot
Message-Id: <20060119024220.06c16bc0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Begin forwarded message:

Date: Tue, 29 Nov 2005 17:17:23 -0800
From: bugme-daemon@bugzilla.kernel.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 5679] New: Kernel fails to boot


http://bugzilla.kernel.org/show_bug.cgi?id=5679

           Summary: Kernel fails to boot
    Kernel Version: all > 2.6.8
            Status: NEW
          Severity: blocking
             Owner: platform_ppc-32@kernel-bugs.osdl.org
         Submitter: t.visconti@cantierecreativo.fi.it


Most recent kernel where this bug did not occur: 2.6.8

Distribution: Gentoo 2005.1 - Ubuntu 5.10 - Debian Etch

Hardware Environment: PowerBook 12" (july 2005), italian

Problem Description: With these distributions and with every kernel version
newer than 2.6.8, kernel fails to boot. 
There are no error messages, the pc 'freeze' just before the page with the
penguin logo, this is the freezed page:

======================
Welcome to Linux, kernel 2.6.14

linked at	: 0xc0000000
frame buffer at	: 0xa0008000 (phys), 0xd0008000 (log)
klimit		: 0xc042c018
MSR		: 0x00003030
HID0		: 0x8410c0bc

pmac_init(): exit
id mach(): done
MMU:enter
MMU: hw init
hash:enter
hash:find piece
hash:patch
hash:done
MMU:mapin
MMU:setio
MMU:exit <-(here it stops)
======================
Sometimes the final word 'exit' is not clear (some pixels are in strange positions)

Steps to reproduce: boot with a cd of mentioned distributions or with any kernel
version newer than 2.6.8

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
