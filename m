To: "Navin Boppuri" <navin.boppuri@newisys.com>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Flash Driver 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 13 Aug 2001 17:09:03 CDT."
             <3A494DE356A49A40B37442E1E0D9F3B5063418@ptah.ad.newisys.com>
Date: Tue, 14 Aug 2001 00:28:44 +0200
Message-Id: <20010813222849.BA24310CBA@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3A494DE356A49A40B37442E1E0D9F3B5063418@ptah.ad.newisys.com> you wrote:
>
> Can someone tell me how to set up and use the flash driver in the 2.4.x
> Linux kernel. I see a CFI and non-CFI support for the AMD flash chips. I

You mean the driver we maintain?

> am using an AMD flash chip on my board. Which one of the drivers do I
> load? How are these initialized?

For AMD chips, configure:

	CONFIG_FLASH=y
	CONFIG_AMD_FLASH=y

Add a "partition" scheme for your board to "drivers/char/flash_config.c";
see the comment in this file.

There is no more configuration needed (assuming you are booting  from
PPCBoot, which will pass the necessary parameters to the Linux kernel
[physical start address and size of the flash memory]).

> I have not been able to find any documentation on this. Any help is very
> appreciated.

Just ask :-)

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Q: How do you spell "onomatopoeia"?
A: The way it sounds.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
