Return-Path: <sam@ravnborg.org>
Received: from pasmtpB.tele.dk (pasmtpb.tele.dk [80.160.77.98])
	by ozlabs.org (Postfix) with ESMTP id 73276DDDFC
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 07:12:25 +1000 (EST)
Date: Mon, 14 May 2007 23:13:20 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] kbuild: Add "Section mismatch" warning whitelist for
	powerpc
Message-ID: <20070514211320.GA12094@uranus.ravnborg.org>
References: <46483FAC.60503@freescale.com>
	<20070514110636.GB10143@uranus.ravnborg.org>
	<3DF58590-DFD9-4665-8C47-33F407AAD1E7@kernel.crashing.org>
	<20070514123046.d75cc170.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070514123046.d75cc170.akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>,
	Linus <torvalds@linux-foundation.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 14, 2007 at 12:30:46PM -0700, Andrew Morton wrote:
> > >>
> > >> Signed-off-by: Li Yang <leoli@freescale.com>
> > > Acked-by: Sam Ravnborg <sam@ravnborg.org>
> 
> I always get confused when a git-tree-owner says "acked-by" against a patch
> which falls within his tree's area.  An acked-by would mean "I'm OK with
> the patch, please apply it".  But I'd have expected to see a "thanks,
> applied" instead.

I have saved the patch so I can apply it if Linus does not do so.
My "Acked-by:" was actually mostly to tell Linus that I was OK
with the modpost changes although I did not write so in my mail.

So if this is not picked up by Linus I will pick up this patch.

	Sam
