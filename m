Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 09508B6EEA
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Dec 2009 09:31:57 +1100 (EST)
In-Reply-To: <4B14465A.3080804@freescale.com>
References: <1258712471-3104-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<OF44DA1806.2D9916D9-ONC125767B.003BE84B-C125767B.003C3CD7@transmode.se>
	<1259357845.2076.9.camel@pasglop> <4B14465A.3080804@freescale.com>
Subject: Re: [PATCH 00/10 v6]  Fix 8xx MMU/TLB
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OF8997AF5E.8375FB50-ONC125767E.007B7123-C125767E.007BA7B6@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 30 Nov 2009 23:30:38 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Rex Feany <RFeany@mrv.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote on 30/11/2009 23:25:30:
>
> Benjamin Herrenschmidt wrote:
> > On Fri, 2009-11-27 at 11:57 +0100, Joakim Tjernlund wrote:
> >> Scott and Rex, I think we need you s-o-b to make it into the kernel proper.
> >>
> >> Marcelo and Vitaly, I noticed you guys are listed as 8xx maintainers.
> >> Have you seen this? What do you think?
> >
> > I think Marcelo isn't much involved with 8xx anymore. I'd say if Scott
> > and Vitaly are ok, then the patches are good. But I'll wait for at least
> > Scott to give an Ack as he can at least test which I can't :-)
>
> ACK

Yippie, lets see if I can work up the energy to do the
same for 2.4 once this is in 2.6 :)
