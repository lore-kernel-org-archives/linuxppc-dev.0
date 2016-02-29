Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 32DDA1A0035
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 22:05:25 +1100 (AEDT)
In-Reply-To: <1455763681-13663-1-git-send-email-bsingharora@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: paulus@samba.org
Subject: Re: [RESEND] Fix BUG_ON() reporting in real mode on PPC
Message-Id: <20160229110525.09317140317@ozlabs.org>
Date: Mon, 29 Feb 2016 22:05:24 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-18-02 at 02:48:01 UTC, Balbir Singh wrote:
> Changelog:
>     Don't use REGION_ID, breaks on some platforms
>     Don't blindly add PAGE_OFFSET to bugaddr
> 
> I ran into this issue while debugging an early boot problem.
> The system hit a BUG_ON() but report bug failed to print the
> line number and file name. The reason being that the system
> was running in real mode and report_bug() searches for
> addresses in the PAGE_OFFSET+ region
> 
> Suggested-by: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a4c3f909b4d9bb9430bf42ad58

cheers
