Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0134.outbound.protection.outlook.com [65.55.169.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 527321A0047
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2015 03:26:00 +1000 (AEST)
Message-ID: <1429291534.4352.2.camel@freescale.com>
Subject: Re: [PATCH v5 0/5] powerpc8xx: Further optimisation of TLB handling
From: Scott Wood <scottwood@freescale.com>
To: root <christophe.leroy@c-s.fr>
Date: Fri, 17 Apr 2015 12:25:34 -0500
In-Reply-To: <cover.1429287688.git.christophe.leroy@c-s.fr>
References: <cover.1429287688.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-04-17 at 18:32 +0200, root wrote:
> This patchset provides a further optimisation of TLB handling in the 8xx.
> Changes are:
> - Not saving registers like CR when not needed
> - Adding support to any TASK_SIZE
> 
> Only the last patch of the set is changed compared to v4
> 
> Christophe Leroy (5):
>   powerpc/8xx: macro for handling CPU15 errata
>   powerpc/8xx: Handle CR out of exception PROLOG/EPILOG
>   powerpc/8xx: dont save CR in SCRATCH registers
>   powerpc/8xx: Use SPRG2 instead of DAR for saving r3
>   powerpc/8xx: Add support for TASK_SIZE greater than 0x80000000
> 
>  arch/powerpc/kernel/head_8xx.S | 79 +++++++++++++++++++++++++++---------------
>  1 file changed, 51 insertions(+), 28 deletions(-)
> 

Do you really want your name in the git history to be "root"?

-Scott
