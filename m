Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 80702679E9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 May 2006 19:13:00 +1000 (EST)
To: jourdan@enib.fr
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Can't get CoralP drivers to work 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 29 May 2006 09:34:00 +0200."
	<1402.194.3.133.184.1148888040.squirrel@webmail.enib.fr>
Date: Mon, 29 May 2006 11:12:57 +0200
Sender: wd@denx.de
Message-Id: <20060529091257.686CB3525D9@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <1402.194.3.133.184.1148888040.squirrel@webmail.enib.fr> you wrote:
>
> This seems ok to me but I don't have any video signal. My screen remains
> blank.

What's your boot arguments? Where is  your  console  device,  on  the
serial port or on the frame buffer?

> xf86OpenConsole: Cannot open /dev/tty0 (No such file or directory)
> ...

Did you enable all of the following options in your kernel config?

	CONFIG_FB=y
	CONFIG_DUMMY_CONSOLE=y
	CONFIG_FB_MB86290=y
	CONFIG_FBCON_ADVANCED=y
	CONFIG_FBCON_CFB16=y
	CONFIG_FBCON_FONTS=y
	CONFIG_FONT_8x8=y
	CONFIG_FONT_8x16=y
	CONFIG_VT=y
	CONFIG_VT_CONSOLE=y

My guess is that CONFIG_VT and/or CONFIG_VT_CONSOLE might be missing.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"There is no distinctly American criminal class except Congress."
- Mark Twain
