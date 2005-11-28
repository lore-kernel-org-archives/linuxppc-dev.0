Return-Path: <SRS0+a7507532f178560193a5+827+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 84319681BE
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Nov 2005 21:12:52 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17290.28508.336476.478948@cargo.ozlabs.ibm.com>
References: <1133016287.4044.65.camel@baythorne.infradead.org>
	<17290.28508.336476.478948@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 10:12:46 +0000
Message-Id: <1133172766.31573.14.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Make ARCH=ppc build again with new syscall path
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-11-28 at 13:45 +1100, Paul Mackerras wrote:
> Hmmm.  If we need to do this then maybe we should just get rid of the
> arch/ppc versions of the relevant files and make ARCH=ppc use the
> versions from arch/powerpc.
> 
> What do people think?  Do we make ARCH=ppc use more and more stuff
> from arch/powerpc, and delete the duplicates from arch/ppc, or do
> people want to be conservative and keep arch/ppc largely unchanged?
> (I would prefer the former, myself.)

I also prefer the former, in general -- it makes it easier for people to
port their platform from ppc to powerpc if we don't let the two diverge
too much.

There's also a third option, which _encourages_ people to port their
platform without necessarily making it easier: just let arch/ppc break.
I'm not sure I'd necessarily advocate that one _yet_ but maybe in the
not-so-distant future.

-- 
dwmw2
