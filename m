Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B5690100896
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2011 16:54:02 +1000 (EST)
Subject: Re: [PATCH 15/15] powerpc: Improve prom_printf()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <56030.94.211.195.167.1301986049.squirrel@gate.crashing.org>
References: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
	<1301984051-18413-16-git-send-email-benh@kernel.crashing.org>
	<56030.94.211.195.167.1301986049.squirrel@gate.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Apr 2011 16:53:54 +1000
Message-ID: <1301986434.2549.144.camel@pasglop>
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

On Tue, 2011-04-05 at 08:47 +0200, Segher Boessenkool wrote:
> Hi Ben,
> 
> > +		case 'd':
> > +			++q;
> > +			vs = va_arg(args, long);
> 
> 'd' takes an int, not a long.

Oops :-) Indeed ... copy/lpaste bogon I think

> > +			if (vs < 0) {
> > +				prom_print("-");
> 
> RELOC()?

Interesting, I had that bug and fixed it in the "ld" case and not the
"d" case :-)

Thanks !

Cheers,
Ben.
