Return-Path: <simon@baydel.com>
Received: from anchor-post-34.mail.demon.net (anchor-post-34.mail.demon.net
	[194.217.242.92]) by ozlabs.org (Postfix) with ESMTP id DED89688B7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Dec 2005 04:55:02 +1100 (EST)
From: Simon Haynes <simon@baydel.com>
To: Eugene Surovegin <ebs@ebshome.net>
Date: Tue, 13 Dec 2005 18:44:48 +0000
References: <200512121726.34944.simon@baydel.com>
	<20051212181457.GA30505@gate.ebshome.net>
In-Reply-To: <20051212181457.GA30505@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200512131844.48035.simon@baydel.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ibm emac driver update
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 12 December 2005 18:14, Eugene Surovegin wrote:
> On Mon, Dec 12, 2005 at 05:26:34PM +0000, Simon Haynes wrote:
> > I am running a Ebony board with linux-2.6.12-rc1 and I amd having
> > intermittent network problems. Having searched the archives it would seem
> > that the driver for the IBM EMAC is buggy ?
> >
> > I have tried to patch my kernel with
> >
> > http://kernel.ebsname.net/emac/4xx_napi_emac.diff
> >
> > I believe this is almost a total driver re-write. Is this correct ?
> >
> > After having a couple of problems applying the patch, Kconfig and
> > ibm_emac_core.c. I fixed up the original code and applied the patch.
> >
> > On compilation the build fails with missing references to kzalloc,
> > which I guess I could easily fix with kmalloc and memset.
> >
> > However there is also an undefined field,  dcr_base, in the
> > ocp_func_mal_data structure.  This structure appears to be defined in
> > include/asm/ibm_ocp.h and this file does not appear to be changed by the
> > patch. I guess this patch is for a later kernel.
> >
> > Can anyone point me in the direction of a suitable patch for this kernel
> > ?
>
> I'm not sure about 2.6.12-rc1, but you can try GIT tree/patches at
> http://kernel.ebshome.net.
>
> Hint: you can assume that in addition to emac_3-2.6-28.diff, there are
> also emac_3-2.6-NN.diff (NN < 28) on my website which were made for
> earlier kernel versions :).
>
> Alternatively, you can backport all relevant stuff from current 2.6 or
> you can pay someone to do this for you.


I have eventually got git going. I am not familiar with it but following a 
tutorial I did

git clone rsync://kernel.ebshome.net/linux-2.6-emac.git
cd linux-2.6-emac
git checkout

I then ran find looking for a patches dir and could not find one.

Could you please tell me how to locate the emac_3-2.6-NN.diff files.

Cheers

Simon
 
