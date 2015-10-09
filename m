Return-Path: <cmetcalf@ezchip.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0067.outbound.protection.outlook.com [157.55.234.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3DCF11A0541
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2015 01:24:55 +1100 (AEDT)
Subject: Re: [PATCH] powerpc: Quick fix upstream main line build error on
 PowerPC
To: Dongsheng Wang <dongsheng.wang@freescale.com>, <benh@kernel.crashing.org>
References: <1444359309-40375-1-git-send-email-dongsheng.wang@freescale.com>
CC: <scottwood@freescale.com>, <leoli@freescale.com>, <paulus@samba.org>,
 <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>
From: Chris Metcalf <cmetcalf@ezchip.com>
Message-ID: <5617CE21.9030604@ezchip.com>
Date: Fri, 9 Oct 2015 10:24:33 -0400
MIME-Version: 1.0
In-Reply-To: <1444359309-40375-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/08/2015 10:55 PM, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>
> This issue caused on 'commit 990486c8af04 ("strscpy: zero any trailing
> garbage bytes in the destination")'.
>
> zero_bytemask is not implemented on PowerPC. So copy the zero_bytemask
> of BIG_ENDIAN implementation from include/asm-generic/word-at-a-time.h
> to arch/powerpc/include/asm/word-at-a-time.h.

Thanks; a fix is already queued for Linus.

-- 
Chris Metcalf, EZChip Semiconductor
http://www.ezchip.com
