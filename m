Return-Path: <jdl@freescale.com>
From: Jon Loeliger <jdl@freescale.com>
To: Jaka =?iso-8859-2?Q?Mo=E8nik?= <jaka@activetools.si>
In-Reply-To: <1109951593.32294.5.camel@x.at.lan>
References: <1109951593.32294.5.camel@x.at.lan>
Content-Type: text/plain; charset=iso-8859-2
Message-Id: <1109952363.8949.10.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Fri, 04 Mar 2005 10:06:03 -0600
Cc: Embedded PPC Linux Mailing List <Linuxppc-embedded@ozlabs.org>
Subject: Re: U-Boot hangs in relocate_code after sw reboot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2005-03-04 at 09:53, Jaka Moènik wrote:
> hello!
> 
> I don't really know if this mailing list is the proper place to direct
> questions regarding U-Boot, but I've seen some preceding posts about it,
> so I thought I'd ask...

Let's start with:  The U-Boot list is over at:
    u-boot-users <u-boot-users@lists.sourceforge.net>

> I've ported U-Boot over to a custom MPC8560 (PQ3) based board - it works
> well, 

Good...  So, what version did you start with?
And how custom is it?  We just might need a few more details here... :-)

> except that after a sw reboot (from linux kernel or u-boot
> itself),

There were some early releases of 8560 U-Boot code that
didn't do SW Reset right.  Let's make sure we are running
a modern U-Boot for the 85xx first.

>  it only gets to the part where it relocates itself to RAM and
> then hangs - the last debug output is 

There are some U-Boot FAQs down this line too.

> has anyone experienced similar problems? any hints on what to look at?

HTH,
jdl
