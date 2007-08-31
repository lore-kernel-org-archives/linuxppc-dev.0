Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Fix use of uninitialized variable in fdt_get_path() 
In-Reply-To: Your message of "Fri, 31 Aug 2007 14:30:16 +1000."
	<20070831043016.GM19271@localhost.localdomain>
References: <20070831043016.GM19271@localhost.localdomain> 
Date: Fri, 31 Aug 2007 08:38:02 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IR6hG-0002gS-Cc@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> My recent implemenetation of fdt_get_path() had a bug - the while loop
> tested offset which was unitialized on the first iteration.  Depending
> on code surrounding the call, this could cause fdt_get_path() to
> return incorrect results.
> 
> This patch corrects the problem by applying some more correct thinking
> to the loop condition.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Thanks,
jdl
