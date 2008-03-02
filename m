Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-39.bluehost.com (outbound-mail-39.bluehost.com
	[69.89.20.193]) by ozlabs.org (Postfix) with SMTP id 1C8C6DDED8
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Mar 2008 10:05:26 +1100 (EST)
Message-ID: <47CB3127.3040307@dlasys.net>
Date: Sun, 02 Mar 2008 17:58:47 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Phil Hochstetler <Phil.Hochstetler@serveron.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: ML403 Linux port questions
References: <ADA5878BA63680469C75C14CEEE2FE28012F482B@mail.serveron.com>
In-Reply-To: <ADA5878BA63680469C75C14CEEE2FE28012F482B@mail.serveron.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    I have a two part series that should be appearing in Circuit Cellar
either this month or next,
that is targeted very close to what you are looking for.
    You have to be a masochist to try to build linux kernels under cygwin.
    It is purportedly doable - I have never succeeded, but very painful.

    If you must work under windows - I know alot of engineers do, then I
would highly recommend colinux.
    www.colinux.org. It will give you linux and windows running
concurrently on the same machine with
    very little pain, no additional cost, there is a small amount of
grief getting windows-colinux networking functioning,
    that is not critical but it is nice. Getting X windows running is
substantially more effort and is very nice - but completely
    unnecescary. Colinux is a much easier and lighter weight solution
than virtualization.

    That said I would highly recommend you seriously consider doing
linux development without windows.
    The targets you are going to be developing for are going to run linux.
    The initial learning curve might be steeper, but the payoff is
greater. Everything you learn on the development
    side will apply to the target.
    There are bazillions of Live CD's you can try. I would highly
recommend Ubuntu.
    Its alot like windows - except mostly friendlier and it works.

    Personally, I went the roll your own method for creating a
development environment.
    I have no experience with ELDK.
    Buildroot and many other "environments" dictate a very specific way
of working.
    They guide you to a working solution faster but I find myself
fighting against their
    limitations all too soon.
    Unfortunately crosstools has not been updated in a while, and does
not officially support
     uClibc (it does support glibc). uClibc is very appealing for
limited resource systems.
    There is a crosstools-ng project, but it does not have ppc support.

    It would be really really nice (hint) if Xilinx would get their
microblaze compiler code
    into the gcc distribution.



Phil Hochstetler wrote:
> I'm setting up a new development environment to get a working port of
> Linux on the Xilinx Virtex-4 chip  (I have a Xilinx ML403 board).  I'm
> looking for the quickest way to get a working development environment
> for the 2.6 kernel without paying thousands of $$ (what happened to
> MontaVista?).  My first attempt was to use google and found lots of
> resources.  The problem is that much of the info is dated or makes
> assumptions about your environment.  I read Grants write-up at
> http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex.  Because I
> want to use Windows XP SP2 as the host if possible, I went down the path
> of installing the current Cygwin and was able to create cross tools (gcc
> 4.1) successfully.  The problem I am having is that the Linux build
> process requires a newer gcc than 3.4.4-3 which is what Cygwin provides.
> I have used the EDK to build a bsp package successfully so that is not a
> problem.  I tried to compile the 2.6.24.2 mainline kernel but it fails
> to compile using the Cygwin tools (it never gets as far as using them).
>
>  
>
> I guess what I am looking for is advise on the lowest risk, easiest to
> set up environment to setup that will just work.  Also advise on which
> kernel to use.   I don't need a detailed tutorial but a high level
> direct that is known to work.  I am thinking of using either the secret
> lab tree or the Xilinx tree as recommended in Grants wiki page.  Should
> I just forget using XP and install a Linux (x86 processor so I must use
> cross tools)?   If so, what is the recommend distro and what version?
>
>  
>
> Thanks for all your sharing of experience.  I hope to contribute back as
> soon as I can.
>
>  
>
> --phil
>
>
>   
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
