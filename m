Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJzCK5gYrzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 00:17:49 +1100 (AEDT)
In-Reply-To: <147927393883.28364.12544121254023856142.stgit@jupiter.in.ibm.com>
To: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andonnel@au1.ibm.com>
Subject: Re: powernv/hmi: Display the correct error info for CAPP errors.
Message-Id: <3vJzCK4xYGz9s7H@ozlabs.org>
Date: Fri, 10 Feb 2017 00:17:49 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-11-16 at 05:28:02 UTC, Mahesh Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> On some CAPP errors we see console messages that prints unknown HMIs for
> which CAPI recovery is in progress. This patch fixes this by printing
> correct error info for HMI generated due to CAPP recovery.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Tested-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/470a36a8c014e5cac7bb2df3829485

cheers
