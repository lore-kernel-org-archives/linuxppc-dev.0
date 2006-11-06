Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add Efika platform support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20061106144648.801c9441.akpm@osdl.org>
References: <20061105111118.ccffccfe.nd@bplan-gmbh.de>
	<20061106144648.801c9441.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 10:19:24 +1100
Message-Id: <1162855164.28571.367.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org, sl@bplan-gmbh.de,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-11-06 at 14:46 -0800, Andrew Morton wrote:
> On Sun, 5 Nov 2006 12:57:16 +0100 (MET)
> Nicolas DET <nd@bplan-gmbh.de> wrote:
> 
> > Add Efika (http://www.bplan-gmbh.de/efika_spec_en.html) platform support for arch/powerpc
> 
> Who (if anyone) is the maintainer for this sort of thing?

It's powerpc, it will go through paulus tree I suppose. You can host
them in -mm if you like until the merge window.

In the specific case of Efika, I'm doing the ACK'ing/NACK'ing of the
patches. At this point, the platform patch and interrupt patches are
good to go.

Cheers,
Ben.
