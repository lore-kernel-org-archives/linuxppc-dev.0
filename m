Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16976.57251.983884.605143@cargo.ozlabs.ibm.com>
Date: Mon, 4 Apr 2005 16:33:07 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <b469d10736cc1d208a87b000ad67f550@freescale.com>
References: <16968.31026.148291.626305@cargo.ozlabs.ibm.com>
	<b469d10736cc1d208a87b000ad67f550@freescale.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: ASM formatting rules?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> Great, if my counting is correct (which may not be, since I grow up in 
> Florida)
> 
> 2 - for no space (Paul, BenH)
> 2 - for spaces (Tom, Dan)
> 2 - dont cares (Kumar, Matt)
> 
> Well, does Paul have authoritative rule here as ppc maintainer? :)

I would take a similar attitude to Linus and say that if there is
someone who has taken on the role of maintaining a file or subsystem,
they get a fair bit of latitude in saying what the style should be
there.  So if Dan and Tom want to do "insn<TAB>op, op, op" in
head_8xx.S, I'm not going to go in and remove all the excess spaces.

However, apart from that - i.e. for code that is used on all PPC
platforms, or if people are asking what the style should be - then the
style is no spaces between the operands.

Paul.
