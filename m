Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id 3C0ED67B36
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Apr 2005 01:57:27 +1000 (EST)
Date: Fri, 8 Apr 2005 08:57:17 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christian <evilninja@gmx.net>
Message-ID: <20050408155717.GB3396@smtp.west.cox.net>
References: <20050331142813.GH25923@smtp.west.cox.net>
	<20050331184549.GA28069@pegasos> <4251D5BA.5080905@gmx.net>
	<20050405053930.GD4604@pegasos>
	<20050405143802.GS25923@smtp.west.cox.net>
	<42533FA1.1070001@gmx.net>
	<20050406185049.GF3396@smtp.west.cox.net>
	<33467.82.10.231.190.1112960162.squirrel@82.10.231.190>
	<20050408145431.GY3396@smtp.west.cox.net> <4256A88C.70101@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4256A88C.70101@gmx.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: PREP sym53c8xx sym53c8xx brokeness due
	to	2.6.9-rc1-bk1	introduced residual data patch ...
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 08, 2005 at 05:51:40PM +0200, Christian wrote:
> Tom Rini wrote:
> > 
> > If this works, I'd like to see this get into 2.6.12.  Please re-send to
> > akpm / this list.  Assuming it's just the above:
> > Acked-by: Tom Rini <trini@kernel.crashing.org>
> 
> yes! i just applied Leigh's patch (thanks!) to a pristine 2.6.11.6 and my
> PReP here booted fine:
>   http://www.nerdbynature.de/bits/hal/2.6.11.6/leigh/

Great.  Leigh, can you also submit to gregkh for 2.6.11.7?  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
