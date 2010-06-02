Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 81517B7D43
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jun 2010 08:02:52 +1000 (EST)
Date: Wed, 2 Jun 2010 15:02:46 -0700
From: Greg KH <greg@kroah.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix ioremap_flags() with book3e pte definition
Message-ID: <20100602220246.GA11255@kroah.com>
References: <1274726319-4673-1-git-send-email-galak@kernel.crashing.org>
	<81DFFD59-BF21-4754-B006-805CFDC09576@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <81DFFD59-BF21-4754-B006-805CFDC09576@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 02, 2010 at 04:59:16PM -0500, Kumar Gala wrote:
> 
> On May 24, 2010, at 1:38 PM, Kumar Gala wrote:
> 
> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > We can't just clear the user read permission in book3e pte, because
> > that will also clear supervisor read permission.  This surely isn't
> > desired.  Fix the problem by adding the supervisor read back.
> > 
> > BenH: Slightly simplified the ifdef and applied to ppc64 too
> > 
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> > For 2.6.34 stable commit 55052eeca6d71d76f7c3f156c0501814d8e5e6d3
> > 
> > arch/powerpc/mm/pgtable_32.c |    8 ++++++++
> > arch/powerpc/mm/pgtable_64.c |    8 ++++++++
> > 2 files changed, 16 insertions(+), 0 deletions(-)
> 
> Wondering what happened to this patch (and 2 other) getting into stable queue for .34.x

They are still in the "to-apply" queue.  Please be patient, I was busy
with the .35-rc1 merge window and now am catching up on the stable
trees.  There's over 130 patches that people seem to want in the first
.34 stable release, so it's taking some time to get them all in and
tested.

thanks,

greg k-h
