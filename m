Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E79F6DDE16
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 13:09:08 +1000 (EST)
Subject: Re: fsl booke MM vs. SMP questions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Liu <r63238@freescale.com>
In-Reply-To: <1179887929.3656.2.camel@localhost.localdomain>
References: <1179731215.32247.659.camel@localhost.localdomain>
	<1179741447.3660.7.camel@localhost.localdomain>
	<1179742083.32247.689.camel@localhost.localdomain>
	<1179747448.3660.22.camel@localhost.localdomain>
	<1179785273.32247.742.camel@localhost.localdomain>
	<1179803367.32247.785.camel@localhost.localdomain>
	<1179831375.3827.4.camel@localhost.localdomain>
	<1179873742.32247.864.camel@localhost.localdomain>
	<1179887929.3656.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 23 May 2007 13:08:56 +1000
Message-Id: <1179889736.32247.893.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-23 at 10:38 +0800, Dave Liu wrote:
> On Wed, 2007-05-23 at 08:42 +1000, Benjamin Herrenschmidt wrote:
> 
> > The IPIs should be buffered by the PIC ... delivered only once but
> 
> but what is the buffer depth for IPIs in the PIC?

One :-)

You never "loose" IPIs in the sense that you always get at least 1
interrupt for N IPIs and it's up to software to make sure not to lose
any event. The linux kernel arch code usually handles that with a
synchronous IPI mecanism.

Ben.
