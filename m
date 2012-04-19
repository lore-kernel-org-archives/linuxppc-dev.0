Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pz0-f42.google.com (mail-pz0-f42.google.com
 [209.85.210.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 36526B6FD3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2012 04:21:37 +1000 (EST)
Received: by dang27 with SMTP id g27so12992368dan.15
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2012 11:21:35 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] irqdomain/powerpc: Fix broken NR_IRQ references
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <1334796301.6791.9.camel@concordia>
References: <1334607198-18694-1-git-send-email-grant.likely@secretlab.ca>
 <1334607198-18694-2-git-send-email-grant.likely@secretlab.ca>
 <1334796301.6791.9.camel@concordia>
Date: Thu, 19 Apr 2012 12:21:33 -0600
Message-Id: <20120419182133.7B50F3E0700@localhost>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 19 Apr 2012 10:45:01 +1000, Michael Ellerman <michael@ellerman.id.au> wrote:
> On Mon, 2012-04-16 at 14:13 -0600, Grant Likely wrote:
> 
> > diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
> > index d09f3e8..fc9df1a 100644
> > --- a/arch/powerpc/platforms/cell/axon_msi.c
> > +++ b/arch/powerpc/platforms/cell/axon_msi.c
> > @@ -276,9 +276,6 @@ static int axon_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> >  	if (rc)
> >  		return rc;
> >  
> > -	/* We rely on being able to stash a virq in a u16 */
> 
> Would be nice to move the comment to the hunk below rather than just
> deleting it. Otherwise the 65536 looks a bit random.

Done.

g.
