Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y702s32NXzDr1l
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 15:21:41 +1100 (AEDT)
In-Reply-To: <20170904084825.22172-1-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Alastair D'Silva <alastair@au1.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Subject: Re: [v2] cxl: Set the valid bit in PE for dedicated mode
Message-Id: <3y702s06cNz9t43@ozlabs.org>
Date: Thu,  5 Oct 2017 15:21:40 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-09-04 at 08:48:25 UTC, Vaibhav Jain wrote:
> Make sure to set the valid-bit in software-state field of the
> populated PE. This was earlier missing for dedicated mode AFUs, hence
> was causing a PSL freeze when the AFU was activated.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8512bffd6226fea259f94fd23fc3b6

cheers
