To: greggiraud@netcourrier.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: use bdi2000 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 15 Jul 2003 09:38:09 EST."
             <mnet1.1058254689.18246.greggiraud@netcourrier.com>
Date: Tue, 15 Jul 2003 10:05:17 +0200
Message-Id: <20030715080522.3F506C6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <mnet1.1058254689.18246.greggiraud@netcourrier.com> you wrote:
>
> Even when I use MMU XLAT, I  can't see the values of a skbuf, in net/core/dev.c (netif_rx) with DDD and BDIGDB
> I don't know what to do.

Read the BDI2000 manual, especially  the  section  about  the  PTBASE
config parameter.

> I someone help me: I have a big issue with a AM29DL323GbB flash, I can read it, but can't erase or program it from ram whith ppcboot.

Who ported PPCBoot to your hardware? Complain  to  him  that  he  has
introduced a bug in the flash driver.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
F u cn rd ths u cnt spl wrth a dm!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
