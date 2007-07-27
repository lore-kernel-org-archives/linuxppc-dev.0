Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D5385DDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jul 2007 09:29:12 +1000 (EST)
Date: Fri, 27 Jul 2007 18:29:03 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Re: 2.6.22-git hangs during PCMCIA on PowerBook G3 in
	0.0 seconds
Message-Id: <20070727182903.9370d4b6.kim.phillips@freescale.com>
In-Reply-To: <1185575207.5495.257.camel@localhost.localdomain>
References: <20070721192143.GA12144@nospam.com>
	<20070721212845.GA30977@nospam.com>
	<20070723172725.b1c14885.kim.phillips@freescale.com>
	<1185234923.5439.158.camel@localhost.localdomain>
	<20070724185946.722f34b5.kim.phillips@freescale.com>
	<18088.6185.491082.875891@cargo.ozlabs.ibm.com>
	<20070726162921.a60c76ae.kim.phillips@freescale.com>
	<20070727221131.GA18273@nospam.com>
	<1185575207.5495.257.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 28 Jul 2007 08:26:47 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Sat, 2007-07-28 at 00:11 +0200, Rutger Nijlunsing wrote:
> > > Kim
> > > 
> > > p.s. should the stable team be notified to fix 2.6.22 for
> > > Lombard-nvram-style machines?
> > 
> > Logically, yes. 
> > 

> Two ! Paulus has one :-) Though I'm not sure he uses it often nowadays.
> 
I sent the two revert requests to the stable team.

Kim
