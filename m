Return-Path: <rolandd@cisco.com>
Received: from ams-iport-1.cisco.com (ams-iport-1.cisco.com [144.254.224.140])
	by ozlabs.org (Postfix) with ESMTP id 5797E67B48
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Sep 2005 06:27:12 +1000 (EST)
To: Matt Porter <mporter@kernel.crashing.org>
References: <2005922203.92drttvd27WS9dXk@cisco.com>
	<2005922203.UPGbNSgrHKasoXYq@cisco.com>
	<20050923032949.GB10089@gate.ebshome.net> <52y85obanw.fsf@cisco.com>
	<20050923101712.F21055@cox.net>
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 23 Sep 2005 13:27:00 -0700
In-Reply-To: <20050923101712.F21055@cox.net> (Matt Porter's message of "Fri,
	23 Sep 2005 10:17:12 -0700")
Message-ID: <528xxna5t7.fsf@cisco.com>
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

    Matt> Can you rebase off of Eugene's tree and resend patches? For
    Matt> the moment the new EMAC driver is the lynchpin in anything
    Matt> new PPC4xx.  I want to hold off merging anything that
    Matt> involves current EMAC driver changes until the new driver is
    Matt> in. In any case, nothing like this can go upstream until
    Matt> after 2.6.14 is released. We are expecting the new EMAC
    Matt> driver to be merged at that point.  If you have this stuff
    Matt> rebased from his tree we can easily merge them post-EMAC
    Matt> merge.

I've already sent patches to Eugene that are in his EMAC tree.  So his
driver will support 440SPe and can be merged before or after my
patches.  If it's before then just dump my ibm_emac patch on the floor.

 - R.
