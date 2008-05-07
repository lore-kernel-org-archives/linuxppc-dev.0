Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [213.144.29.131])
	by ozlabs.org (Postfix) with ESMTP id 0C921DE450
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 05:26:56 +1000 (EST)
Received: from ares.ids.de (ares.ids.de [127.0.0.1])
	by ares.ids.de (PGP Universal) with ESMTP id 8DCF7F49128
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 21:26:54 +0200 (CEST)
Subject: Re: powerpc port for sbc8260-based board problem
From: Sergej Stepanov <Sergej.Stepanov@ids.de>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <4821FBA0.9080203@freescale.com>
References: <733382.15174.qm@web50603.mail.re2.yahoo.com>
	<20080507182209.GA2710@loki.buserror.net>
	<1210185652.3519.18.camel@p60365-ste> <4821FBA0.9080203@freescale.com>
Date: Wed, 07 May 2008 21:26:53 +0200
Message-Id: <1210188413.3519.36.camel@p60365-ste>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Am Mittwoch, den 07.05.2008, 13:57 -0500 schrieb Scott Wood:
> Sergej Stepanov wrote:
> > My story is follow: we have mpc8247 based card.
> > The problem with smc happens due to the cpm reset.
> > Of course, if you have not CONFIG_PPC_EARLY_DEBUG_CPM with
> > CONFIG_PPC_CPM_NEW_BINDING.
> > May be it is some kind of mistake, but i could fix the problem with the
> > patch i told above.
> > Could give me some your note, please? Thank you.
> 
> I'm not sure how it would make a difference -- the BRG should have 
> already been set through the set_termios callback, which is called from 
> uart_set_options.
> 
> -Scott
Yes, i thought it also, but i traced it for us for the uart console.
The cpm_uart_set_termios(..) was not called.
At which place should it be called?
Is it uart_set_options(..)?

Sergej.
