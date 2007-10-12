Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18190.52379.97647.468384@cargo.ozlabs.ibm.com>
Date: Fri, 12 Oct 2007 11:23:39 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/2] powerpc: Switch to generic WARN_ON()/BUG_ON()
In-Reply-To: <20071011171413.GC10877@lixom.net>
References: <20071011171211.GB10877@lixom.net>
	<20071011171413.GC10877@lixom.net>
Cc: grundler@parisc-linux.org, linux-kernel@vger.kernel.org,
	kyle@parisc-linux.org, linuxppc-dev@ozlabs.org,
	lethal@linux-sh.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson writes:

> Not using the ppc-specific WARN_ON/BUG_ON constructs actually saves about
> 4K text on a ppc64_defconfig. The main reason seems to be that prepping
> the arguments to the conditional trap instructions is more work than
> just doing a compare and branch.

It might be more instructions but it takes fewer cycles, I would
expect.  Do you have the actual instruction sequences to compare?

Paul.
