To: Kate Alhola <kate@iti.fi>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_4_mpc5200 / 5200lite zImage 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 02 Nov 2003 14:08:18 +0200."
             <3FA4F3B2.6050106@iti.fi>
Date: Sun, 02 Nov 2003 14:35:11 +0100
Message-Id: <20031102133516.775BEC5F59@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3FA4F3B2.6050106@iti.fi> you wrote:
>
> I just got Motorola5200 lite board and tried complie
> linuxppc_2_4_mpc5200 from
> denx to it.  When i say make bzImage it complains that __res is undefined

Please "make uImage" and use U-Boot as boot loader.

> Also i got Macraigor wiggler but  saddly noticed that ocd-cmdr does not
> yet work with mpc5200. Any expreincies/suggestions with LOW COST
> OCD debugger for 5200 that can be used loading initial code to empty
> flash on my own board.

I recommend to use a BDI2000 - not exactly low cost, but worth  every
cent of it (expecially since you can alo use it for kernel and driver
debugging).

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If there was anything that depressed him more than his own  cynicism,
it was that quite often it still wasn't as cynical as real life.
                                 - Terry Pratchett, _Guards! Guards!_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
