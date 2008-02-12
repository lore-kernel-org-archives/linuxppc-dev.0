Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Add and use a node iteration helper function. 
In-Reply-To: Your message of "Tue, 12 Feb 2008 11:58:31 +1100."
	<20080212005831.GH18348@localhost.localdomain>
References: <20080212005831.GH18348@localhost.localdomain> 
Date: Tue, 12 Feb 2008 09:15:59 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JOwrX-0003Uq-Pl@jdl.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> This patch adds an fdt_next_node() function which can be used to
> iterate through nodes of the tree while keeping track of depth.  This
> function is used to simplify the iteration code in a lot of other
> functions, and is also exported for use by library users.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> ---
> 
> I think we're ready to go with this one.  I'm still thinking about
> suitable for_each_* macros, but in the mean time I'm happy with the
> exported interface here, and it's a code-reducing patch.

Applied.

Thanks,
jdl
