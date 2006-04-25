Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 1565567A77
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 07:39:57 +1000 (EST)
To: Kumar Gala <galak@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: FT u-boot shim 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 25 Apr 2006 16:33:11 CDT."
	<07A76292-03D1-4648-AA40-11E06698FEE1@kernel.crashing.org>
Date: Tue, 25 Apr 2006 23:39:55 +0200
Sender: wd@denx.de
Message-Id: <20060425213955.B9960352B18@atlas.denx.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <07A76292-03D1-4648-AA40-11E06698FEE1@kernel.crashing.org> you wrote:
> 
> > Since U-Boot  does  not  need  nor  use  this  information  for  it's
> > operation, but the kernel does, it should be part of the kernel.
> 
> What about the case in which u-boot already has a .dts for a given  
> board?  Should we duplicate the files between the kernel & u-boot?

No. Remove them from the U-Boot tree. I was never happy to  see  this
stuff there.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Don't panic.
