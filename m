Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17256.17408.247708.622755@cargo.ozlabs.ibm.com>
Date: Wed, 2 Nov 2005 15:43:44 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1130861207.21212.66.camel@hades.cambridge.redhat.com>
References: <17253.39993.502458.390760@cargo.ozlabs.ibm.com>
	<1130861207.21212.66.camel@hades.cambridge.redhat.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: please pull the powerpc-merge.git tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse writes:

> The ppc64 build (http://david.woodhou.se/powerpc-merge-64.config) fares
> worse than ppc32 for me -- it doesn't even build. 

Those errors were all due to getting powerbook sleep code included
because you have CONFIG_PM=y.  I have changed things so that that code
doesn't get included on a 64-bit build (at least until BenH gets sleep
going on the G5 :).

I also pulled in Linus' tree, and now drivers/char/tlclk.c fails to
build for some reason.  I claim that's not my fault, however. :)

Paul.
