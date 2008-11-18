Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18722.43694.861169.946743@cargo.ozlabs.ibm.com>
Date: Tue, 18 Nov 2008 22:44:46 +1100
From: Paul Mackerras <paulus@samba.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Large stack usage in fs code (especially for PPC64)
In-Reply-To: <200811182124.33141.nickpiggin@yahoo.com.au>
References: <alpine.DEB.1.10.0811171508300.8722@gandalf.stny.rr.com>
	<18722.2107.970887.768477@cargo.ozlabs.ibm.com>
	<alpine.LFD.2.00.0811171752450.18283@nehalem.linux-foundation.org>
	<200811182124.33141.nickpiggin@yahoo.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nick Piggin writes:

> It's much harder to do this with powerpc I think because they would need
> to calculate 8 hashes and touch 8 cachelines to prefill 8 translations,
> wouldn't they?

Yeah, the hashed page table sucks.  Film at 11, as they say. :)

Paul.
