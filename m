Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [213.144.29.131])
	by ozlabs.org (Postfix) with ESMTP id EA86BDDF02
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 16:22:06 +1000 (EST)
Received: from ares.ids.de (ares.ids.de [127.0.0.1])
	by ares.ids.de (PGP Universal) with ESMTP id C45BDF49133
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 08:22:04 +0200 (CEST)
Subject: Re: powerpc port for sbc8260-based board problem
From: Sergej Stepanov <Sergej.Stepanov@ids.de>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <48220690.7080301@freescale.com>
References: <733382.15174.qm@web50603.mail.re2.yahoo.com>
	<20080507182209.GA2710@loki.buserror.net>
	<1210185652.3519.18.camel@p60365-ste>	<4821FBA0.9080203@freescale.com>
	<1210188413.3519.36.camel@p60365-ste>	<48220428.6020207@freescale.com>
	<1210189239.6362.3.camel@p60365-ste> <4822063D.5080402@freescale.com>
	<48220690.7080301@freescale.com>
Date: Thu, 08 May 2008 08:22:03 +0200
Message-Id: <1210227723.3346.0.camel@p60365-ste>
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


Am Mittwoch, den 07.05.2008, 14:44 -0500 schrieb Scott Wood:
> Scott Wood wrote:
> > Sergej Stepanov wrote:
> >> Hm... it looks like the default uart_set_termios from
> >>
> >> static const struct tty_operations uart_ops in serial_core.c
> >>
> >> and not cpm_uart_set_termios(..)?..
> >>
> >> Is not it? but why?...
> > 
> > tty_operations != uart_ops
> 
> Despite the unfortunate name of the instance of the former.
> 
> -Scott

Of course :)
