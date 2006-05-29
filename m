Return-Path: <jourdan@enib.fr>
Received: from alto.enib.fr (alto.enib.fr [195.221.233.5])
	by ozlabs.org (Postfix) with ESMTP id 861D3679FC
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 May 2006 20:25:27 +1000 (EST)
Message-ID: <1758.194.3.133.184.1148897976.squirrel@webmail.enib.fr>
In-Reply-To: <20060529091257.686CB3525D9@atlas.denx.de>
References: Your message of "Mon, 29 May 2006 09:34:00 +0200."            
	<1402.194.3.133.184.1148888040.squirrel@webmail.enib.fr>
	<20060529091257.686CB3525D9@atlas.denx.de>
Date: Mon, 29 May 2006 12:19:36 +0200 (CEST)
Subject: Re: Can't get CoralP drivers to work
From: jourdan@enib.fr
To: "Wolfgang Denk" <wd@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
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

> In message <1402.194.3.133.184.1148888040.squirrel@webmail.enib.fr> you
> wrote:
>>
>> This seems ok to me but I don't have any video signal. My screen remains
>> blank.
>
> What's your boot arguments? Where is  your  console  device,  on  the
> serial port or on the frame buffer?

My boot arguments :
# more /proc/cmdline
console=tty0 console=ttyS1,9600 devfs=mount ip=bootp root=/dev/nfs rw

My console is on the serial port (ttyS1 on SMC2).

>> xf86OpenConsole: Cannot open /dev/tty0 (No such file or directory)
>> ...
>
> Did you enable all of the following options in your kernel config?
>
> 	CONFIG_FB=y
> 	CONFIG_DUMMY_CONSOLE=y
> 	CONFIG_FB_MB86290=y
> 	CONFIG_FBCON_ADVANCED=y
> 	CONFIG_FBCON_CFB16=y
> 	CONFIG_FBCON_FONTS=y
> 	CONFIG_FONT_8x8=y
> 	CONFIG_FONT_8x16=y
> 	CONFIG_VT=y
> 	CONFIG_VT_CONSOLE=y
>
> My guess is that CONFIG_VT and/or CONFIG_VT_CONSOLE might be missing.

All those options are enabled.
