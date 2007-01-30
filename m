Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 708B9DDE31
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 13:49:38 +1100 (EST)
Subject: Re: EMAC OF binding....
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1170121832.26655.301.camel@localhost.localdomain>
References: <OF7EF2F643.75F7008B-ON8625725D.00157658-8625725D.00167CB4@au1.ibm.com>
	<1168236558.22458.187.camel@localhost.localdomain>
	<8ee3d13b73a511a785ac4744c268943e@kernel.crashing.org>
	<1170116712.26655.293.camel@localhost.localdomain>
	<7BADAAC7-D139-4C1A-A799-93F46508880E@kernel.crashing.org>
	<1170121832.26655.301.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 30 Jan 2007 13:49:26 +1100
Message-Id: <1170125366.26655.313.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Christian Rund <Christian.Rund@de.ibm.com>,
	Murali N Iyer <mniyer@us.ibm.com>, Hartmut Penner <HPENNER@de.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-01-30 at 12:50 +1100, Benjamin Herrenschmidt wrote:
> > Does emac really vary that much between the chips its in?  I know  
> > chatting with Ben that axon did some evil things, but how much  
> > difference exists on 4xx implementations?
> 
> They all seem to have subtle differences, which is why I want the actual
> chip to be the first entry in the compatible property.

Note that the goal here is not to have different drivers bind on it, but
more to allow to use device_is_compatible() and/or use the void * data
of the probe list as a feature bits field.

Ben.
