To: iida <iida@ztec.com.br>
Cc: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: driver SPI for MPC5200 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 01 Jun 2004 11:18:21 -0300."
             <40BC902D.7080804@ztec.com.br>
Date: Tue, 01 Jun 2004 19:37:58 +0200
Message-Id: <20040601173804.04313C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <40BC902D.7080804@ztec.com.br> you wrote:
>
> i am tring to find a driver SPI for MPC5200.
> In  linuxppc-2.4.25-denx
> there is cpm_spi.c in arch/ppc/8260_io
> It can be used in mpc5200 ?

No, it cannot. It's a driver for the MPC8260's CPM; the MPC5200  does
not have such a thing.

> Or what i have to modify to use in mpc5200

You need to write a new driver.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"It ain't so much the things we don't know that get  us  in  trouble.
It's  the  things  we know that ain't so." - Artemus Ward aka Charles
Farrar Brown

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
