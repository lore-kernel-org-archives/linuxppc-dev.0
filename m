Message-Id: <m11jkpn-001Sw7C@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Trying to find out the current state of Linux on a MPC 8260
To: linuxppc-dev@lists.linuxppc.org
Date: Fri, 5 Nov 1999 09:59:23 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	* I am starting the work of bringing up Linux kernel on the EST
	Corporation, http://www.estc.com/, SBC 8260 product.

	Ultimately, we will have a custom board that contains a MPC
	8240/8260 but the hardware development won't be real for a long
	time.

	I would like to leverage off of the work of others doing the 82XX
	Linux ports.  I have a number of basic questions, that I could use
	some help with:

	1) Where are the CVS archives that capture the PPC kernel
	   development activity located?  Do they support anonymous
	   access?  If not, what do I need to do to gain access as a named
	   user?

	   I have used anonymous CVS access to cvs.on.openprojects.net
	   before, but I am not sure that this is best choice.
	   http://cvs.on.openprojects.net/ doesn't give me any hints.

	   Example:
	
	   setenv CVSROOT ":pserver:anonymous@cvs.on.openprojects.net:/cvs/linux"
	   cvs login
	   cvs -z 3 checkout linux
	   cvs logout

	2) Has anybody gotten Linux kernel to run on the EST Corp. SBC 8260
	   board?  Or, is anybody is the process of doing this?

	3) Has anybody gotten Linux to run on the 8240/8260?  If so,
	   are there some hints or recipes available?

	   Date: Mon, 13 Sep 1999 00:33:24 -0400
	   From: Dan Malek <dmalek@jlc.net>
	   Subject: Re: LinuxPPC: porting to new platforms

	   Dan Malek reports

	   "I am nearly ready to post the first 8240 and 8260 changes.
	   The 8260 is an extension of the 8xx stuff today.  The 8xx is
	   somewhat changed to accomodate this, and will be in the 2.3.x
	   kernels."

	   Has this been done?  If so, where can I get the source?

	4) What is best way to get in touch with embedded MPC 82xx
	   developers?

	   linuxppc-embedded@lists.linuxppc.org
	   linuxppc-dev@lists.linuxppc.org

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
