Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id D391167B57
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 00:05:29 +1000 (EST)
Date: Tue, 8 Aug 2006 07:05:27 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Who cares about PReP?
Message-ID: <20060808140527.GG28095@smtp.west.cox.net>
References: <17622.58559.879330.496619@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17622.58559.879330.496619@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 07, 2006 at 04:59:11PM +1000, Paul Mackerras wrote:

> I started looking at moving the PReP code over to arch/powerpc.  I am
> struck by how many ifdefs there are in there to set things up for
> particular individual PReP implementations.  We can do better than
> that, I'm sure, but the issue becomes one of testing.  The only PReP I
> have here is an RS/6000 43p-140.
> 
> Who else has a PReP system and would be willing to do some testing and
> debugging?  If so, what sort of PReP is it?

I've still got a Motorola Powerstack (Series E) around.

-- 
Tom Rini
