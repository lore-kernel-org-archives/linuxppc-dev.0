To: "Brian Padalino" <bpadalino@perigee.com>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: U-Boot, tftp and PCI ethernet 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 25 Jul 2003 08:10:49 EDT."
             <DGEEIPOFGGPOACEFBGGCGEJFCAAA.bpadalino@perigee.com>
Date: Fri, 25 Jul 2003 15:14:43 +0200
Message-Id: <20030725131448.E7A9AC602D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <DGEEIPOFGGPOACEFBGGCGEJFCAAA.bpadalino@perigee.com> you wrote:
>
> Does U-Boot support booting over ethernet controllers found on the PCI bus,

Your question has nothing to do with embedded linux and is  thus  off
topic on this list.

Please post U-Boot related quuestions  to  the  u-boot-users  mailing
list instead.

Yes, U-Boot can use PCI based network  cards  if  there  is  (1)  PCI
support  for  your  board  and  (2) an U-Boot ethernet driver for the
network card

> specifically I am wondering how hard it would be to boot from an Intel e1000
> ethernet controller rather than the on-chip ethernet on my Ebony board.

It's not hard at all. An e1000 driver has been ported to U-Boot.

> Has anyone had experience with this, or can point me in the right direction
> on where to look to write some simple drivers to support transfers from the
> e1000 card, that would be great.

See the drivers/ directory in the U-Boot source code.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Weekends were made for programming.                 - Karl Lehenbauer

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
