To: "Richard Williams" <richard_williams@stratexnet.com>
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Disabling the serial console upsets CPM UARTS 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 05 Aug 2004 09:34:19 +1200."
             <A3240F62EF3C2749B1A25D3BC9548F4148BC29@ExchWENZ02.wenz.global.vpn>
Date: Thu, 05 Aug 2004 00:47:36 +0200
Message-Id: <20040804224741.4BDEBC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <A3240F62EF3C2749B1A25D3BC9548F4148BC29@ExchWENZ02.wenz.global.vpn> you wrote:
>
> I have seen some questions in the archive about people wanting to disable the serial console but not many answers.

Maybe there ius little to answer?

> We have a custom 860T product running a modified 2.4.4 kernel. The console was disabled by excluding some code in printk.c and this has resulted in strange effects with the CPM UART driver.

Why don't you just pass a "console=null" boot argument?

> My questions are
> 1. Is there a better way to disable the serial console (or even better, allow the kernel parameter 'console=' to switch it on of off)?

Yes, of course there is. "console=null" is all you need.

> 2. If the console port can be changed by the 'console=' parameter, what is the purpose of the compile time configuration and selection of a console port in uart.c?

To set up a default console when no console=... boot argument is present?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"If people are good only because they fear punishment, and  hope  for
reward, then we are a sorry lot indeed."            - Albert Einstein

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
