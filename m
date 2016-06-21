Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYTRT2bJCzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 10:40:53 +1000 (AEST)
In-Reply-To: <1460955830-27267-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: imunsie@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
 clombard@linux.vnet.ibm.com
Subject: Re: cxl: static-ify variables to fix sparse warnings
Message-Id: <3rYTRS6XnYz9sxb@ozlabs.org>
Date: Tue, 21 Jun 2016 10:40:52 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-18-04 at 05:03:50 UTC, Andrew Donnellan wrote:
> Make a couple more variables static. Found by sparse.
> 
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Reviewed-by: fbarrat@linux.vnet.ibm.com
> Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/64417a398973d964139306c0b1

cheers
