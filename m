Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 3EED3679FF
	for <linuxppc-dev@ozlabs.org>; Thu,  5 May 2005 14:12:28 +1000 (EST)
Date: Wed, 4 May 2005 21:12:25 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20050505041225.GX1221@smtp.west.cox.net>
References: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
	<466e699745cf24e660e296530f6e34dc@embeddededge.com>
	<17017.16478.767293.191940@cargo.ozlabs.ibm.com>
	<45e21c1ae2899849665fb894a2adcc20@embeddededge.com>
	<17017.39523.745634.193331@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17017.39523.745634.193331@cargo.ozlabs.ibm.com>
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

On Thu, May 05, 2005 at 02:00:35PM +1000, Paul Mackerras wrote:
> Dan Malek writes:
> 
> > The only reason I mentioned it is the "new" default behavior of the
> > compiler is appropriate for only a very small subset of the cores,
> 
> Subset of which set of cores?  Do you mean "small subset of 6xx cores"
> or "small subset of PPC cores"?  I didn't change anything for non-6xx
> cores except to take out -mstring (if you really want that back, say
> so :).  If you mean "small subset of 6xx cores" then are you objecting
> to the specific choice of "-mcpu=603 -mtune=7450", or what?
> 
> > My concern wasn't specifically for which options I wanted, but
> > rather for the mechanism to set all of them now that it appears
> > we need to do that.
> 
> We don't *need* to do it any more than we did before.  It's easy to
> set options for 4xx, 8xx, etc. - just say the word.
> 
> > OK, but we still need some kind of indication from the configuration
> > process.  It seems to me it would be easier (and more logical) to
> > have the default behavior work like it has in the past, and use the
> > special options for the POWER4, which we already know in
> > the configuration.
> 
> The problem isn't for POWER4, the problem is biarch gcc4 optimizing
> for POWER4 when we are compiling for 6xx.

So here's where the confusion comes in.  You're saying that even though
(except .S files) no ppc32 kernel config was passing in explicit
-mcpu=... or similar, only CONFIG_6xx is hurt by the gcc4 biarch thingy?

-- 
Tom Rini
http://gate.crashing.org/~trini/
