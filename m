Return-Path: <sam@ravnborg.org>
Received: from smtpout3.tre.se (smtpout3.tre.se [80.251.192.228])
	by ozlabs.org (Postfix) with ESMTP id 698FCDE06D
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 02:53:30 +1000 (EST)
Date: Fri, 1 Aug 2008 18:45:25 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [BUILD-FAILURE] 2.6.27-rc1-mm1 - allyesconfig build fails on
	powerpc
Message-ID: <20080801164525.GA2299@uranus.ravnborg.org>
References: <20080731000354.24b55d5b.akpm@linux-foundation.org>
	<4891B370.5040208@linux.vnet.ibm.com>
	<20080801052936.GZ20457@bakeyournoodle.com>
	<20080731231206.80940fba.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080731231206.80940fba.akpm@linux-foundation.org>
Cc: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Kernel Testers List <kernel-testers@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 
> Am not terribly happy with the state of the gcov patches.  They STILL
> leave thousands of dead symlinks lying around after `make mrproper' and
> generally seem to muck up the kbuild system a bit, although nothing
> that a bit of Sam love wouldn't fix.

Have not had time / energy to get aroud to it.
Other things continue to pop up and time is limited at the moment
as in more limited than usual).

	Sam
