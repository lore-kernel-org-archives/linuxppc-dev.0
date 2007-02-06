Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 89C85DDEDD
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 02:17:00 +1100 (EST)
Date: Tue, 6 Feb 2007 09:24:42 -0600
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] generic RTC support for PPC
Message-ID: <20070206152442.GB21050@lixom.net>
References: <20070125073754.GA10004@lixom.net>
	<17864.25011.534976.210942@cargo.ozlabs.ibm.com>
	<01A15290-2EA9-454A-8DD5-28A01E39862B@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <01A15290-2EA9-454A-8DD5-28A01E39862B@kernel.crashing.org>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	kimphill@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 06, 2007 at 08:40:33AM -0600, Kumar Gala wrote:
> 
> On Feb 6, 2007, at 5:08 AM, Paul Mackerras wrote:
> 
> >Olof Johansson writes:
> >
> >>Make the PPC RTC functions use the generic RTC infrastructure if they
> >>are not already defined (and an RTC is registered in the system).
> >>
> >>This should make it possible to remove the hideous direct access used
> >>in some of the 83xx platforms.
> >
> >What was the consensus in the end about this?  Should it go in for
> >2.6.21?
> 
> Are the "scheduling while atomic" issues that existed before actually  
> been fixed?
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116378523012349&w=2

My patch shouldn't do it since it uses a work queue, but that bug report
was for the rtc class api instead of genrtc. It'll need something similar.

I can't even find the rtc_class_hookup code in 2.6.20, so I'm not sure
just what he was running.


-Olof
