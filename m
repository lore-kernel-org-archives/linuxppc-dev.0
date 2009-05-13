Return-Path: <paulus@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 37F35DDFC0
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 15:15:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18954.22390.754419.803434@cargo.ozlabs.ibm.com>
Date: Wed, 13 May 2009 15:15:34 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Miller <davem@davemloft.net>
Subject: Re: question about softirqs
In-Reply-To: <20090512.214427.193728136.davem@davemloft.net>
References: <20090512081237.GA16403@elte.hu> <1242119578.11251.321.camel@twins>
	<20090512092348.GA29796@elte.hu>
	<20090512.214427.193728136.davem@davemloft.net>
Cc: a.p.zijlstra@chello.nl, linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	rostedt@goodmis.org, mingo@elte.hu, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller writes:

> I fully expected us to be, at this point, talking about putting the
> pending softirq check back into the trap return path :-/

Would that actually do any good, in the case where the system has
decided that ksoftirqd is handling soft irqs at the moment?

Paul.
