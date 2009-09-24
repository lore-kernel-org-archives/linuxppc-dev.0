Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1D7CEB7B76
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 11:13:38 +1000 (EST)
Subject: Re: [PATCH] powerpc/mm: Fix 40x and 8xx vs. _PAGE_SPECIAL
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rex Feany <RFeany@mrv.com>
In-Reply-To: <20090924005300.GB11737@compile2.chatsunix.int.mrv.com>
References: <1253679146.7103.270.camel@pasglop>
	<20090924005300.GB11737@compile2.chatsunix.int.mrv.com>
Content-Type: text/plain
Date: Thu, 24 Sep 2009 11:13:31 +1000
Message-Id: <1253754811.7103.365.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, "Weirich,
	Bernhard" <Bernhard.Weirich@riedel.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-09-23 at 17:53 -0700, Rex Feany wrote:
> this is running on a MPC 875, and I'm happy to test any patches or
> add any debugging code if it helps.

Hrm... smells like something screwy in the 8xx PTE handling.

Let me have another look.

Cheers,
Ben.
