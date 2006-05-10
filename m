Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 02FD5679EB
	for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2006 01:23:50 +1000 (EST)
Date: Wed, 10 May 2006 10:24:00 -0500
To: Wolfgang Pfeiffer <roto@gmx.net>
Subject: Re: Kernel bug reports welcome here?
Message-ID: <20060510152400.GH1794@lixom.net>
References: <20060510135139.GB3878@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060510135139.GB3878@localhost>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 10, 2006 at 03:51:39PM +0200, Wolfgang Pfeiffer wrote:
> Hi All
> 
> I'm running a git kernel with sources from about last Sunday, on a
> alubook5.8, and I would like to know whether bug reports, if things
> don't work with this kernel (there are a few ... :), will be welcome
> here.
> 
> If not: Where's the better place for reports like that: Linux kernel
> mailing list?

They are welcome here, but keep in mind that some of them could be
better suited for LKML. It depends on what the problem is. If it seems
to be machine/PPC-specific, post here. If it's generic kernel (MM, other
things), post on LKML. If unsure, you could also crosspost on both lists,
but try to keep that to a minimum.

There's also the debian-ppc mailing list, for things not directly related
to the kernel but to the rest of the distro you run (some kernel problems
are also discussed there, but I'm not sure if they're interested in
mainline kernel bugs there or not).


-Olof
