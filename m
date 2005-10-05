Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 672896847D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Oct 2005 22:23:41 +1000 (EST)
Message-ID: <4343C5CB.2040006@ru.mvista.com>
Date: Wed, 05 Oct 2005 16:23:39 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: KokHow Teh <KokHow.Teh@marconi.com>
References: <OF0BB1D8FC.27908478-ON48257091.000E28F8@uk.marconicomms.com>
In-Reply-To: <OF0BB1D8FC.27908478-ON48257091.000E28F8@uk.marconicomms.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: david.jander@protonic.nl,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: serial console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

KokHow Teh wrote:
> Hi;
>       I have tried with 4 types of command lines with my linux kernel with
> devfs and serial device compiled in and none gives me the desired results:
> 
> (1)   console=tts/0,115200n8 OR console=ttyCPM0,115200n8
> 
>       no serial console output at all during boot time but it gives me
> login prompt at the end.
> 
> (2)   without "console=" OR console=ttyS0,115200n8
> 
>       serial console output fine during bootup but only until the point
> when it prints out "Freeing unused kernel memory: 232k init 4k prep". After
> that, the serial console output is garbled. No login prompt.
> 
>       So this has not solved my problem. I need more advice. Here are some
> more questions and observations:
> 
> (1)   David Jander's comment:
> 
> I don't know exactly what I am talking about right now, but the string
> "tts/0"
> in the console-line sounds suspicious to me. AFAIK when using devfs still
> device names on the kernel-commandline have to be old-style.
> Just a guess: try using "console=ttyS0,115200n8" and see if this helps.
> 
>       Is it confirmed that kernel-commandline has to be old-style even
> though the kernel is using devfs?
> 
> (2)   Vitaly Bordug's suggestion of using "console=ttyCPM0". May I know
> where is ttyCPM0 defined and how is it bound to the serial console device
> driver in the source?
> 
Ummm.. The driver itself is in drivers/serial/cpm_uart. It does have the 
different major than ordinary ttyS... This relates to the 2.6.x kernel 
of course. I could suggest you to try the latest kernel.org release, in 
which you board is known to work fine.

>       Thanks for any input and pointer.
> 
> Regards,
> TEH
> 
> 
> 


-- 
Sincerely,
Vitaly
