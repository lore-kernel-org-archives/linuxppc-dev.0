Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 8CACDDE456
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 03:29:07 +1100 (EST)
Date: Fri, 4 Apr 2008 11:38:58 -0500
From: Olof Johansson <olof@lixom.net>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Please pull linux-2.6-mpc52xx.git
Message-ID: <20080404163858.GA25717@lixom.net>
References: <fa686aa40803171443q7a53f0balbb49740116c6552@mail.gmail.com>
	<20080317222836.AFA66241A2@gemini.denx.de>
	<fa686aa40803171643y7db21cadsc454a713ba6c4342@mail.gmail.com>
	<47E938A8.9000103@semihalf.com>
	<fa686aa40803251151p457a2295w449222654be4d0d1@mail.gmail.com>
	<47F22C9A.4050501@semihalf.com> <47F60D5D.5090402@semihalf.com>
	<fa686aa40804040911o63e2e3efg2d9a74fff082fb16@mail.gmail.com>
	<fa686aa40804040914s3f682e37r16b4cb299e2fc97e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40804040914s3f682e37r16b4cb299e2fc97e@mail.gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 04, 2008 at 10:14:34AM -0600, Grant Likely wrote:
> On Fri, Apr 4, 2008 at 10:11 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> > > > > I'm thinking 'optimized' defconfigs should go into a subdirectory.
> >  > >
> >  > > This requires a change to the top-level Makefile and shepherding this
> >  > > change upstream. Could we perhaps try to avoid this by having optimized
> >  > > defconfigs in the form of, for example:
> >
> >  I don't think changes are required to put them in a subdir:
> >
> >  $ mkdir arch/powerpc/configs/optimized
> >  $ cp arch/powerpc/configs/mpc5200_defconfig
> >  arch/powerpc/configs/optimized/lite5200_defconfig
> >  $ make optimized/lite5200_defconfig
> >
> >  This works for me.
> 
> However, I'm not sure what the naming scheme should be for subdirectories.
> 
> board vendor?
> host processor?
> just one big directory for board specific defconfigs?
> 
> Olof, Kumar, Josh; any thoughts?
> 
> Not that it matters much; files are easy to move around later.

I really like the idea. It would probably make sense to organize it in
the same way as the platforms are done today, i.e. per processor/platform
family. And then have shared/merged configs in the main config directory.


-Olof
