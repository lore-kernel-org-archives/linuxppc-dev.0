Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B5CD679F7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Feb 2006 20:51:15 +1100 (EST)
Date: Fri, 24 Feb 2006 09:50:58 +0000
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: "Pelton, Dave" <dpelton@ciena.com>
Subject: Re: UTOPIA support for MPC885 with 2.6.15 kernel
Message-Id: <20060224095058.373a141b.ajz@cambridgebroadband.com>
In-Reply-To: <3B9518857C91E345AA1806A6F53C0EB701596AF2@onmxm01.ciena.com>
References: <3B9518857C91E345AA1806A6F53C0EB701596AF2@onmxm01.ciena.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Dave,

I maintain the mpc860sar project - although it hasn't required much
maintenance for the past year or so.

Nobody has told me about any linux-2.6 port, so it's possible you are
the first to do this.

If you are happy with your port I'd appreciate it if you sent me a
patch which I would then consider adding to the site.

FYI, I also maintain a  PQII driver called mpc8260sar, and I have
been sent a patch which added support for linux-2.6 without breaking
linux-2.4, so I added this to the sourceforge project.  If you like
I'll send you the PQII linux-2.6 patch as a guide for how to do it for
the original PQI driver.

Alex


On Fri, 24 Feb 2006 00:54:39 -0500
"Pelton, Dave" <dpelton@ciena.com> wrote:

> Hello,
> 
> I am currently working with a MPC885ADS board running a 2.6.15
> kernel build.  I have been attempting to get the UTOPIA interface
> working, but I have not been able to find kernel code (or patches)
> to do this.  
> 
> The closest I have found so far is the MPC860/862 ATM driver on
> SourceForge.  Unfortunately this driver was written for the 2.4
> kernel, and does not include MPHY support for ESAR mode.  I have
> been able to get this code to compile and run on my kernel, and now
> I am digging into the ESAR/MPHY support stuff.  
> 
> I was wondering if anyone else has already done anything along these
> lines (either a ESAR/MPHY driver or MPC855 UTOPIA support on the 2.6
> kernel), as I would prefer to build on existing code rather than
> gluing this stuff together myself.
> 
> - Thanks,
>   David Pelton.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
