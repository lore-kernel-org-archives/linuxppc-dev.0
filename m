Return-Path: <rolandd@cisco.com>
Received: from ams-iport-1.cisco.com (ams-iport-1.cisco.com [144.254.224.140])
	by ozlabs.org (Postfix) with ESMTP id A67106838B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Sep 2005 08:44:45 +1000 (EST)
To: Matt Porter <mporter@kernel.crashing.org>
References: <2005922203.92drttvd27WS9dXk@cisco.com>
	<2005922203.UPGbNSgrHKasoXYq@cisco.com>
	<20050923102038.G21055@cox.net>
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 23 Sep 2005 15:44:35 -0700
In-Reply-To: <20050923102038.G21055@cox.net> (Matt Porter's message of "Fri,
	23 Sep 2005 10:20:38 -0700")
Message-ID: <52y85n8kvg.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2/4] [PPC32] Add 440SPe support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    Matt> Please change these new files to ppc440spe.*.  After the new
    Matt> EMAC driver is merged, we are planning a Great Renaming(tm)
    Matt> to make the current filenames be vendor neutral. i.e. ibm4*->ppc4*

OK, I made these changes and rebased to Eugene's EMAC git tree.  This
tree passes some basic tests on my Yucca board.  I just pushed this,
so pending mirror delays, it will be at

  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/roland/ppc440spe.git

I can repost the patchset if anyone wants to see it.

BTW, Eugene, you might want to do a 'git prune-packed' on your git
tree.  It's pretty wasteful to clone your tree now, because you have a
lot of individual objects that also appear in Linus's packs.

 - R.
