Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9BED4DDF65
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2008 22:19:20 +1000 (EST)
Subject: Re: [PATCH] powerpc: Fix a typo that breaks canyonland support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081003120441.GB2229@yoda.jdub.homelinux.org>
References: <20081003093338.50543DDF78@ozlabs.org>
	<20081003120441.GB2229@yoda.jdub.homelinux.org>
Content-Type: text/plain
Date: Fri, 03 Oct 2008 22:18:06 +1000
Message-Id: <1223036286.12264.179.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-10-03 at 08:04 -0400, Josh Boyer wrote:
> On Fri, Oct 03, 2008 at 07:33:20PM +1000, Benjamin Herrenschmidt wrote:
> >A typo in the new ppc4xx_simple.c prevents proper detection of
> >the AMCC Canyonland board.
> >
> >Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> This is already fixed in my 'next' branch.

Ah well, I was waiting for you to ask me to pull it :-)

Ben.
