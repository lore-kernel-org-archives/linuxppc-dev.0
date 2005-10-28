Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by ozlabs.org (Postfix) with ESMTP id 00680685CF
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Oct 2005 03:30:45 +1000 (EST)
Date: Fri, 28 Oct 2005 10:30:41 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051028103041.B15268@cox.net>
References: <17250.8725.358204.62510@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17250.8725.358204.62510@cargo.ozlabs.ibm.com>;
	from paulus@samba.org on Fri, Oct 28, 2005 at 11:05:25PM +1000
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: Patches for 2.6.15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 28, 2005 at 11:05:25PM +1000, Paul Mackerras wrote:
> If anyone has patches for arch/ppc{,64} and include/asm-ppc{,64} that
> they would like to see go upstream now that 2.6.14 is out, other than
> patches that are already in the powerpc-merge tree, please let me
> know.  I am planning to ask Linus to pull the powerpc-merge tree
> shortly, and that will probably break your patches.

Ok, we have a set of 4xx patches that I plan to send to Andrew.
They are some existing 4xx SoC/board updates as well as a new
SoC/board. They are obviously mostly confined to the 4xx code paths
but there's likely conflicts in changes to Makefiles, etc.

Would you prefer these going upstream before or after the 
powerpc-merge pull?

-Matt
