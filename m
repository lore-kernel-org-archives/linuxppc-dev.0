To: srinivas jandhyala <jandhyala_99@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: u-boot on MPC5200 in loop 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 10 May 2004 00:49:00 PDT."
             <20040510074900.31620.qmail@web12308.mail.yahoo.com>
Date: Mon, 10 May 2004 10:25:12 +0200
Message-Id: <20040510082517.00DC4C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20040510074900.31620.qmail@web12308.mail.yahoo.com> you wrote:
>
> I am trying to bringup Linux on MPC5200 LITE

Please post U-Boot related questions to the U-Boot maling list, not here.

> When I tried to use u-boot from flash in lowboot mode
> I see the following ouput on my console repeatedly.
> Any help is appreciated. Thanks in advance.
>
> U-Boot 1.1.0 (May 10 2004 - 08:02:56)
>
> CPU:   MPC5200 (JTAG ID 0001101d) at 396 MHz
>        Bus 132 MHz, IPB 66 MHz, PCI 33 MHz
> Board: Motorola MPC5200 (IceCube)
> I2C:   85 kHz, ready
> DRAM:

That means that there are problems with the SDRAM  initialization  on
your  board.  Please  make  sure  to use the latest version of U-Boot
(top-of-tree in CVS, or  at  least  version  1.1.1)  which  has  some
problems fixed.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Nothing ever becomes real until it is experienced.       - John Keats

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
