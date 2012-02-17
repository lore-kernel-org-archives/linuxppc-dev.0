Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D775A1007D6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 19:50:31 +1100 (EST)
Message-ID: <1329468623.2892.62.camel@pasglop>
Subject: Re: [RFC PATCH 13/16] powerpc/booke: Provide exception macros with
 interrupt name
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Fri, 17 Feb 2012 19:50:23 +1100
In-Reply-To: <20111221013440.GM8378@schlenkerla.am.freescale.net>
References: <20111221013440.GM8378@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, agraf@suse.de,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-12-20 at 19:34 -0600, Scott Wood wrote:
> 
> There is an existing set of arbitrary numbers that Linux passes,
> but it's an undocumented mess that sort of corresponds to
> server/classic
> exception vectors but not really.
> 
> FIXME: Replace the existing trap numbering rather than add to it.

While this is a good idea, the problem is that we do have quite a few
things here or there that check regs->trap and act based on the trap
number, so we'd have to find them all and replace those comparison with
something symbolic.

Cheers,
Ben.
