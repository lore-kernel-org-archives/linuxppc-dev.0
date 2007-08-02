Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] fixes for the SLB shadow buffer 
In-reply-to: <1186045096.5495.617.camel@localhost.localdomain> 
References: <17055.1185944172@neuling.org>
	<18096.6654.934841.561238@cargo.ozlabs.ibm.com>
	<31580.1185948147@neuling.org>
	<1186004885.22717.50.camel@farscape.rchland.ibm.com>
	<24613.1186034191@neuling.org>
	<1186039870.5495.595.camel@localhost.localdomain>
	<13166.1186045008@neuling.org>
	<1186045096.5495.617.camel@localhost.localdomain>
Date: Thu, 02 Aug 2007 19:03:25 +1000
Message-ID: <17854.1186045405@neuling.org>
Cc: linuxppc-dev@ozlabs.org, will_schmidt@vnet.ibm.com,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Thu, 2007-08-02 at 18:56 +1000, Michael Neuling wrote:
> > > > But even in the case of a checkpoint restart, the ordering will be
> > > > preserved as the NIA we get as part of the checkpoint will have
> > all
> > > > previous instructions complete and none of the following
> > instructions
> > > > started.
> > > 
> > > Instruction completion isn't enough to ensure storage ordering. The
> > > stores may well be complete but the data still in separate store
> > queues.
> > 
> > POWER6 flushes the store queues when we take a checkpoint.  
> 
> Ok, that was missing from your description :-)

Sorry... so ditch the barriers?

Mikey
