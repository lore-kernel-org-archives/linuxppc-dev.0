Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BBB0ADDF39
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 08:29:30 +1100 (EST)
Date: Fri, 21 Dec 2007 15:28:56 -0600
From: Scott Wood <scottwood@freescale.com>
To: jdl@jdl.com, linuxppc-dev@ozlabs.org, u-boot-users@lists.sourceforge.net
Subject: Re: [DTC PATCH 1/2] Add yyerrorf() for formatted error messages.
Message-ID: <20071221212856.GA8208@ld0162-tx32.am.freescale.net>
References: <20071220164823.GA32193@ld0162-tx32.am.freescale.net>
	<20071221000439.GC2665@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071221000439.GC2665@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 21, 2007 at 11:04:39AM +1100, David Gibson wrote:
> On Thu, Dec 20, 2007 at 10:48:23AM -0600, Scott Wood wrote:
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> 
> No need for a new function.  If yyerror() is defined as a varargs
> function it's still compatible with bison's built-in usage.

Not if yyerror() is called with a percent symbol in the string, which
looks possible if a percent token is added and verbose syntax errors are
enabled.

-Scott
