Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1B356DDE45
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jul 2007 08:26:57 +1000 (EST)
Subject: Re: [PATCH] Re: 2.6.22-git hangs during PCMCIA on PowerBook G3 in
	0.0 seconds
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@tux.tmfweb.nl
In-Reply-To: <20070727221131.GA18273@nospam.com>
References: <20070721192143.GA12144@nospam.com>
	<20070721212845.GA30977@nospam.com>
	<20070723172725.b1c14885.kim.phillips@freescale.com>
	<1185234923.5439.158.camel@localhost.localdomain>
	<20070724185946.722f34b5.kim.phillips@freescale.com>
	<18088.6185.491082.875891@cargo.ozlabs.ibm.com>
	<20070726162921.a60c76ae.kim.phillips@freescale.com>
	<20070727221131.GA18273@nospam.com>
Content-Type: text/plain
Date: Sat, 28 Jul 2007 08:26:47 +1000
Message-Id: <1185575207.5495.257.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-07-28 at 00:11 +0200, Rutger Nijlunsing wrote:
> > Kim
> > 
> > p.s. should the stable team be notified to fix 2.6.22 for
> > Lombard-nvram-style machines?
> 
> Logically, yes. 
> 
> Practically it does not matter that much it seems. I've got the
> feeling the Lombard-users-group-size is about one person which is
> going to drop to zero if he doesn't get any further in being able to
> use _any_ PCMCIA card in his machine ;-)

Two ! Paulus has one :-) Though I'm not sure he uses it often nowadays.

> For example, PCMCIA (non-cardbus) does not work on Lombard since
> ~2.6.12 (2 years old bug instantly crashing the kernel!) according to
> own experiences, Google and own git-bisecting down to 2.6.13,
> compiling and running different kernels. 2.6.12 appears to require the
> 'old-style' PCMCIA tools, which I do not have installed and is
> therefore impossible for me to test.

Hrm. If Paul brings his Lombard to work next week, I can have a look.

Cheers,
Ben.
