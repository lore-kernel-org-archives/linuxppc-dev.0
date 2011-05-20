Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EB7EEB71A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 May 2011 08:30:54 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc/book3e-64: hv exceptions aren't MASKABLE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20110520190030.GA7058@schlenkerla.am.freescale.net>
References: <20110520190030.GA7058@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 21 May 2011 08:30:46 +1000
Message-ID: <1305930646.7481.196.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-05-20 at 14:00 -0500, Scott Wood wrote:
> In general we will not have EE soft-disabled or be napping when
> these exceptions happen, but still it is not correct.
> 
> The guest doorbell exceptions can only be triggered with MSR[GS]=1,
> and thus for host kernel nesting purposes are base-level exceptions.
> 
> Note that ehpriv and hypercall are triggerable from normal userspace.
> I tested that the process gets properly signalled in this case.

Please split the renaming of type->level from the actual functional
patch.

Cheers,
Ben.
