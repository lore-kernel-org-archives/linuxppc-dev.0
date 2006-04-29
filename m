Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 3CF8B679E2
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 10:32:34 +1000 (EST)
To: Tom Rini <trini@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: FT u-boot shim 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 28 Apr 2006 16:22:11 PDT."
	<20060428232211.GE458@smtp.west.cox.net>
Date: Sat, 29 Apr 2006 02:32:32 +0200
Sender: wd@denx.de
Message-Id: <20060429003232.9926C353DAC@atlas.denx.de>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <20060428232211.GE458@smtp.west.cox.net> you wrote:
>
> You wouldn't have the dtb combined in the kernel image, unless you have
> the shim.   This is instead of loading a separate dtb anyhow.

Now you got me completely confused. [Maybe I should go to bed.]

Kumar wrote:

> What I envision as the way one boots for something like u-boot is one  
> of three options:
> 1. using an old u-boot + boot wrapper (bd_t -> wrapper -> kernel)
> 2. using a u-boot that is ft aware + dtb (boot command in u-boot  
> takes kernel & dtb images, updates blob and passes to kernel)
> 3. using a u-boot that is ft aware + built in dtb.

In my understanding, 1. is with a shim; 2. is loading a separate  dtb
(probably  as  multi-file  image), and 3. is when U-Boot provides the
dtb. Am I missing something?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If you fail to plan, plan to fail.
