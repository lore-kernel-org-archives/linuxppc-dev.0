Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVGN948CCzDqmV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 15:13:45 +1100 (AEDT)
In-Reply-To: <87oa0zpcvg.fsf_-_@linux-m68k.org>
To: Andreas Schwab <schwab@linux-m68k.org>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [v2] adb: properly mark continued kernel messages
Message-Id: <3zVGN92DrTz9s8J@ozlabs.org>
Date: Mon, 29 Jan 2018 15:13:45 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-11-28 at 20:29:07 UTC, Andreas Schwab wrote:
> Use pr_cont where appropriate, and switch to pr_foo throughout.
> Additionally, lower messages in adb_probe_task to debug level.
> 
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f2be6295684b0fe879a824ac974797

cheers
