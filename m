Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 46A4E67B32
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 17:45:55 +1000 (EST)
Subject: Re: new IRQ work status
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bob Brose <linuxppcdev@qbjnet.com>
In-Reply-To: <20060630045711.21347.qmail@kunk.qbjnet.com>
References: <20060630045711.21347.qmail@kunk.qbjnet.com>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 17:45:45 +1000
Message-Id: <1151653546.13194.3.camel@localhost.localdomain>
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

On Fri, 2006-06-30 at 04:57 +0000, Bob Brose wrote:
> Ben Said:
> > 
> > Here's a progress report on my new irq management work.
> .
> .
> > validate as much as the core as possible. I still need to port over chrp
> > and maple which are easy, and powermac which will be a bit more
> > difficult as it relies a lot more on intrs/n_intrs in the device-nodes
> > which I've now removed.
> > 
> > Hopefully, it should be finished this week. The current serie of patch
> > applies on top of 2.6.17-mm1. I will do a version on top of the powerpc
> > tree as soon as the genirq port is upstream (which hopefully should
> > happen soon, possibly tomorrow).
> .
> . 
> > Comments welcome.
> 
> Any chance you can fix the 6 slot S900 irq problem when you do the powermac
> changes??

I'll look at it after I have done the initial set of patches... it's a
bug fix so there is a bit less hurry for 2.6.18 merge window

Ben.
