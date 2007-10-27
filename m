Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de
	(static-ip-62-75-166-246.inaddr.intergenia.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A9BEADDED9
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 23:02:11 +1000 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: arch/powerpc/boot/wrapper broken
Date: Sat, 27 Oct 2007 15:01:04 +0200
References: <200710271442.50158.mb@bu3sch.de>
	<20071027165549.3288d76e@kernel.crashing.org>
In-Reply-To: <20071027165549.3288d76e@kernel.crashing.org>
MIME-Version: 1.0
Message-Id: <200710271501.04917.mb@bu3sch.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 27 October 2007 14:55:49 Vitaly Bordug wrote:
> On Sat, 27 Oct 2007 14:42:49 +0200
> Michael Buesch wrote:
> 
> > It calls the "mkimage" command, which does not exist
> > in my $PATH.
> > 
> well, mkImage is a part of u-boot and there was some talk to make it part of kernel too,
> since it does not take alot of place but still mandatory for a number of platforms to work.
> 
> I think, Paul will clarify the details, meanwhile you can install mkImage say building u-boot, and
> some distros may have such a package.
> 

Ubuntu doesn't seem to, though.

In any case, I think that the name "mkimage" is bad for a tool installed
globally in /usr. Does it make a iso9660 image? (No it doesn't, I know :) )

I'd vote for shipping it with the kernel in /scripts or something like that.

-- 
Greetings Michael.
