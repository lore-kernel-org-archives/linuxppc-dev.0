Return-Path: <anton@ozlabs.org>
Date: Wed, 28 Jun 2006 21:28:45 +1000
From: Anton Blanchard <anton@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: support ibm,extended-*-frequency properties
Message-ID: <20060628112845.GE516@krispykreme>
References: <20060620084726.GC30974@krispykreme>
	<D0B9DD42-E1D3-48E3-A90A-8F8B5718852F@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D0B9DD42-E1D3-48E3-A90A-8F8B5718852F@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 
> Could you also allow the regular "timebase-frequency" property
> to consist of two cells, with the same semantics?  That's what
> some other systems do.  Hey, it'd simplify this code, if anything :-)
> 
> In fact, some kernel code already does this if I'm not mistaken
> (the Cell port, perhaps?)

Yeah it seems reasonable to just use the property size, I'll submit an
incremental patch for that.

Anton
