Return-Path: <mel@csn.ul.ie>
Received: from gir.skynet.ie (gir.skynet.ie [193.1.99.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 05031DDDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 22:32:15 +1100 (EST)
Date: Fri, 31 Oct 2008 11:32:02 +0000
From: Mel Gorman <mel@csn.ul.ie>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: 2.6.28-rc1: NVRAM being corrupted on ppc64 preventing boot
	(bisected)
Message-ID: <20081031113202.GB9872@csn.ul.ie>
References: <alpine.LFD.2.00.0810232028500.3287@nehalem.linux-foundation.org>
	<20081030142632.GA15645@csn.ul.ie>
	<18698.7794.500191.189515@cargo.ozlabs.ibm.com>
	<20081031103646.GA24395@csn.ul.ie>
	<18698.59790.393775.139313@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <18698.59790.393775.139313@cargo.ozlabs.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 31, 2008 at 10:18:38PM +1100, Paul Mackerras wrote:
> Mel Gorman writes:
> 
> > Yaboot in my case and I've heard it affected a DVD installation. I don't
> > know for sure if it affects netboot but as I think it's something the
> > kernel is doing, it probably doesn't matter how it gets loaded?
> 
> I do need to know whether it was the vmlinux or the zImage.pseries
> that you were loading with yaboot.  That commit you identified affects
> the contents of an ELF note in the zImage.pseries that firmware looks
> at, as well as a structure in the kernel itself that gets passed as an
> argument to a call to firmware.  If you were loading a vmlinux with
> yaboot when you saw the corruption occur then that narrows things down
> a bit.
> 

It's the vmlinux file I am seeing problems with.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
