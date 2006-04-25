Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 6E3F667A5F
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 08:28:43 +1000 (EST)
To: Kumar Gala <galak@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: FT u-boot shim 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 25 Apr 2006 16:42:47 CDT."
	<DAD4396E-7458-471C-8150-9DDCD396BA63@kernel.crashing.org>
Date: Wed, 26 Apr 2006 00:28:41 +0200
Sender: wd@denx.de
Message-Id: <20060425222841.C2D0E353DAC@atlas.denx.de>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <DAD4396E-7458-471C-8150-9DDCD396BA63@kernel.crashing.org> you wrote:
> 
> > No. Remove them from the U-Boot tree. I was never happy to  see  this
> > stuff there.
> 
> Then why did you accept the patches for them?  I'm confused on what  

Because I  had  neither  time  nor  nerves  to  discuss  with  kernel
maintainers how this could be done. Several people asked me again and
again  to  accept  these  patches  because  they  were  vital for FDT
support, so I gave in.

> you see as the solution for how to boot an arch/powerpc kernel going  
> forward.

I strongly agree with Dan and Eugene: the kernel should not depend on
any specific version of a boot loader, and more general not  even  on
any specific boot loader at all.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Any sufficiently advanced technology is indistinguishable from magic.
Clarke's Third Law       - _Profiles of the Future_ (1962; rev. 1973)
                  ``Hazards of Prophecy: The Failure of Imagination''
