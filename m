Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Make helper macros in trees.S more flexible 
In-Reply-To: Your message of "Thu, 18 Oct 2007 14:14:09 +1000."
	<20071018041409.GC8206@localhost.localdomain>
References: <20071018041409.GC8206@localhost.localdomain> 
Date: Mon, 22 Oct 2007 11:38:05 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Ik0I1-0002xC-SI@jdl.com>
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
> This patch makes the helper macros in trees.S use separate labels for
> the end of each dt subblock, rather than using only start labels.
> This means that the macros can now be used to create trees with the
> subblocks in non-standard orders.
> 
> In addition, it adds a bunch of extra ; after lines of asm code in
> macros, making them safe to use in nested macros.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
