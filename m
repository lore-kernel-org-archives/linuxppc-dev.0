To: Greg Griffes <ggg@ieee.org>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 7400 mmu_init problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 06 Apr 2002 21:53:44 PDT."
             <20020407045344.GB13833@beef.az.mvista.com>
Date: Sun, 07 Apr 2002 10:08:44 +0200
Message-Id: <20020407080849.80AF111250@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Apr 06, 2002 at 07:47:11PM -0500, Greg Griffes wrote:
>
> The BDI2000 wouldn't work with my hardware for some reason.
> It complained that it could not break on the boot vector.
> Tried it with both hard and soft breaks.  Booting from flash, so,
> maybe that has something to do with it.

This is usually because of an incorrect (not  sufficiently  adjusted)
BDI2000 config file. Pay special attention to the BOOTADDR parameter;
depending   on   your  board  configuration  this  is  0x00000100  or
0xFFF00100. If it is set incorrectly, you may hang the  CPU  and  the
BDI will not work.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Shakespeare's Law of Prototyping: (Hamlet III, iv, 156-160)
        O, throw away the worser part of it,
        And live the purer with the other half.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
