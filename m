Return-Path: <linuxppcdev@qbjnet.com>
Received: from kunk.qbjnet.com (ddsl1-28.ddsl.mr.net [137.192.135.28])
	by ozlabs.org (Postfix) with SMTP id BCA7B67B55
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 15:03:54 +1000 (EST)
Date: 30 Jun 2006 04:57:11 -0000
Message-ID: <20060630045711.21347.qmail@kunk.qbjnet.com>
From: "Bob Brose" <linuxppcdev@qbjnet.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: new IRQ work status
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben Said:
> 
> Here's a progress report on my new irq management work.
.
.
> validate as much as the core as possible. I still need to port over chrp
> and maple which are easy, and powermac which will be a bit more
> difficult as it relies a lot more on intrs/n_intrs in the device-nodes
> which I've now removed.
> 
> Hopefully, it should be finished this week. The current serie of patch
> applies on top of 2.6.17-mm1. I will do a version on top of the powerpc
> tree as soon as the genirq port is upstream (which hopefully should
> happen soon, possibly tomorrow).
.
. 
> Comments welcome.

Any chance you can fix the 6 slot S900 irq problem when you do the powermac
changes??

Bob
