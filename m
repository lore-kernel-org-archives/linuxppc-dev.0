Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
	[IPv6:2001:a60:0:32:0:1:25:1])
	by ozlabs.org (Postfix) with ESMTP id D4A4FB6F85
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Sep 2011 23:46:02 +1000 (EST)
Date: Thu, 29 Sep 2011 15:45:58 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Subject: Re: Please pull 'next' branch of 5xxx tree (updated)
Message-ID: <20110929154558.4a595ff1@wker>
In-Reply-To: <CACxGe6s1K+rUbH7XinhHXqXvNzZ_QXwYfZHe8t1kzYj223ampg@mail.gmail.com>
References: <20110929113025.2b224cd3@wker>
	<CACxGe6s1K+rUbH7XinhHXqXvNzZ_QXwYfZHe8t1kzYj223ampg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

On Thu, 29 Sep 2011 07:49:07 -0500
Grant Likely <grant.likely@secretlab.ca> wrote:
...
> > are available in the git repository at:
> >  git://git.denx.de/linux-2.6-agust.git next
> >
> > Grant Likely (1):
> >      powerpc/5200: add support for charon board
> 
> Hmmm, I didn't actually write this patch. It looks like the author credit
> got screwed up at some point.

Thanks for pointing this out. Actually Heiko is the author of
the original patch. I've updated the next branch accordingly, so
here is a new pull request:

The following changes since commit 7680057cc4c7d9caada12767831bfd9738dd7b43:

  powerpc: Don't try OPAL takeover on old 970 blades (2011-09-29 17:04:59 +1000)

are available in the git repository at:
  git://git.denx.de/linux-2.6-agust.git next

Heiko Schocher (2):
      powerpc/5200: add support for charon board
      powerpc, tqm5200: update tqm5200_defconfig to fit for charon board.

 arch/powerpc/boot/dts/charon.dts             |  236 ++++++++++++++++++++++++++
 arch/powerpc/configs/52xx/tqm5200_defconfig  |   20 ++-
 arch/powerpc/platforms/52xx/mpc5200_simple.c |    1 +
 3 files changed, 249 insertions(+), 8 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/charon.dts

Anatolij
