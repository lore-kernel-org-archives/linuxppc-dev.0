Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 333C5B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Jul 2009 19:54:45 +1000 (EST)
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C6106DDDF6
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Jul 2009 19:54:44 +1000 (EST)
Date: Mon, 13 Jul 2009 18:53:21 +0900
To: Ian.Campbell@eu.citrix.com
Subject: Re: [00/15] swiotlb cleanup
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1247478029.11668.10.camel@zakaz.uk.xensource.com>
References: <1247234520.4002.418.camel@zakaz.uk.xensource.com>
	<20090713131859N.fujita.tomonori@lab.ntt.co.jp>
	<1247478029.11668.10.camel@zakaz.uk.xensource.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20090713185247W.fujita.tomonori@lab.ntt.co.jp>
Cc: jeremy@goop.org, tony.luck@intel.com, linux-ia64@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org,
	joerg.roedel@amd.com, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 13 Jul 2009 10:40:29 +0100
Ian Campbell <Ian.Campbell@eu.citrix.com> wrote:

> On Mon, 2009-07-13 at 05:20 +0100, FUJITA Tomonori wrote:
> > On Fri, 10 Jul 2009 15:02:00 +0100
> > Ian Campbell <Ian.Campbell@citrix.com> wrote:
> > 
> > > On Fri, 2009-07-10 at 14:35 +0900, FUJITA Tomonori wrote:
> > > > I don't think that we need to take account of dom0 support; we don't
> > > > have a clear idea about an acceptable dom0 design (it needs to use
> > > > swiotlb code? I don't know yet), we don't even know we will have dom0
> > > > support in mainline. That's why I didn't CC this patchset to Xen
> > > > camp.
> > > 
> > > The core domain 0 patches which were the subject of the discussions a
> > > few week back are completely orthogonal to the swiotlb side of things
> > 
> > ? If we don't merge dom0 patch, we don't need dom0 changes to
> > swiotlb. We don't know we would have dom0 support in mainline. Or I
> > overlooked something?
> [...]
> > As far as I know, you have not posted anything about changes to
> > swiotlb for domU. I can't discuss it. If you want, please send
> > patches.
> 
> There are no separate domU swiotlb patches -- the exact the same patches
> as we have already been discussing are useful and necessary for both
> domU and dom0.

Hmm, you guys introduced the swiotlb hooks by saying that it's for
only dom0.

=
http://lkml.org/lkml/2008/12/16/351

Hi Ingo,

Here's some patches to clean up swiotlb to prepare for some Xen dom0
patches.  These have been posted before, but undergone a round of
cleanups to address various comments.

=

I don't see any comments like 'this is useful to dom0 too'. I'm still
not sure what exactly part is useful to domU.
