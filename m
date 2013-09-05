Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8F73D2C00ED
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Sep 2013 03:57:29 +1000 (EST)
Message-ID: <1378403834.12204.99.camel@snotra.buserror.net>
Subject: Re: [V2,2/2] powerpc/85xx: workaround for chips with MSI hardware
 errata
From: Scott Wood <scottwood@freescale.com>
To: Jia Hongtao-B38951 <B38951@freescale.com>
Date: Thu, 5 Sep 2013 12:57:14 -0500
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01D40DC2@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1364954598-31914-2-git-send-email-hongtao.jia@freescale.com>
 <20130628022833.GA28050@home.buserror.net>
 <412C8208B4A0464FA894C5F0C278CD5D01D40DC2@039-SN1MPN1-003.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-09-04 at 23:00 -0500, Jia Hongtao-B38951 wrote:
> > -----Original Message-----
> > From: Jia Hongtao-B38951
> > Sent: Monday, July 01, 2013 5:36 PM
> > To: Wood Scott-B07421
> > Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org
> > Subject: RE: [V2,2/2] powerpc/85xx: workaround for chips with MSI
> > hardware errata
> > 
> > > -----Original Message-----
> > > From: Wood Scott-B07421
> > > Sent: Friday, June 28, 2013 10:29 AM
> > > To: Jia Hongtao-B38951
> > > Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Wood
> > > Scott-
> > > B07421
> > > Subject: Re: [V2,2/2] powerpc/85xx: workaround for chips with MSI
> > > hardware errata
> > >
> > > On Wed, Apr 03, 2013 at 10:03:18AM +0800, Hongtao Jia wrote:
> > > > The MPIC version 2.0 has a MSI errata (errata PIC1 of mpc8544), It
> > > > causes that neither MSI nor MSI-X can work fine. This is a
> > > > workaround to allow MSI-X to function properly.
> > > >
> > > > Signed-off-by: Liu Shuo <soniccat.liu@gmail.com>
> > > > Signed-off-by: Li Yang <leoli@freescale.com>
> > > > Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> > >
> > > Building on 83xx:
> > >
> > >   arch/powerpc/sysdev/built-in.o: In function `fsl_of_msi_probe':
> > >   fsl_msi.c:(.text+0x1464): undefined reference to
> > > `fsl_mpic_primary_get_version'
> > >   make[1]: *** [vmlinux] Error 1
> > >   make: *** [sub-make] Error 2
> > >
> > > fsl_msi.c supports IPIC as well.
> > >
> > > -Scott
> > 
> > Hi Scott,
> > I updated the patch to fix this compile error just now.
> > please refer to:
> > http://patchwork.ozlabs.org/patch/256018/
> > 
> > Thanks.
> > -Hongtao
> 
> Hi Scott,
> 
> The 83xx compile issue has already been fixed.
> Please have a review on this patch.

Oh, sorry -- I missed it because it was marked "Changes Requested".
I've changed the status and will consider it for the next batch of
"next" patches.

In the future, if a patch is miscategorized in patchwork (e.g. says
"changes requested" when there is no longer a need to submit a new
patch) please mention that specifically and provide the patchwork URL.

-Scott
