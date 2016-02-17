Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E4F9C1A0342
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 23:41:26 +1100 (AEDT)
In-Reply-To: <1455002269-26543-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com
Subject: Re: [V2,1/2] powerpc/powernv: new function to access OPAL msglog
Message-Id: <20160217124126.83F60140662@ozlabs.org>
Date: Wed, 17 Feb 2016 23:41:26 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-09-02 at 07:17:48 UTC, Andrew Donnellan wrote:
> Currently, the OPAL msglog/console buffer is exposed as a sysfs file, with
> the sysfs read handler responsible for retrieving the log from the OPAL
> buffer. We'd like to be able to use it in xmon as well.
> 
> Refactor the OPAL msglog code to create a new function, opal_msglog_copy(),
> that copies to an arbitrary buffer. Separate the initialisation code into
> generic memcons init and sysfs file creation.
> 
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9b4fffa14906fce7aabf1f032d


I see you've posted a v3 since I merged this, please send an incremental patch
with the changes.

cheers
