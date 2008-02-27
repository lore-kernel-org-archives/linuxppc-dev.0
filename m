Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 72A6CDDE11
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 11:46:28 +1100 (EST)
Subject: Re: Patches added to master & powerpc-next branches of powerpc.git
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18372.45605.265760.646342@cargo.ozlabs.ibm.com>
References: <18371.65529.312001.673609@cargo.ozlabs.ibm.com>
	<1204070815.15052.194.camel@pasglop>
	<18372.45605.265760.646342@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 27 Feb 2008 11:46:07 +1100
Message-Id: <1204073167.15052.202.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-02-27 at 11:43 +1100, Paul Mackerras wrote:
> Benjamin Herrenschmidt writes:
> 
> > On Tue, 2008-02-26 at 23:03 +1100, Paul Mackerras wrote:
> > > Benjamin Herrenschmidt (1):
> > >       [POWERPC] Fix thinko in cpu_thread_mask_to_cores()
> > > 
> > 
> > Any reason why this isn't going into .25 ?
> 
> I thought you said nothing uses it.

I'm worried some out of tree stuff might...

But if not, yeah, it's fine.

Ben.
