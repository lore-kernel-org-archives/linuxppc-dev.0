Return-Path: <B21989@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5B1942C0086
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2012 13:43:45 +1000 (EST)
From: Xie Shaohui-B21989 <B21989@freescale.com>
To: Shaun Ruffell <sruffell@digium.com>
Subject: RE: [PATCH] edac/85xx: fix error handle of mpc85xx_mc_err_probe
Date: Wed, 19 Sep 2012 03:43:35 +0000
Message-ID: <ED492CCEAF882048BC2237DE806547C9079E3F3D@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1347533729-5893-1-git-send-email-Shaohui.Xie@freescale.com>
 <20120914182137.GD18672@digium.com>
 <ED492CCEAF882048BC2237DE806547C9079E171E@039-SN2MPN1-012.039d.mgd.msft.net>
 <20120919030438.GE24873@digium.com>
In-Reply-To: <20120919030438.GE24873@digium.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "avorontsov@mvista.com" <avorontsov@mvista.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Shaun Ruffell [mailto:sruffell@digium.com]
> Sent: Wednesday, September 19, 2012 11:05 AM
> To: Xie Shaohui-B21989
> Cc: linux-edac@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> akpm@linux-foundation.org; avorontsov@mvista.com; linux-
> kernel@vger.kernel.org; grant.likely@secretlab.ca
> Subject: Re: [PATCH] edac/85xx: fix error handle of mpc85xx_mc_err_probe
>=20
> On Mon, Sep 17, 2012 at 10:32:59AM +0000, Xie Shaohui-B21989 wrote:
> > > -----Original Message-----
> > > From: Shaun Ruffell [mailto:sruffell@digium.com]
> > > Sent: Saturday, September 15, 2012 2:22 AM
> > > To: Xie Shaohui-B21989
> > > Cc: linux-edac@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > > akpm@linux-foundation.org; avorontsov@mvista.com; linux-
> > > kernel@vger.kernel.org; grant.likely@secretlab.ca
> > > Subject: Re: [PATCH] edac/85xx: fix error handle of
> > > mpc85xx_mc_err_probe
> > >
> > > On Thu, Sep 13, 2012 at 06:55:29PM +0800, Shaohui Xie wrote:
> > > > Error handle in case of DDR ECC off is wrong, sysfs entries have
> > > > not been created, so edac_mc_free which frees a mci instance
> > > > should not be called.
> > > > Also, free mci's memory in this case.
> > >
> > > Jus FYI: I ran into the same error in edac_mc_free() which I
> > > resolved in a slightly different way in some patches I sent
> > > previously. [1]
> > >
> > > [1] https://lkml.org/lkml/2012/9/14/475
> >
> > [S.H] Thanks! I did not aware of this patch when one of my colleague
> > asked me to have a look at the issue, It could save me some time if I
> > saw this patch earlier. :(
> >
> > BTW: seems you are using a different kernel tree with mine.
>=20
> On the chance that I missing something important: Why do you say I was
> running a different kernel tree? I was against 3.6-rc2 when I original
> hit the problem.
[S.H] I'm using 3.6-rc4, and some codes in your patch I did not find them i=
n 3.6-rc4.


Best Regards,=20
Shaohui Xie
