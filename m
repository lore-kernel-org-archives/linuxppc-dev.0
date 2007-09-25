Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A2FFEDDE2B
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 13:58:57 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc: ptrace CHECK_FULL_REGS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland McGrath <roland@redhat.com>
In-Reply-To: <20070925005945.02E924D04B7@magilla.localdomain>
References: <20070924235052.5AFC24D04B7@magilla.localdomain>
	<1190680406.12382.9.camel@localhost.localdomain>
	<20070925005945.02E924D04B7@magilla.localdomain>
Content-Type: text/plain
Date: Tue, 25 Sep 2007 13:58:46 +1000
Message-Id: <1190692726.31978.0.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: David Woodhouse <dwmw2@redhat.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-09-24 at 17:59 -0700, Roland McGrath wrote:
> > Yup, I think I ditched most of them.. for some reason I decided it
> > couldn't happen, but maybe I'm wrong ?
> 
> Well, it's a BUG_ON.  It's supposed to be for something that "can't happen".
> That's why it's a sanity check, not a wild assertion. ;-)
> 
> The 2/2 patch is an example of a bug that CHECK_FULL_REGS catches.
> In the status quo, using PTRACE_PEEKUSR in a bug case crashes while using
> PTRACE_GETREGS in the same place might get bogus data.  (In the actual bug
> thus found, the data is not bogus and only the bit that FULL_REGS checks is.)

Fair enough.

Ben.
