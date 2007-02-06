Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 2D72CDDEBD
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 02:08:59 +1100 (EST)
Date: Tue, 6 Feb 2007 09:16:40 -0600
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] generic RTC support for PPC
Message-ID: <20070206151640.GA21050@lixom.net>
References: <20070125073754.GA10004@lixom.net>
	<17864.25011.534976.210942@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17864.25011.534976.210942@cargo.ozlabs.ibm.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, kimphill@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 06, 2007 at 10:08:35PM +1100, Paul Mackerras wrote:
> Olof Johansson writes:
> 
> > Make the PPC RTC functions use the generic RTC infrastructure if they
> > are not already defined (and an RTC is registered in the system).
> > 
> > This should make it possible to remove the hideous direct access used
> > in some of the 83xx platforms.
> 
> What was the consensus in the end about this?  Should it go in for
> 2.6.21?

Sounds like Tom Rini was strongly against it since the rtc class api
should be the way to do it now. I don't care much either way, and
it's not urgent for 2.6.21. Leave it out for now, I had written it off
already myself.



-Olof
