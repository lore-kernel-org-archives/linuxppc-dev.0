Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Move tree checking code to checks.c 
In-Reply-To: Your message of "Thu, 01 Nov 2007 16:49:26 +1100."
	<20071101054926.GC18744@localhost.localdomain>
References: <20071101054926.GC18744@localhost.localdomain> 
Date: Thu, 01 Nov 2007 08:08:23 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1InZmZ-0003jd-F6@jdl.com>
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
> This patch moves the dtc code for checking the device tree its
> processing into a new checks.c.  The tree accessor functions from
> livetree.c which the checks use are exported and added to dtc.h.
> 
> Another small step towards a flexible checking architecture.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
