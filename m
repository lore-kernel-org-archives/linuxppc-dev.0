Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8E8CAB73D9
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Jun 2012 20:38:47 +1000 (EST)
In-Reply-To: <1338542089.16119.48.camel@pasglop>
References: <1338363814-19565-1-git-send-email-Joakim.Tjernlund@transmode.se>	
 <4FC62018.3040404@mindchasers.com> <1338542089.16119.48.camel@pasglop>
Subject: Re: [RFC] [PATCH] powerpc: Add MSR_DE to MSR_KERNEL
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF3CCDFD56.152566E7-ONC1257A10.003A1C83-C1257A10.003A7992@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 1 Jun 2012 12:38:42 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Bob Cochran <ppc@mindchasers.com>,
 support@abatron.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 2012/06/01 11:14:49:
>
> On Wed, 2012-05-30 at 09:26 -0400, Bob Cochran wrote:
> > I believe that additional patches are required for CodeWarrior to
> > work
> > properly (e.g., assembly start up).  I think the patches should come
> > from Freescale.  For whatever reason, they include them in their SDK,
> > but haven't submitted them for inclusion in the mainline.
> >
> > As a developer on Freescale Power products, I would like to see
> > Freescale offer up a CodeWarrior patch set, so I don't have to manage
> > the patches myself when working outside the SDK (i.e., on a more
> > recent
> > kernel).
>
> Such patches would have a hard time getting upstream considering that
> codewarrior is a commercial product.

Naa, Abatron BDI is also a commercial product and that is in the kernel. CW
changes pretty much just add the same settings for CONFIG_CW. I think Freescale
should just rename CONFIG_BDI_SWITCH to something generic and just use the same code.

 Jocke
