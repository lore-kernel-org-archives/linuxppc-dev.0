Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1EDE41A010A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 20:46:38 +1100 (AEDT)
In-Reply-To: <1449554365-22036-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Daniel Axtens <dja@axtens.net>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [v2] Revert "powerpc/eeh: Don't unfreeze PHB PE after reset"
Message-Id: <20151214094637.C6B3F140556@ozlabs.org>
Date: Mon, 14 Dec 2015 20:46:37 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-08-12 at 05:59:25 UTC, Andrew Donnellan wrote:
> This reverts commit 527d10ef3a315d3cb9dc098dacd61889a6c26439.
> 
> The reverted commit breaks cxlflash devices following an EEH reset (and
> possibly other cxl devices, however this has not been tested).
...
> 
> In the meantime, revert the commit, especially as it was intended to be a
> non-functional change.
> 
> Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Cc: Ian Munsie <imunsie@au1.ibm.com>
> Cc: Daniel Axtens <dja@axtens.net>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/dc9c41bd9ece090b54eb8f1b

cheers
