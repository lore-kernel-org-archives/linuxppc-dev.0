Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Fix uninitialized use of structure_ok 
In-Reply-To: Your message of "Tue, 04 Dec 2007 11:49:43 +1100."
	<20071204004943.GD32577@localhost.localdomain>
References: <20071204004943.GD32577@localhost.localdomain> 
Date: Tue, 04 Dec 2007 07:28:30 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IzXp8-0005VB-JM@jdl.com>
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
> My rework of the tree checking code introduced a potentially nasty bug
> - it uses the structure_ok variable uninitialized.  This patch fixes
> the problem.  It's a fairly ugly bandaid approach, but the ugly will
> disappear once future patches have folded the semantic checks into the
> new framework.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Thanks!
jdl
