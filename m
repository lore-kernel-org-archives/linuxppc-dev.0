Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 54C48DDDF9
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Oct 2008 02:05:48 +1000 (EST)
Date: Fri, 3 Oct 2008 20:05:45 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: make Freescale QE support a selectable Kconfig
	option
Message-ID: <20081003160545.GA29927@oksana.dev.rtsoft.ru>
References: <1222961277-6166-1-git-send-email-timur@freescale.com>
	<20081003070416.GA460@oksana.dev.rtsoft.ru>
	<E50C84D1-E250-4827-B260-A5005CABE959@kernel.crashing.org>
	<20081003084849.GA18271@oksana.dev.rtsoft.ru>
	<20081003090804.GA29029@oksana.dev.rtsoft.ru>
	<48E63DB6.8030102@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <48E63DB6.8030102@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 03, 2008 at 10:43:50AM -0500, Timur Tabi wrote:
> Anton Vorontsov wrote:
> 
> > Btw, as for the need.. yes, it was needed to support the FHCI. But
> > now the FHCI would just depend on it, which is better approach anyway.
> 
> I also noticed that "QE GPIO support" is a top-level Kconfig option, instead of
> under Device Drivers -> GPIO.  Is that intentional?

Yup. David said that platform GPIO controllers should not go into the
drivers/gpio/, their place is in the arch/.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
