Return-Path: <wd@denx.de>
Received: from mailout01.sul.t-online.com (mailout01.sul.t-online.com
	[194.25.134.80]) by ozlabs.org (Postfix) with ESMTP id 9AF572BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Nov 2004 08:10:43 +1100 (EST)
To: Conn Clark <clark@esteem.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 09 Nov 2004 09:27:59 PST."
	<4190FE1F.4080105@esteem.com>
Date: Tue, 09 Nov 2004 20:51:36 +0100
Sender: wd@denx.de
Message-Id: <20041109195141.82111C1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: How much easier makes owning a BDI2000 things? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <4190FE1F.4080105@esteem.com> you wrote:
>
> 	Its worth it weight in gold bringing up custom boards the first time 
> and writing/debuging the boot rom. It allows you to change register 

... or when debugging the Linux kernel, device drivers and especially
RTAI real-time modules (because you can really freeze the CPU  state,
including timers etc.).

> 	We haven't used ours much for debugging once things were up and 
> running(we have fallen back to using printk statements for debugging). 
> Though it can be used for that and some core kernel developers do use 
> it. (probably for debugging the printk code of the kernel  ;-)  )

Seems you never had to deal with any time critical problems, then.


Best regards,

Wolfgang Denk

-- 
See us @ Embedded/Electronica Munich, Nov 09 - 12, Hall A.6 Booth 513
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Name one thing windows is better than unix in?
                                          Making money for Microsoft?
         -- Randal L. Schwartz in <8cvi5t4c3t.fsf@gadget.cscaper.com>
