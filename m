Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id A0329DDEF9
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 11:39:55 +1000 (EST)
Date: Mon, 14 Jul 2008 21:24:36 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the powerpc tree
In-Reply-To: <20080714154459.0ed9da62.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.58.0807142123280.2955@gandalf.stny.rr.com>
References: <20080714154459.0ed9da62.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Nelson <markn@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Mon, 14 Jul 2008, Stephen Rothwell wrote:

> Hi Paul, Ben,
>
> Today's linux-next merge of the powerpc tree got a conflict in
> arch/powerpc/Kconfig between commit
> 4e491d14f2506b218d678935c25a7027b79178b1 ("ftrace: support for PowerPC")
> from the ftrace tree and commit 3affedc4e1ce837033b6c5e9289d2ce2f5a62d31
> ("powerpc/dma: implement new dma_*map*_attrs() interfaces") from the
> powerpc tree.
>
> The former commit moved the "select HAVE_OPROFILE" to the bottom of the
> "config PPC" list (for no reason that I can fathom) while the latter
> added another select.  Simple fixup.  I can carry it.

I heard someone mention that they try to keep the configs in alphabetical
order. I did the move of OPROFILE for just that reason. I should have said
so in the change log. Oh well.

-- Steve
