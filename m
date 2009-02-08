Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] bootgraph: fix for use with dot symbols 
In-reply-to: <20090128105601.GB18368@kryten> 
References: <19599.1233113450@neuling.org> <497FE4E7.8070303@linux.intel.com>
	<20090128105601.GB18368@kryten>
Date: Sun, 08 Feb 2009 11:57:25 +1100
Message-ID: <18314.1234054645@neuling.org>
Sender: mikey@neuling.org
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > question for the ppc folks.... why does the "print symbol" magic format str
ing
> > thing print a dot symbol and not the real function name?
> > Should that be fixed instead?
> 
> We have two symbols for each function, foo points to the function
> descriptor, and .foo points to the instruction text. If we were to strip
> the '.' when we print symbols then it would become harder to diagnose
> some failures (eg branching to the function descriptor instead of the
> instruction text).

Arjan,

I don't think there is much scope for removing dot symbols in the near
future.

Can you please take the patch as is for now so bootgraph will at least
work for existing systems?

Mikey
