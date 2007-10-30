Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Correctly handle versions > 17 
In-Reply-To: Your message of "Tue, 30 Oct 2007 13:22:12 +1100."
	<20071030022212.GB30041@localhost.localdomain>
References: <20071030022212.GB30041@localhost.localdomain> 
Date: Tue, 30 Oct 2007 07:50:54 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1ImqYY-0002ns-Bm@jdl.com>
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
> If future dtb version > 17 are defined, that are still backwards
> compatible with v16, libfdt will of course be able to read and
> understand them.  However, when modifying such a tree, it can't
> guarantee that it won't clobber additional structure from the new
> version which it doesn't know about.  Therefore, before making
> modifications to a tree of version >17, we must change it's version to
> be exactly 17.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
