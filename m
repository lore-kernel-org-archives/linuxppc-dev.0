Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E9B37B6FD7
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Dec 2011 04:20:00 +1100 (EST)
MIME-Version: 1.0
In-Reply-To: <20111010123020.GA21699@1wt.eu>
References: <20111010123020.GA21699@1wt.eu>,
 <1318246220-4839-1-git-send-email-Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH 00/14] Backport 8xx TLB to 2.4
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Willy Tarreau <w@1wt.eu>
Message-ID: <OF6B6562C0.926C4B3C-ONC1257963.005F34B1-C1257963.005F34B2@transmode.se>
Date: Sun, 11 Dec 2011 18:19:54 +0100
Content-Type: text/plain; charset=UTF-8
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Dan Malek <ppc6dev@digitaldans.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> From: Willy Tarreau <w@1wt.eu>
>=20
> Hi Joakim,  On Mon, Oct 10, 2011 at 01:30:06PM +0200, Joakim Tjernlund wr=
ote: > This is a
> backport from 2.6 which I did to overcome 8xx CPU > bugs. 8xx does not up=
date the DAR register
> when taking a TLB > error caused by dcbX and icbi insns which makes it ve=
ry > tricky to use these
> insns. Also the dcbst wrongly sets the > the store bit when faulting into=
 DTLB error. > A few
> more bugs very found during development. >  > I know 2.4 is in strict mai=
ntenance mode and 8xx is
> obsolete > but as it is still in use I wanted 8xx to age with grace.  Tha=
nk you. I must admit I
> was hoping those patches would come in for a last release before the end =
of the year :-)  Unless
> there is any objection from anyone, I'll merge them when kernel.org is ba=
ck online.  Cheers,
> Willy

Did this go anywhere?

 Jocke  =
=
