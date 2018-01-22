Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxr31SljzF0XB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:27 +1100 (AEDT)
In-Reply-To: <20180104153525.A03F56E5E6@localhost.localdomain>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
 Balbir Singh <bsingharora@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc: restore alphabetic order in Kconfig
Message-Id: <3zPxqz4jTyz9sNr@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:22 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-01-04 at 15:35:25 UTC, Christophe Leroy wrote:
> This patch restores the alphabetic order which was broken by
> commit 1e0fc9d1eb2b0 ("powerpc/Kconfig: Enable STRICT_KERNEL_RWX
> for some configs")
> 
> Fixes: 1e0fc9d1eb2b0 ("powerpc/Kconfig: Enable STRICT_KERNEL_RWX for some configs")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4ec591e51a4b0aedb6c7f1a8cd722a

cheers
