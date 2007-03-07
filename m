Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A1630DDE41
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 17:52:27 +1100 (EST)
Subject: Re: Clearing the interrupt
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: mohan@in.ibm.com
In-Reply-To: <20070307050800.GI7476@in.ibm.com>
References: <20070306173941.GE7476@in.ibm.com>
	<1173215087.9349.17.camel@localhost.localdomain>
	<20070307050800.GI7476@in.ibm.com>
Content-Type: text/plain
Date: Wed, 07 Mar 2007 07:52:14 +0100
Message-Id: <1173250334.9349.19.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-03-07 at 10:38 +0530, Mohan Kumar M wrote:
> On Tue, Mar 06, 2007 at 10:04:47PM +0100, Benjamin Herrenschmidt wrote:
> > > Is there any problem with the above approach? Is there any restriction
> > > such that a cpu which acknowledged the interrupt only should send the eoi
> > > signal?
> > 
> > While I don't think there -should- be any restriction, I also seem to
> > remember that the xics "emulation" done by the firmware on things like
> > JS20 requires the eoi to be done from the CPU where the interrupt
> > originated.
> >
> 
> Thanks Ben.
> 
> If thats the case, is it okay to call eoi handler from all cpus so that
> above case will be satisfied?

I suppose so.

Ben.
