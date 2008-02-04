Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id B1D08DDEBD
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Feb 2008 17:10:22 +1100 (EST)
Date: Mon, 4 Feb 2008 17:08:30 +1100
To: Sripathi Kodi <sripathik@in.ibm.com>
Subject: Re: [ppc] Disparity between sys_clock_getres and vdso implementation
Message-ID: <20080204060830.GS6887@bakeyournoodle.com>
References: <200801271932.59823.sripathik@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200801271932.59823.sripathik@in.ibm.com>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
	john stultz <johnstul@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jan 27, 2008 at 07:32:59PM +0530, Sripathi Kodi wrote:
> Hi Paul,
> 
> On PPC, I see a disparity between clock_getres implementations in the
> vdso and syscall. I am using a IBM Openpower hardware and 2.6.24 kernel
> with CONFIG_HIGH_RES_TIMERS=y. 
> 
> clock_getres call for CLOCK_REALTIME returns 1 millisecond. However,
> when I edit arch/powerpc/kernel/vdso*/gettimeofday.S to force it to use 
> sys_clock_getres, I get 1 nanosecond resolution. The code in vdso seems
> to be returning some pre-defined (incorrect) variables.
> 
> Could you please let me know the reason for this? Is it something that
> should be fixed in vdso?

Almost certainly It's something I missed when I enabled highres timers
on powerpc.

I'll fix this tomorrow.

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
