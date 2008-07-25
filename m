Return-Path: <benh@kernel.crashing.org>
Subject: Re: CONFIG_FRAME_POINTER [was [PATCH] x86: BUILD_IRQ say .text]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hugh@veritas.com>
In-Reply-To: <Pine.LNX.4.64.0807251839190.20617@blonde.site>
References: <Pine.LNX.4.64.0807211828470.26173@blonde.site>
	<20080724104459.GI28817@elte.hu>
	<Pine.LNX.4.64.0807251839190.20617@blonde.site>
Content-Type: text/plain
Date: Sat, 26 Jul 2008 07:46:13 +1000
Message-Id: <1217022373.11188.115.camel@pasglop>
Mime-Version: 1.0
Cc: Linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-kernel@vger.kernel.org, Mike Travis <travis@sgi.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-07-25 at 19:45 +0100, Hugh Dickins wrote:
> 
> I've Cc'ed Ben and linuxppc-dev because I wonder if they're aware
> that several options (I got it from LATENCYTOP, but I think LOCKDEP
> and FTRACE and some others) are doing a "select FRAME_POINTER",
> which forces CONFIG_FRAME_POINTER=y on PowerPC, even though
> FRAME_POINTER is not an option offered on PowerPC.  The
> resulting kernels appear to run okay, but I was surprised.

Because the option just does nothing for us ? :-) We always have frame
pointers on powerpc except in some case for leaf functions. I don't know
if the option has any actual effect on the later, but I don't think we
have a case where doing either way would break things.

Cheers,
Ben.
