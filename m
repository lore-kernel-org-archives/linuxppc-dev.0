Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 02035679F0
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 05:19:59 +1000 (EST)
To: Kumar Gala <galak@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: FT u-boot shim 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 26 Apr 2006 09:37:09 CDT."
	<A8793E99-83C1-4FD9-8735-D2E8F98B3003@kernel.crashing.org>
Date: Wed, 26 Apr 2006 21:19:57 +0200
Sender: wd@denx.de
Message-Id: <20060426191957.14C4F353DAC@atlas.denx.de>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <A8793E99-83C1-4FD9-8735-D2E8F98B3003@kernel.crashing.org> you wrote:
> 
> I think thats part of the idea with arch/powerpc defining a standard  
> mechanism for how a boot loader should pass information to the kernel  
> (via a flat device tree).

Yet another standard.

> How would you propose that we handle booting arch/powerpc kernels  
> from u-boot going forward? (for new board ports and existing board  
> ports).

Ideally, I'd like to see a common kernel  interface  for  all  archi-
tectures,  PowerPC  and ARM and MIPS and ... But last time I dared to
suggest this I've been told what a nincompoop I am.

I will accept what is decided by the P.T.B., but  I  request  not  to
break backwards compatibility with existing systems.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Monday is an awful way to spend one seventh of your life.
