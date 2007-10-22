Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Make fdt_string() return a const pointer 
In-Reply-To: Your message of "Thu, 18 Oct 2007 12:10:42 +1000."
	<20071018021042.GC24236@localhost.localdomain>
References: <20071018021042.GC24236@localhost.localdomain> 
Date: Mon, 22 Oct 2007 11:37:43 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Ik0Hf-0002ws-2r@jdl.com>
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
> Currently, fdt_string() returns a (non-const) char *, despite taking a
> const void *fdt.  This is inconsistent with all the other read-only
> functions which all return const pointers into the blob.
> 
> This patch fixes that.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
