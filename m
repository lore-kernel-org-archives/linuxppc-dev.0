To: laurent.pinchart@capflow.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8xx IDE 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 24 Oct 2001 13:47:25 +0200."
             <3BD6AA4D.1050502@capflow.com>
Date: Wed, 24 Oct 2001 14:04:53 +0200
Message-Id: <20011024120458.1F51110CD8@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3BD6AA4D.1050502@capflow.com> you wrote:
>
> While trying to find an easy way to add non-volatile storage on a
> custion MPC860 board, I noticed that there was some support for IDE on
> the PCMCIA interface in the Linux kernel.

The IDE support on 8xx has become  even  more  universal  in  current
kernels  (linuxppc_2_4_devel);  basicly  you have 3 options - quoting
from "Configure.help":

...
Type of MPC8xx IDE interface
CONFIG_IDE_8xx_PCCARD
  Select how the IDE devices are connected to the MPC8xx system:

  8xx_PCCARD uses the 8xx internal PCMCIA interface in combination
             with a PC Card (e.g. ARGOSY portable Hard Disk Adapter),
             ATA PC Card HDDs or ATA PC Flash Cards (example: TQM8xxL
             systems)

  8xx_DIRECT is used for directly connected IDE devices using the 8xx
             internal PCMCIA interface (example: IVMS8 systems)

  EXT_DIRECT is used for IDE devices directly connected to the 8xx
             bus using some glue logic, but _not_ the 8xx internal
             PCMCIA interface (example: IDIF860 systems)
...


> Does anyone know where I can find more information about that ? There

Ask me :-)

> seems to be a board (IVMS8) with such an IDE interface, but I haven't
> been able to find anything about it on the web.

Again quoting from "Configure.help":

...
  TQM823L:
  TQM850L:
  TQM855L:
  TQM860L:
    MPC8xx based family of mini modules, half credit card size,
    up to 64 MB of RAM, 8 MB Flash, (Fast) Ethernet, 2 x serial ports,
    2 x CAN bus interface, ...
      Manufacturer: TQ Components, www.tq-group.de
      Date of Release: October (?) 1999
      End of Life: not yet :-)
      URL:
      - module: http://www.denx.de/PDF/TQM8xxLHWM201.pdf
      - starter kit: http://www.denx.de/PDF/STK8xxLHWM201.pdf
      - images: http://www.denx.de/embedded-ppc-en.html
...
  IVMS8:
    MPC860 based board used in the "Integrated Voice Mail System",
    Small Version (8 voice channels)
    Manufacturer: Speech Design, http://www.speech-design.de/
    Date of Release: December 2000 (?)
    End of life: -
    URL: http://www.speech-design.de/
...

There is no entry for the IDIF boards yet, sorry - mea culpa.

Send mail to wd@denx.de for more details.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Go to Heaven for the climate, Hell for the company."    - Mark Twain

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
