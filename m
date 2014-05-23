Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews06.kpnxchange.com (cpsmtpb-ews06.kpnxchange.com
 [213.75.39.9])
 by lists.ozlabs.org (Postfix) with ESMTP id B874B1A007D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 07:35:05 +1000 (EST)
Message-ID: <1400880900.31526.55.camel@x220>
Subject: Re: powerpc: remove checks for CONFIG_BOOK3E_MMU_TLB_STATS
From: Paul Bolle <pebolle@tiscali.nl>
To: Scott Wood <scottwood@freescale.com>
Date: Fri, 23 May 2014 23:35:00 +0200
In-Reply-To: <1400865146.12823.54.camel@snotra.buserror.net>
References: <1400608550.4912.48.camel@x220>
 <20140522223758.GA20343@home.buserror.net> <1400830406.31526.6.camel@x220>
 <1400839597.31526.21.camel@x220>
 <1400865146.12823.54.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-05-23 at 12:12 -0500, Scott Wood wrote:
> On Fri, 2014-05-23 at 12:06 +0200, Paul Bolle wrote: 
> > For what it's worth: I can't reproduce this error with the cross
> > compiler now shipped with Fedora 20 (ie, powerpc64-linux-gnu-gcc (GCC)
> > 4.8.1 20130717 (Red Hat 4.8.1-5)). It shows a nice and clean
> >      AS      arch/powerpc/mm/tlb_low_64e.o
> > 
> > in the output.
> > 
> > That's v3.15-rc6, with just this patch, and using a .config generated,
> > with "make oldconfig", from arch/powerpc/configs/ppc64e_defconfig.
> 
> Hmm, I tried applying again and it was fine.

That's a relieve. Thanks, again, for testing!


Paul Bolle
