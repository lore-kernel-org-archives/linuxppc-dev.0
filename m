To: "sun-zj" <sun-zj@tdk-tech.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: how to Compile linuxppc 2.5 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 07 Feb 2004 12:22:55 +0800."
             <20040207042455.C5FFD42EB0@denx.de>
Date: Sat, 07 Feb 2004 11:15:27 +0100
Message-Id: <20040207101532.DC73BC109B@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20040207042455.C5FFD42EB0@denx.de> you wrote:
>
> Sorry for wrong information, I get the linuxppc_2.5 from
> bk://ppc.bkbits.net/linuxppc-2.5 not from Denx.:(  But I want to know
> whether I can make  kernel from the source even if it is not from your
> sites. When I make the FADS_config, It complains the no FADS_config rules

Of course you can use the ELDK to compile _any_ kernel source tree.

> exist, but the directory arch/ppc/configs has FADS_config.

Many things have changed in 2.5/2.6. Please try:

	-> make ARCH=ppc CROSS_COMPILE=ppc_8xx- FADS_defconfig
	-> make ARCH=ppc CROSS_COMPILE=ppc_8xx- uImage

But don't expect that this will actually work.

Even with the latest version (2.6.2) will end  up  with  errors  like
this:

arch/ppc/kernel/ppc_ksyms.c:351: `request_8xxirq' undeclared here (not in a function)
arch/ppc/kernel/ppc_ksyms.c:351: initializer element is not constant
arch/ppc/kernel/ppc_ksyms.c:351: (near initialization for `__ksymtab_request_8xxirq.value')


> another question how can I get linuxppc_2_5 from your sites?

At the moment you cannot. We don't support this  yet.  IMHO  the  2.6
kernel is not ripe yet for real-life use.

> Thanks very much for your great works on PPC!!!

You are welcome.

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Each honest calling, each walk of life, has its own  elite,  its  own
aristocracy based on excellence of performance. - James Bryant Conant

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
