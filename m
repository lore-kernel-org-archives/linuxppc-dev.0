Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415zn01zZRzDrpC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 20:06:58 +1000 (AEST)
To: Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Subject: stacktrace.c:(.text+0x1b0): undefined reference to
 `.smp_send_safe_nmi_ipi'
Message-ID: <0ae99ba5-e721-dada-8d94-b223e41977e9@c-s.fr>
Date: Thu, 14 Jun 2018 12:06:51 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

See http://kisskb.ellerman.id.au/kisskb/buildresult/13395345/ for details

Seems like that function only exists when CONFIG_NMI_IPI is defined.

Problem introduced by commit 5cc05910f26e6fd6da15f052f86f6150e4b91664 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/powerpc/kernel/stacktrace.c?h=next-20180614&id=5cc05910f26e6fd6da15f052f86f6150e4b91664


What do you recommend to fix that ?


Christophe
