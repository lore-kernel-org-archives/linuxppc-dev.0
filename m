Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id 3C438DEAD8
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Apr 2008 01:30:42 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so1064416pyg.27
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 08:30:41 -0700 (PDT)
Subject: Re: [PATCH] [PPC] 4xx: Fix arch/ppc 440 builds
From: Josh Boyer <jwboyer@gmail.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1208618775.6654.12.camel@vader.jdub.homelinux.org>
References: <1208618775.6654.12.camel@vader.jdub.homelinux.org>
Content-Type: text/plain
Date: Sat, 19 Apr 2008 10:30:36 -0500
Message-Id: <1208619036.6654.14.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2008-04-19 at 10:26 -0500, Josh Boyer wrote:
> Commit d04ceb3fc294ea2c4f538a04343f3a473953a3b0 moved phys_addr_t definitions
> to include/asm-powerpc/types.h.  However, arch/ppc 440 builds had a duplicate
> definition in include/asm-ppc/mmu.h that caused the build to fail.
> 
> This removes the duplicate definition in arch/ppc.
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Ignore this.  The patch is correct but the subject is misleading because
there is another commit that breaks arch/ppc builds for 440.

I'll resend once I fix that as well.  I hate arch/ppc.

josh
