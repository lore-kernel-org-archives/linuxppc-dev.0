Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1BBC4B70E0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 08:13:30 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5CA03DDD04
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 08:13:29 +1000 (EST)
Subject: Re: Preemption question (4xx related)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Felix Radensky <felix@embedded-sol.com>
In-Reply-To: <24271342.post@talk.nabble.com>
References: <24271342.post@talk.nabble.com>
Content-Type: text/plain
Date: Thu, 02 Jul 2009 08:13:13 +1000
Message-Id: <1246486393.14483.14.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-06-30 at 05:55 -0700, Felix Radensky wrote:
> Hi,
> 
> Preemption is disabled on the vast majority of powerpc
> targets. Are there any known problems in this area ?
> I'd like to enable CONFIG_PREEMPT_VOLUNTARY on
> AMCC 405EX target, to increase application responsiveness.
> Is it a bad idea ?

In theory it should work, but as you may have noticed, it's generally
disabled and thus not very well tested.

It would be a good idea for us, some of the core devs, to turn that on
in our usual test configs in fact.

Cheers,
Ben.
