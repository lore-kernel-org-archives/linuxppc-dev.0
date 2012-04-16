Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 8E703B6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2012 18:37:40 +1000 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1334552674-24107-1-git-send-email-paul.gortmaker@windriver.com>
References: <1334552674-24107-1-git-send-email-paul.gortmaker@windriver.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] powerpc: fix system.h fallout in sysdev/scom.c
 [chroma_defconfig]
Date: Mon, 16 Apr 2012 09:37:33 +0100
Message-ID: <8886.1334565453@redhat.com>
Sender: dhowells@redhat.com
Cc: dhowells@redhat.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> The following shows up in chroma_defconfig:
> 
>  CC      arch/powerpc/sysdev/scom.o
> arch/powerpc/sysdev/scom.c: In function 'scom_debug_init':
> arch/powerpc/sysdev/scom.c:182:36: error: 'powerpc_debugfs_root' undeclared (first use in this function)
> arch/powerpc/sysdev/scom.c:182:36: note: each undeclared identifier is reported only once for each function it appears in
> make[2]: *** [arch/powerpc/sysdev/scom.o] Error 1
> make[1]: *** [arch/powerpc/sysdev/scom.o] Error 2
> 
> A bisect leads to commit 9ffc93f203c18a70623f21950f1dd473c9ec48cd
> 
>     "Remove all #inclusions of asm/system.h"
> 
> Add the debug header which contains powerpc_debugfs_root.
> 
> Cc: David Howells <dhowells@redhat.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Acked-by: David Howells <dhowells@redhat.com>
