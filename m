Return-Path: <simon@baydel.com>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net
	[194.217.242.85]) by ozlabs.org (Postfix) with ESMTP id 6FB8F68898
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Dec 2005 00:45:03 +1100 (EST)
Received: from [80.176.67.250] (helo=baydel-adsl.demon.co.uk)
	by anchor-post-35.mail.demon.net with esmtp (Exim 4.42)
	id 1EmALx-000CuG-Iy
	for linuxppc-embedded@ozlabs.org; Tue, 13 Dec 2005 13:38:03 +0000
From: Simon Haynes <simon@baydel.com>
To: linuxppc-embedded@ozlabs.org
Date: Tue, 13 Dec 2005 14:35:46 +0000
References: <200512121726.34944.simon@baydel.com>
	<20051212181457.GA30505@gate.ebshome.net>
In-Reply-To: <20051212181457.GA30505@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200512131435.47486.simon@baydel.com>
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

Eugine,

Thanks for the reply. I am not familiar with git and I do not
have it installed on my system. I have looked for rpms and
tried to build git. It seems that I will need to make a lot of changes
to my system to get this going.

In a response from Wolfgang he lists a url which can be used to access 
his git tree via a browser. I can not find these patch files on his git tree
but I was wondering if you made the files available in a similar way.

Alternatively can you mail the file to me ?

Or can you tell me if the files are somewhere on

http://www.denx.de/cgi-bin/gitweb.cgi?p=linux-2.6-denx.git

If not I guess I will just have to get all the bits together to run
git and learn how to drive it.

Many Thanks

Simon.


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
