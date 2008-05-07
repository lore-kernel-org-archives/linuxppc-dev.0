Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 86B62DE5E1
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 05:42:05 +1000 (EST)
Message-ID: <4822063D.5080402@freescale.com>
Date: Wed, 07 May 2008 14:42:53 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Sergej Stepanov <Sergej.Stepanov@ids.de>
Subject: Re: powerpc port for sbc8260-based board problem
References: <733382.15174.qm@web50603.mail.re2.yahoo.com>	
	<20080507182209.GA2710@loki.buserror.net>	
	<1210185652.3519.18.camel@p60365-ste>
	<4821FBA0.9080203@freescale.com>	
	<1210188413.3519.36.camel@p60365-ste>
	<48220428.6020207@freescale.com>
	<1210189239.6362.3.camel@p60365-ste>
In-Reply-To: <1210189239.6362.3.camel@p60365-ste>
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
> Hm... it looks like the default uart_set_termios from
> 
> static const struct tty_operations uart_ops in serial_core.c
> 
> and not cpm_uart_set_termios(..)?..
> 
> Is not it? but why?...

tty_operations != uart_ops

-Scott
