Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id B25A5679F6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Feb 2006 07:15:07 +1100 (EST)
To: =?iso-8859-1?B?Qmr2cm4g1nN0Ynk=?= <Bjorn.Ostby@combitech.se>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: SCCx UART status on 8xx 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 20 Feb 2006 14:37:23 +0100."
	<004B1D7A5257174C9044A1B7BD0E60ED0178CC4F@ratatosk.combitechsystems.com>
Date: Mon, 20 Feb 2006 21:15:04 +0100
Sender: wd@denx.de
Message-Id: <20060220201504.C5289353C11@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <004B1D7A5257174C9044A1B7BD0E60ED0178CC4F@ratatosk.combitechsystems.com> you wrote:
>
> I'm messing with a mpc823e based board trying to enable the SCC3 UART. I'm using the 2.4.25 denx linux_ppc kernel and I've got SMC1 for console and SMC2 up and running but I'm in desperate need of another rs232 port (which is on SCC3 on my board). 
> Reading quite a lot of old posts on this mailing list got me confused whether the SCCx UART support in the kernel is ready to be used on 8xx or if there will take a large amount of hacking to get things going (reading the header of 8xx_io/uart.c got me 
> wondering even more).

All UARTS (up to 2 x SMC + 4 x SCC, depending on CPU  model)  can  be
used with our tree, including hardware handshake.

> I've read some posts saying that Linux don't init other uart ports than the console port and that is the potential problem here, but it is unclear if this statement is true or not. I can also add to the problem description that my SMC2 port works fine f
> or writing, but reading just hangs in the read() call. So, can anyone confirm any status on the SMCx and SCCx UART drivers for 2.4?

Works fine on all board supported by us.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The C-shell doesn't parse. It adhoculates.
    - Casper.Dik@Holland.Sun.COM in <3ol96k$b2j@engnews2.Eng.Sun.COM>
