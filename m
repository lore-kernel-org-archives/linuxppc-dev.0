Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de (vs166246.vserver.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 464C4DDDF8
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Dec 2007 08:23:54 +1100 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH] Do not fail build if mkimage is not available
Date: Sun, 23 Dec 2007 22:21:34 +0100
References: <200712232031.09133.mb@bu3sch.de>
	<20071223140516.4fed7dd0@vader.jdub.homelinux.org>
In-Reply-To: <20071223140516.4fed7dd0@vader.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712232221.35183.mb@bu3sch.de>
Cc: linuxppc-dev@ozlabs.org, paulus@au.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 23 December 2007 21:05:16 Josh Boyer wrote:
> On Sun, 23 Dec 2007 20:31:08 +0100
> Michael Buesch <mb@bu3sch.de> wrote:
> 
> > This fixes the boot image wrapper script to not fail the kernel
> > build if mkimage is not available.
> > As some distributions don't ship the mkimage program and I am not
> > interested in uboot images anyway, I don't want to fail the whole kernel
> > build process because of this unneeded dependency.
> > 
> > Simply drop an error message, but don't fail the build.
> 
> This is probably OK for now, but I'm working on getting mkimage merged
> into the kernel so it will just get ripped back out later if I'm
> successful.

Yeah, cool. I am fine with this. :)

I just don't want to install a tool into my operating system that
I do not need. Shipping it with the kernel is the best option.

-- 
Greetings Michael.
