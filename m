To: "somshekar chandrashekar kadam" <ppclinux@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ramdisk image start not initialisied 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "12 Jun 2002 10:00:16 -0000."
             <20020612100016.15037.qmail@webmail25.rediffmail.com>
Date: Wed, 12 Jun 2002 12:29:14 +0200
Message-Id: <20020612102919.DE382102F8@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Somshekar,

in message <20020612100016.15037.qmail@webmail25.rediffmail.com> you wrote:
>
> i think i am not attaching proper ramdisk image
> any idea where can i get ramdisk image for 8260 or
> what should i do

I've put a PPCBoot ramdisk image for MPC8260  systems  for  our  SELF
configuration  (see  ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SELF/) on
our FTP server, see
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/pRamdisk.8260

To strip the PPCBoot header for a raw compressed  ramdisk  image  use
something like this:

	dd if=pRamdisk.8260 of=initrd.gz bs=64 skip=1

Hope this helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The IQ of the group is the lowest IQ of a member of the group divided
by the number of people in the group.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
