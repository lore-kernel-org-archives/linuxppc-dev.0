To: Jan Damborsky <jan.damborsky@devcom.cz>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Console on frame buffer for mpc823 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 06 Aug 2003 10:40:31 +0200."
             <3F30BEFF.9060207@devcom.cz>
Date: Wed, 06 Aug 2003 11:00:37 +0200
Message-Id: <20030806090042.4CF44C59E4@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dear Jan,

in message <3F30BEFF.9060207@devcom.cz> you wrote:
>
> I use custom board with MPC823 and TFT display
> connected directly to TFT processor interface.
> I would like to use display as console on framebuffer
> when booting and running Linux.
...
> How to make kernel use console on /dev/fb/0 ?

You have to configure the kernel to use the  framebuffer  as  console
device. Check especially the following configuration options:

	CONFIG_FB=y
	CONFIG_DUMMY_CONSOLE=y
	CONFIG_FBCON_ADVANCED=y
	CONFIG_FBCON_CFB8=y
	CONFIG_FBCON_FONTS=y
	CONFIG_FONT_8x8=y
	CONFIG_FONT_8x16=y
	CONFIG_VT=y
	CONFIG_VT_CONSOLE=y
	CONFIG_CONSOLE_NOBLANK=y
	CONFIG_CONSOLE_NOCUR=y

Also, see the FAQ at
http://www.denx.de/twiki/bin/view/DULG/NoInputUsingFramebuffer

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I'd like to meet the man who invented sex and see what  he's  working
on now.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
