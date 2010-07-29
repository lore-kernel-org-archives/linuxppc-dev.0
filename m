Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by ozlabs.org (Postfix) with ESMTP id 5CED41007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Jul 2010 19:18:29 +1000 (EST)
Date: Thu, 29 Jul 2010 18:18:26 +0900
From: Simon Horman <horms@verge.net.au>
To: Matthew McClintock <msm@freescale.com>
Subject: Re: [PATCH v3 0/7] Fixup booting with device trees and uImage/elf
	on ppc32
Message-ID: <20100729091825.GE10021@verge.net.au>
References: <1279687384-9770-1-git-send-email-msm@freescale.com>
	<20100727025506.GA1944@verge.net.au>
	<14FA0578-0D5B-48D1-BF5D-EB39DF1432D1@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14FA0578-0D5B-48D1-BF5D-EB39DF1432D1@freescale.com>
Cc: muvarov@gmail.com, linuxppc-dev@lists.ozlabs.org, sebastian@breakpoint.cc,
	kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 26, 2010 at 11:22:58PM -0500, Matthew McClintock wrote:
> 
> On Jul 26, 2010, at 9:55 PM, Simon Horman wrote:
> 
> > [Cced linuxppc-dev]
> > 
> > On Tue, Jul 20, 2010 at 11:42:57PM -0500, Matthew McClintock wrote:
> >> This patch series adds full support for booting with a flat device tree
> >> with either uImage or elf file formats. Kexec and Kdump should work, and
> >> you should also be able to use ramdisks or reuse your current ramdisk as well
> >> 
> >> This patch series was tested on an mpc85xx system with a kernel version
> >> 2.6.35-rc3
> >> 
> >> v1: Initial version
> >> 
> >> v2: Added support for fs2dt (file system to device tree)
> >> 
> >> v3: Fix some misc. git problems I had and other code cleanups
> > 
> > Hi Matthew,
> > 
> > I'm a little concerned that these changes are non trivial and haven't had
> > much review. But I am prepared to put them into my tree once 2.0.2 is
> > released - perhaps that way they will get some test coverage. Does
> > that work for you?
> 
> Either way works for me. I know they could use more review, however as Maxim said the current tree does not work AFAIK. Either way, I'm willing to keeping addressing everyones concerns and wait or move forward and make some quick fixes as well.

All applied.

I made some minor changes to three of the patches.
I have noted each change in separate emails.
