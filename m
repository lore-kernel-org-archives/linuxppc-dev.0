To: Jan Damborsky <jan.damborsky@devcom.cz>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: connecting IDE directly to MPC8xx 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 21 Feb 2003 15:58:44 +0100."
             <3E563EA4.7070207@devcom.cz>
Date: Fri, 21 Feb 2003 16:09:21 +0100
Message-Id: <20030221150926.38C1AC6E0D@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dear Jan,

in message <3E563EA4.7070207@devcom.cz> you wrote:
>
> I am using PPCBoot on my board with MPC823E.
> I am lucky and I ported Linux on this board. All

Congrats!

> works well but I don't know, how to configure
> kernel 2_4_3 form ElinOS v2.0 to work with IDE hard disk connected
> directly to MPC823 bus (utilizing PCMCIA bus signals
> in way PPCBoot does it - in PPCBoot my IDE disk works well).
>
> In kernel 2_4_3 from ElinOS v2.0 I use this options:
> CONFIG_BLK_DEV_MPC8xx_IDE=y
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTIMODE=y
> CONFIG_PARTITION_ADVANCED=y
> CONFIG_MSDOS_PARTITION=y
> CONFIG_BLK_DEV_IDE_MODES=y

These options look OK to me; for another example please see
http://www.denx.de/doc/TQM8xxL/advanced-topics.html#FLASH-DISKS

> But It doesn't work at all. It crashes in do_probe() function,
> when accessing bad memory region. I have mapped all
> PCMCIA regions correctly.
> Is any straightforward way to configure kernel to work with
> this IDE connection ?

Probably the ElinOS kernel does not support this properly.

Feel free to try the kernel from our CVS server which has  been  used
with     such     configurations    in    several    projects.    See
http://www.denx.de/re/linux.html


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
There is a biblical analogy I'd like to draw here.   Casts are to C++
Programmers what the apple was to Eve.         - Scott Douglas Meyers

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
