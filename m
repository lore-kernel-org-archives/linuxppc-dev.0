Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EAE801A0342
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 23:41:27 +1100 (AEDT)
In-Reply-To: <1455002269-26543-2-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com
Subject: Re: [V2,2/2] powerpc/xmon: add command to dump OPAL msglog
Message-Id: <20160217124127.C2C07140778@ozlabs.org>
Date: Wed, 17 Feb 2016 23:41:27 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-09-02 at 07:17:49 UTC, Andrew Donnellan wrote:
> Add the 'do' command to dump the OPAL msglog in xmon.
> 
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fde93a0f774f510bfaabccd5ba

cheers
