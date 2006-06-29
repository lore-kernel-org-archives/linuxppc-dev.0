Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] [powerpc] change get_property to return void *
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeremy Kerr <jk@ozlabs.org>
In-Reply-To: <1151576898.883498.737885160345.qpush@pokey>
References: <1151576898.883498.737885160345.qpush@pokey>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 20:37:16 +1000
Message-Id: <1151577436.28229.47.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-06-29 at 20:28 +1000, Jeremy Kerr wrote:
> Change the get_property() function to return a void *. This allows us
> to later remove the cast done in the majority of callers.
> 
> Built for pseries, iseries, pmac32, cell, cbesim, g5, systemsim, maple,
> and mpc* defconfigs
> 
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

It was time to do that !

Acked-by: Benjamin Herremschmidt <benh@kernel.crashing.org>
