Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qk8fR5HtGzDq9q
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 22:35:11 +1000 (AEST)
In-Reply-To: <1441063363-24107-1-git-send-email-vipin@linux.vnet.ibm.com>
To: Vipin K Parashar <vipin@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com, Vipin K Parashar <vipin@linux.vnet.ibm.com>
Subject: Re: asm/opal-api: Assign numbers to OPAL_MSG macros of enum
 opal_msg_type
Message-Id: <3qk8fR2zxnz9t3n@ozlabs.org>
Date: Mon, 11 Apr 2016 22:35:11 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-31-08 at 23:22:43 UTC, Vipin K Parashar wrote:
> This patch assigns numbers to OPAL_MSG macros of enum opal_msg_type
> to prevent accidental insertion of any new value in between and thus
> break OPAL API. This is also helpful while backporting mainline kernel
> changes to distros which run downlevel kernel and thus don't have all
> OPAL messages defined, avoiding unnecessary bugs due to enum values
> order mismatch.
> 
> Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
> Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b3d79eaa6c97b04965fa479652

cheers
