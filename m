Message-Id: <m12Feir-001SweC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Embedded PPC (8xx/82xx) Linux kernel development: How it is done?
To: linuxppc-embedded@lists.linuxppc.org
Date: Tue, 1 Feb 2000 09:56:05 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	* Embedded PPC (8xx/82xx) Linux kernel development: How it is done?

	- What tools are used to roll in the PPC Linux kernel changes
	  into the repositories?

	      + snapshots

	        ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/mpc8xx-2.2.13.tgz
	        ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/linux-2.3.18.tgz

                There hasn't been munch activity in
	        ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/
		over the last couple of months.

-rw-r--r--   1 dmalek   1000        17293 Nov 10 11:41 dl-machine.h
-rw-r--r--   1 dmalek   1000         6018 Jul  8  1999 embedded_notes
-rw-r--r--   1 dmalek   1000        32876 Oct 22 17:31 fadsrom.tgz
-rw-r--r--   1 dmalek   dmalek      31153 Jan 19 09:15 fec.c
-rw-r--r--   1 dmalek   1000       166978 Nov  5 18:55 gdbserver.tgz
-rw-r--r--   1 dmalek   1000         7492 Oct 28 12:28 getting_started.rpx
-rw-r--r--   1 dmalek   1000      3446575 Nov  8 17:07 glibc-0.961212-1r.src.rpm
-rw-r--r--   1 dmalek   1000       707994 Mar  4  1999 libc-1.99-8xx.tar.gz
-rw-r--r--   1 dmalek   1000     13402725 Sep 14 19:41 linux-2.3.18.tgz
-rw-r--r--   1 dmalek   1000         6345 Jul  8  1999 mbxnotes
-rw-r--r--   1 dmalek   1000     133029168 Feb 12  1999 mbxroot.full.tgz
-rw-r--r--   1 dmalek   1000       910617 Sep 18  1998 mbxroot.min.tgz
-rw-r--r--   1 dmalek   1000     17172560 Oct 22 17:38 mpc8xx-2.2.13.tgz
-rw-r--r--   1 dmalek   1000      5335914 Jul 28  1999 xppc_tools.tgz
-rw-r--r--   1 dmalek   dmalek       2042 Nov 30 11:23 zsrec.c

 	      + RCS

	      + CVS

	        setenv CVSROOT :pserver:anonymous@cvs.on.openprojects.net:/cvs/linux
		cvs co linux

	      + SCCS

	      + Bitkeeper, http://www.bitkeeper.com/

	        In
		http://lists.linuxppc.org/cgi-bin/wilma/wilma_hiliter/linuxppc-embedded/199912/msg00106.html#hilite?line=29
		Dan Malek <dan@netx4.com> talks about "Cort's BitKeeper"

		In
		http://lists.linuxppc.org/cgi-bin/wilma/wilma_hiliter/linuxppc-embedded/200001/msg00189.html#hilite?line=71
		Dan Malek <dan@netx4.com> talks about "I work in the
		BitKeeper tree, which is supposed to be the official PPC
		tree and one step away from kernel.org."

	        What or where is the "BitKeeper tree"?

	- Where are the repositories located?

	- Are these repositories closed?  Or, can others see what changes
	  are being made?

	- How long does it take for the kernel changes from these
	  repositories to make it into the offical Linux kernel release?

	- Who are the people involved with the embedded PPC Linux kernel
	  changes?

	      + MPC860
	      + MPC8240
	      + MPC8260

	      In
	      http://lists.linuxppc.org/cgi-bin/wilma/wilma_hiliter/linuxppc-embedded/199911/msg00001.html#hilite?line=116
	      Dan Malek <dan@netx4.com> writes, " I have been working on
	      the kernel almost daily for many years now, and there are
	      few others that do the same."

	      Dan Malek <dan@netx4.com> is involved, but who are the
	      others?  What is the division of labor between Dan and the
	      rest?

	      This is what I have figure out so far:

		Dan Malek
		Seasoned PPC Kernel hacker for 8xx and 82xx
		product and software development consultant
		dan@netx4.com

		Cort Dougan
		cort@ppc.kernel.org
		http://www.ppc.kernel.org/

		Grant M. Erickson
		grant@lcse.umn.edu
		PPC Kernel hacker for 4xx

		Wolfgang Denx
		wd@denx.de
		http://www.denx.de/solutions-en.html
		DENX Software Engineering
		Products: LinuxPPC Cross Development Kit (CDK)
		          LinuxPPC for MPC8xx Systems, especially for TQM8xxL Modules

	        Graham Stoney
		greyham@research.canon.com.au
		Linux for PowerPC Embedded Systems HOWTO/FAQ

	- Is this a closed community?  Or, can others join the team?

	- If it is an open community, how does one join?  Are there any
	  posted rules?

	- I want to contribute to the process of porting Linux to
	  run on the EST SBC8260 single board computer, but I need to
	  understand how to participate.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
