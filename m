Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E4E60DDF0D
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 04:56:53 +1000 (EST)
Message-ID: <4821FBA0.9080203@freescale.com>
Date: Wed, 07 May 2008 13:57:36 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Sergej Stepanov <Sergej.Stepanov@ids.de>
Subject: Re: powerpc port for sbc8260-based board problem
References: <733382.15174.qm@web50603.mail.re2.yahoo.com>	
	<20080507182209.GA2710@loki.buserror.net>
	<1210185652.3519.18.camel@p60365-ste>
In-Reply-To: <1210185652.3519.18.camel@p60365-ste>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergej Stepanov wrote:
> My story is follow: we have mpc8247 based card.
> The problem with smc happens due to the cpm reset.
> Of course, if you have not CONFIG_PPC_EARLY_DEBUG_CPM with
> CONFIG_PPC_CPM_NEW_BINDING.
> May be it is some kind of mistake, but i could fix the problem with the
> patch i told above.
> Could give me some your note, please? Thank you.

I'm not sure how it would make a difference -- the BRG should have 
already been set through the set_termios callback, which is called from 
uart_set_options.

-Scott
