To: Jan Damborsky <jan.damborsky@devcom.cz>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Console on frame buffer for mpc823 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 06 Aug 2003 12:17:32 +0200."
             <3F30D5BC.9070400@devcom.cz>
Date: Wed, 06 Aug 2003 12:50:31 +0200
Message-Id: <20030806105036.D6EDEC59E4@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dear Jan,

in message <3F30D5BC.9070400@devcom.cz> you wrote:
>
> primarily thank you for your help. But I have not
> been lucky to solve my problem. May be I have
> old kernel version - 2.4.3.

We did most of the framebuffer related work  with  our  2.4.4  kernel
tree;  I  don't  know  if older kernel versions have problems in that
area, but it's easily possible.

> I have set all this CONFIGS_xxx except for CONFIG_CONSOLE_NOBLANK and
> CONFIG_CONSOLE_NOCUR which are not supported in this kernel version.

These are extensions in our kernel tree to avoid  a  blinking  cursor
and  the  default  screen  blank  which  is not what you want on most
embedded systems.

> How to test that frame buffer is assigned to text console ?

Do you see the penguin logo when booting?

> [1] CONFIG_SERIAL_CONSOLE is set - it is hardwired
>      to CONFIG_8xx - may be it is problem - isn't it ?

This is OK.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
All men should freely use those seven words which have the  power  to
make any marriage run smoothly: You know dear, you may be right.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
