Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: Re: gdbserver and gdb cross debug?
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: Andreas Beranek <a.beranek@cci.isar.de>
Cc: Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <006001c28989$fb0922c0$0564a8c0@Obelix>
References: <200210260458.g9Q4wpq15745@ftp1.mvista.com>
	<3DCF5E9B.406F7565@bmrtech.com> <1037020322.22840.70.camel@spawn>
	<006001c28989$fb0922c0$0564a8c0@Obelix>
Content-Type: text/plain; charset=ISO-8859-1
Date: 11 Nov 2002 15:18:02 +0100
Message-Id: <1037024283.15616.17.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2002-11-11 at 14:55, Andreas Beranek wrote:
> Hello,
>
> > > I am porting Linux on EP405 board. So I use gdbserver and gdb......
>
> > Has anybody tried the bdi2000 is that also broken now ? ....
>
> We encountered similar problems. We got it to work with the BDI2000.
>
> Some hints:
>
> Use the latest Firmware from Abatron.
> Use the latest Tools and Kernel.
> Set the Breakpoint-type to "HARD" in BDI config file.
> Check the MMU setup.
> Avoid setting software breakpoints in FLASH.
>
> Mit freundlichen Grüßen,
>

What version of gdb ?

Is bdi broken for soft breakpoint ?? has it ever worked with soft
breakpoint? I tried to get bdi working once and never got soft
breakpoints to work but I did not spend much time on it I needed to
solve my problem and used printk as usual :(.

Anybody used kgdb ?

--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Borgafjordsgatan 9                Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
