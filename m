Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pb0-f42.google.com (mail-pb0-f42.google.com
 [209.85.160.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EFCA0B6F98
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2012 16:02:01 +1100 (EST)
Received: by pbcun1 with SMTP id un1so1094875pbc.15
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Mar 2012 22:01:58 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/85xx: don't call of_platform_bus_probe() twice
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <4F720462.5020400@freescale.com>
References: <1322669957-8259-1-git-send-email-timur@freescale.com>
 <F8C3451C-1B14-4C30-A194-B15B6C10B0A7@kernel.crashing.org>
 <4F63A7A4.4000205@freescale.com> <20120319160452.B57D13E05A5@localhost>
 <4F677E51.8030905@freescale.com> <20120320170942.0C4143E2834@localhost>
 <4F68BD6F.2090008@freescale.com> <4F69F099.4070409@freescale.com>
 <4F720462.5020400@freescale.com>
Date: Tue, 27 Mar 2012 23:01:55 -0600
Message-Id: <20120328050155.BC5143E0C37@localhost>
Cc: Scott Wood <scottwood@freescale.com>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 27 Mar 2012 13:18:10 -0500, Timur Tabi <timur@freescale.com> wrote:
> Grant, do you have a moment to consider my question?  Like I said, I'm
> anxious to get a fix into 3.3.

I've been out of town for the past week, so email processing volume
has been low.  Answer below.

> Timur Tabi wrote:
> > Timur Tabi wrote:
> >> They only problem I see with this is that I am thinking about modifying
> >> the drivers/dma driver to probe on "fsl,eloplus-dma-channel" channels
> >> directly.  If I do that, then who should call of_platform_populate()?
> > 
> > Grant, could you tell me if there's anything actually work with my patch?
> >  All I'm doing is adding a couple more commonly used entries to
> > mpc85xx_common_ids[].  After all, they're common IDs, so don't they belong
> > into an array called common_ids?

That's between you and Kumar.  I don't have any problem with it since
it's all contained within the mpc85xx code.

If those nodes really do make sense to represent as independent
platform devices, then adding them to the match list for bus types
isn't a problem.

g.
