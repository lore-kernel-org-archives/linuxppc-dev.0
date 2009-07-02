Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 67F38B7123
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 17:33:39 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9FFE8DDDA1
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 17:33:37 +1000 (EST)
Subject: Re: Preemption question (4xx related)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20090702001450.GF6189@zod.rchland.ibm.com>
References: <24271342.post@talk.nabble.com> <1246486393.14483.14.camel@pasglop>
	<20090702001450.GF6189@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Thu, 02 Jul 2009 17:33:12 +1000
Message-Id: <1246519992.7551.1.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Felix Radensky <felix@embedded-sol.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-07-01 at 20:14 -0400, Josh Boyer wrote:

> I've toyed with that idea myself.  I keep coming back to the fact that you need
> a workload that would really leverage it, and I don't have one at the moment.

To some extent that's true but just turning full preemption including
kernel side with all the associated debug bits and lockdep should make a
whole bunch of things show up even with ordinary workloads.

For 440 tend to boot an ubuntu distro off NFS root with all X & DRI 3D
etc... and then run compiz :-)

Cheers,
Ben.
