Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 538C91A076A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 09:14:17 +1000 (AEST)
In-Reply-To: <1439859460-7497-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: powerpc: Export include/uapi/asm/eeh.h
Message-Id: <20150819231416.D4CA114099F@ozlabs.org>
Date: Thu, 20 Aug 2015 09:14:16 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-18-08 at 00:57:40 UTC, Gavin Shan wrote:
> This adds include/uapi/asm/eeh.h to kbuild so that the header
> file will be exported automatically with below command. The
> header file was added by commit ed3e81f ("powerpc/eeh: Move PE
> state constants around")
> 
>    make INSTALL_HDR_PATH=/tmp/headers \
>         SRCARCH=powerpc headers_install
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/dd497154d359ba9d2d3e

cheers
