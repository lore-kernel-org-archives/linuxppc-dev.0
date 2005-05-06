Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id 1AEA367B5A
	for <linuxppc-dev@ozlabs.org>; Sat,  7 May 2005 01:34:54 +1000 (EST)
Date: Fri, 6 May 2005 08:34:51 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Message-ID: <20050506153451.GF1221@smtp.west.cox.net>
References: <17017.16478.767293.191940@cargo.ozlabs.ibm.com>
	<45e21c1ae2899849665fb894a2adcc20@embeddededge.com>
	<17017.39523.745634.193331@cargo.ozlabs.ibm.com>
	<20050505041225.GX1221@smtp.west.cox.net>
	<17017.42136.824607.253146@cargo.ozlabs.ibm.com>
	<20050505044737.GY1221@smtp.west.cox.net>
	<17017.44421.790813.918463@cargo.ozlabs.ibm.com>
	<205f4a46b0d9eddd5c46ff1678c9e4ca@kernel.crashing.org>
	<20050506145313.GE1221@smtp.west.cox.net>
	<037495ad1309ee55e6028a63fd279440@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <037495ad1309ee55e6028a63fd279440@kernel.crashing.org>
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

On Fri, May 06, 2005 at 05:28:57PM +0200, Segher Boessenkool wrote:

> >Note that up until very recently (and just a bit before conflicting
> >opcodes were added), no -mcpu=XXX was required.
> 
> True, but it's just lucky that it worked...

It used to be design that it worked.  But now I'm sounding like Dan,
which I find only slightly disconcerting :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
