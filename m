Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7F1E6B6EFE
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Dec 2009 07:01:51 +1100 (EST)
Subject: Re: [PATCH 00/10 v6]  Fix 8xx MMU/TLB
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OF5D73AF7D.6635CE0F-ONC1257686.002F38E4-C1257686.002F81DE@transmode.se>
References: <1258712471-3104-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<OF44DA1806.2D9916D9-ONC125767B.003BE84B-C125767B.003C3CD7@transmode.se>
	<1259357845.2076.9.camel@pasglop> <4B14465A.3080804@freescale.com>
	<OF5D73AF7D.6635CE0F-ONC1257686.002F38E4-C1257686.002F81DE@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Dec 2009 07:01:42 +1100
Message-ID: <1260302502.16132.3.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-12-08 at 09:38 +0100, Joakim Tjernlund wrote:
> Scott Wood <scottwood@freescale.com> wrote on 30/11/2009 23:25:30:
> >
> > Benjamin Herrenschmidt wrote:
> > > On Fri, 2009-11-27 at 11:57 +0100, Joakim Tjernlund wrote:
> > >> Scott and Rex, I think we need you s-o-b to make it into the kernel proper.
> > >>
> > >> Marcelo and Vitaly, I noticed you guys are listed as 8xx maintainers.
> > >> Have you seen this? What do you think?
> > >
> > > I think Marcelo isn't much involved with 8xx anymore. I'd say if Scott
> > > and Vitaly are ok, then the patches are good. But I'll wait for at least
> > > Scott to give an Ack as he can at least test which I can't :-)
> >
> > ACK
> 
> Can't see these patches in next yet, did they go somewhere else?

No, but Scott has been to lazy to write proper Acked-by: lines and I've
been too lazy to do it for him so they'll go in the next batch, probably
today :-)

Cheers,
Ben.
