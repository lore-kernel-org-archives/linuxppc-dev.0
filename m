Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by ozlabs.org (Postfix) with ESMTP id 1726667A2E
	for <linuxppc-dev@ozlabs.org>; Thu,  5 May 2005 14:47:38 +1000 (EST)
Date: Wed, 4 May 2005 21:47:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20050505044737.GY1221@smtp.west.cox.net>
References: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
	<466e699745cf24e660e296530f6e34dc@embeddededge.com>
	<17017.16478.767293.191940@cargo.ozlabs.ibm.com>
	<45e21c1ae2899849665fb894a2adcc20@embeddededge.com>
	<17017.39523.745634.193331@cargo.ozlabs.ibm.com>
	<20050505041225.GX1221@smtp.west.cox.net>
	<17017.42136.824607.253146@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17017.42136.824607.253146@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Set cpu explicitly in kernel compiles
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 05, 2005 at 02:44:08PM +1000, Paul Mackerras wrote:
> Tom Rini writes:
> 
> > So here's where the confusion comes in.  You're saying that even though
> > (except .S files) no ppc32 kernel config was passing in explicit
> > -mcpu=... or similar, only CONFIG_6xx is hurt by the gcc4 biarch thingy?
> 
> Indeed, we were never using -mcpu, and maybe we should be.
> 
> The problem only comes up if you configure gcc4 as biarch.  I can't
> imagine anyone building a biarch compiler for 4xx or 8xx. :)

I can, quite easily.  Think someone like Dan doing dev from their nice
shiney G5.

> Alan Modra tells me that gcc4 can support all the ppc families in the
> one binary, and that you can specify what cpu to use as the assumed
> default at configure time.  If you specify --with-cpu=xxx at configure
> time you get scheduling for that particular cpu.
> 
> So yes, only CONFIG_6xx is affected by biarch gcc4 assuming POWER4.
> Other families would only be affected if you were using a generic
> gcc4, which won't work at present anyway, since we don't add
> -mcpu=xxx.

Why won't it work with generic gcc4 ?  Will something more than a lot of
extra nops be added?

-- 
Tom Rini
http://gate.crashing.org/~trini/
