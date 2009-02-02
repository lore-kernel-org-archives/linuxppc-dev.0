Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id E9850DDF35
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Feb 2009 19:24:43 +1100 (EST)
Date: Mon, 2 Feb 2009 09:24:36 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Remis <remis.developer@googlemail.com>
Subject: Re: Dynamic-ftrace not working in PlayStation3
In-Reply-To: <a25370a30902010528l2c11444ch843da0bfd91d05f@mail.gmail.com>
Message-ID: <alpine.LRH.2.00.0902020922450.12201@vixen.sonytel.be>
References: <a25370a30901260639u3ab97112qf6688667d39e6706@mail.gmail.com>
	<alpine.DEB.1.10.0901292234520.6222@gandalf.stny.rr.com>
	<4983BFA2.9010703@am.sony.com> <200901311125.34755.arnd@arndb.de>
	<a25370a30902010528l2c11444ch843da0bfd91d05f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Steven Rostedt <rostedt@goodmis.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 1 Feb 2009, Remis wrote:
> Complementing what Arnd said, we got the dynamic ftrace to work. Just
> changed 4 things in the *menuconfig*.
> Before these were built as modules (this is the default I guess):
> CONFIG_USB=m
> CONFIG_SOUND=m
> CONFIG_SND=m
> CONFIG_SND_USB_AUDIO=m
> 
> Then got them built into the kernel:
> CONFIG_USB=y
> CONFIG_SOUND=y
> CONFIG_SND=y
> CONFIG_SND_USB_AUDIO=y
> 
> And everything worked just fine.
> In my config when I also tried to build the *CONFIG_SND_PS3* into the
> kernel, the kernel did not boot (probably another bug !? :-).

JFYI, I always use CONFIG_SND_PS3=y in my PS3 kernels, so it should work.
Probably it conflicts with something else I have not enabled...

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
