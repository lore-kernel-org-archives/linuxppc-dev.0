Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by ozlabs.org (Postfix) with ESMTP id ED23EDDD0B
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Nov 2008 10:41:14 +1100 (EST)
Date: Mon, 3 Nov 2008 10:41:11 +1100
From: Simon Horman <horms@verge.net.au>
To: Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH] kexec memory ranges dynamic allocation
Message-ID: <20081102234109.GG11409@verge.net.au>
References: <572af9170810140811v446a6874pd67cb77753a9e32d@mail.gmail.com>
	<20081015031818.GC27243@verge.net.au>
	<572af9170810150146p58c599fvabb41338ffd4e033@mail.gmail.com>
	<20081031022902.GH27118@verge.net.au>
	<572af9170810302353l417781berf1da0661b37bc6db@mail.gmail.com>
	<20081101031601.GA11013@verge.net.au>
	<572af9170811010143v37826aa2y3200eb6815aba966@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <572af9170811010143v37826aa2y3200eb6815aba966@mail.gmail.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Nov 01, 2008 at 11:43:15AM +0300, Maxim Uvarov wrote:
> 2008/11/1 Simon Horman <horms@verge.net.au>
> 
> > On Fri, Oct 31, 2008 at 09:53:23AM +0300, Maxim Uvarov wrote:
> > > 2008/10/31 Simon Horman <horms@verge.net.au>
> > >
> > > > Hi,
> > > >
> > > > Could someone please comment on the satus of this patch?
> > > >
> > > Hello,  Simon
> > >
> > > I can not reproduce  error which you wrote before on my target. So it is
> > a
> > > little bit
> > > difficult to say what  was wrong exactly.
> >
> > Hi,
> >
> > the version of the patch below (which I think is the latest)
> > compiles fine for me. I wanted to confirm that you
> > and Chandru are happy for it to be merged.
> >
> > If so, could you please provide a short descripton for the change-log
> > and a Signed-off-by line.
> 
> Patch looks good.
> 
> Description is:
>    Do not count  max_memory_range for allocation. Increase allocation
> buffers
>    when it is needed. This actually allows us to avoid a lot of troubles
> with
>    various device-tree files.
> 
> Signed-off-by: Maxim Uvarov <muvarov@gmail.com>

Thanks, applied.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en
