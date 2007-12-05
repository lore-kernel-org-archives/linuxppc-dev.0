Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Fix FAIL() macro varargs 
In-Reply-To: Your message of "Wed, 05 Dec 2007 09:34:53 +1100."
	<20071204223453.GA9406@localhost.localdomain>
References: <20071204223453.GA9406@localhost.localdomain> 
Date: Wed, 05 Dec 2007 08:39:53 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IzvPl-0005Zm-3G@jdl.com>
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
> The way the checking subsystem FAIL() macro is currently implemented
> it must take at least one paramater after the format string.  This
> patch corrects the problem.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
