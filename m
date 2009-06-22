Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [88.79.252.171])
	by bilbo.ozlabs.org (Postfix) with SMTP id 89C49B70B1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 00:56:01 +1000 (EST)
From: <Sergej.Stepanov@ids.de>
To: <chris.pringle@oxtel.com>, <scottwood@freescale.com>
Date: Mon, 22 Jun 2009 16:31:07 +0200
Subject: AW: PowerPC PCI DMA issues (prefetch/coherency?)
Message-ID: <4206182445660643B9AEB8D4E55BBD0A08533B67B5@HERMES2>
References: <4A37A503.3030209@oxtel.com>
	<20090616162114.GA5051@loki.buserror.net> <4A37C97A.5050508@oxtel.com>
	<4A37CC72.3060709@freescale.com> <4A37CF02.5080906@oxtel.com>
	<4A37D073.6020802@freescale.com> <4A38A21B.5060306@oxtel.com>
	<4A38ED31.9030705@oxtel.com>,<4A3A23FA.1000407@oxtel.com>
In-Reply-To: <4A3A23FA.1000407@oxtel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>The other part of the fix is in asm-powerpc/pgtable32.h. _PAGE_BASE
>needs _PAGE_COHERENT in order to work correctly, and in fact there is
>now a comment in there to that affect in 2.6.29. Backporting that change
>has made it work on 2.6.26. Both this patch, and the fix to head_32.S
>are needed for it to work correctly on older kernels.
>
>Chris

Hello Chris,

sorry for dummy, but if it possible, could you, please, send a correspondin=
g summary patch of backporting you've done for older kernels?
or just summary of that changes once again?

Many thanks

Sergej.=
