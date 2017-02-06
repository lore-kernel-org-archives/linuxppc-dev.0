Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHK5Z4sCyzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 07:37:06 +1100 (AEDT)
In-Reply-To: <20170201032207.14940-1-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: imunsie@au1.ibm.com, fbarrat@linux.vnet.ibm.com
Subject: Re: [v2] cxl: fix build when CONFIG_DEBUG_FS=n
Message-Id: <3vHK5Z4J8Wz9s7H@ozlabs.org>
Date: Tue,  7 Feb 2017 07:37:06 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-02-01 at 03:22:07 UTC, Andrew Donnellan wrote:
> Stub out the debugfs functions so that the build doesn't break when
> CONFIG_DEBUG_FS=n.
> 
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/39d40871526627fd0e2cfc1e2fb885

cheers
