Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao08.cox.net (fed1rmmtao08.cox.net [68.230.241.31])
	by ozlabs.org (Postfix) with ESMTP id B69EF679EF
	for <linuxppc-dev@ozlabs.org>; Thu,  5 May 2005 01:28:09 +1000 (EST)
Date: Wed, 4 May 2005 08:28:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050504152806.GU1221@smtp.west.cox.net>
References: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
	<3ef0069e8d123c43579a8cc85d20467c@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3ef0069e8d123c43579a8cc85d20467c@freescale.com>
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

On Wed, May 04, 2005 at 08:45:51AM -0500, Kumar Gala wrote:
> 
> On May 4, 2005, at 2:05 AM, Paul Mackerras wrote:
> 
> >What do people think of this patch?? The motivation for it is that a
> > biarch gcc-4.0 will by default tune for POWER4, even for a 32-bit
> > compile, meaning that we end up with a lot of nops we don't need.
> > This also takes out -mstring.
> >
> >With this, the text size reduces by about 120k for my normal config
> > when compiling with a biarch gcc-4.0.? The text size also reduces
> > slightly when compiling with the Debian gcc-3.3.5 (32-bit only, not
> > biarch).
> 
> What is attributed to this large of a text size change.  I've always 

My guess is taking out the nops that we don't need on !POWER4.

-- 
Tom Rini
http://gate.crashing.org/~trini/
