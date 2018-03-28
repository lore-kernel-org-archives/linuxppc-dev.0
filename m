Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B8xK1ywfzF2MD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 01:13:25 +1100 (AEDT)
In-Reply-To: <1521067243-19520-2-git-send-email-mauricfo@linux.vnet.ibm.com>
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, msuchanek@suse.de
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v3,
 1/5] rfi-flush: Move the logic to avoid a redo into the debugfs code
Message-Id: <40B8xJ44w2z9s19@ozlabs.org>
Date: Thu, 29 Mar 2018 01:13:24 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-03-14 at 22:40:38 UTC, Mauricio Faria de Oliveira wrote:
> From: Michael Ellerman <mpe@ellerman.id.au>
> 
> rfi_flush_enable() includes a check to see if we're already
> enabled (or disabled), and in that case does nothing.
> 
> But that means calling setup_rfi_flush() a 2nd time doesn't actually
> work, which is a bit confusing.
> 
> Move that check into the debugfs code, where it really belongs.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1e2a9fc7496955faacbbed49461d61

cheers
