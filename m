Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id EC54EDDDEE
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 15:55:37 +1000 (EST)
Date: Tue, 22 Apr 2008 15:55:36 +1000
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/3] Raise the upper limit of NR_CPUS.
Message-ID: <20080422055536.GI20457@bakeyournoodle.com>
References: <767e424a294239aba86aa7da086f6395f7066d14.1208834828.git.tony@bakeyournoodle.com>
	<20080422135005.16b4a65d.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20080422135005.16b4a65d.sfr@canb.auug.org.au>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 22, 2008 at 01:50:05PM +1000, Stephen Rothwell wrote:
> Hi Tony,
> 
> On Tue, 22 Apr 2008 13:30:06 +1000 (EST) Tony Breeds <tony@bakeyournoodle.com> wrote:
> >
> > +void __init initialise_pacas(void)
> > +{
> > +	int cpu;
> > +	unsigned long kernel_toc = (unsigned long)(&__toc_start) + 0x8000UL;
> 
> This line could do with a comment saying what it is doing ...

It does need a comment I agree, but I don't think I can do it justice :)
... I just used what was already there.
 
> > +++ b/include/asm-powerpc/paca.h
> >
> > +#if   NR_CPUS >= 32
> > +#define NR_STATIC_PACAS	64
> 
> This allocates 64 pacas etc for NR_CPUS == 32 so surely that test should
> be >?

Yes it should be.

Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
