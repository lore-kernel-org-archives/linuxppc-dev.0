Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Remove space from flex command line 
In-Reply-To: Your message of "Thu, 06 Dec 2007 13:07:50 +1100."
	<20071206020750.GE17577@localhost.localdomain>
References: <20071206020750.GE17577@localhost.localdomain> 
Date: Thu, 06 Dec 2007 09:19:48 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1J0IVw-00057d-TT@jdl.com>
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
> Author: Geoff Levand <geoffrey.levand@am.sony.com>
> 
> Apparently some versions of flex don't correctly parse the -o
> parameter, if there's a space between the -o and its argument.  So,
> this patch removes it.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Note, the way to specify the Author of a git patch is to
include the "From: Name <addr>" line at the beginning of
the patch's log message.

Oh, and, the author's SOB should be there too...? :-)

Thanks,
jdl
