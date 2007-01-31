Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [dtc] Bugfix for CHECK_HAVE_WARN_PHANDLE() 
In-Reply-To: Your message of "Wed, 31 Jan 2007 15:45:26 +1100."
	<20070131044525.GA25231@localhost.localdomain>
References: <20070131044525.GA25231@localhost.localdomain> 
Date: Wed, 31 Jan 2007 07:41:31 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HCFiN-0004mH-KP@jdl.com>
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
> At present, the tree checking code in dtc will die with an assertion
> failure if given a tree which has the invalid value 0 or -1 in a
> property which should contain a phandle.  This patch fixes the check
> to die more gracefully with an error message indicating the invalid
> phandle value.
> 
> Signed-off-by: David Gibson <dwg@au1.ibm.com>

Applied.

Thanks,
jdl
