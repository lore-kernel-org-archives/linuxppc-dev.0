Return-Path: <pku.leo@gmail.com>
Received: from mail-vk0-x244.google.com (mail-vk0-x244.google.com
 [IPv6:2607:f8b0:400c:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vKDPW0s9BzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 10:12:31 +1100 (AEDT)
Received: by mail-vk0-x244.google.com with SMTP id 23so1483499vkc.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Feb 2017 15:12:30 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <d25ee7a13b60dcd005c59169feacb18fb69a06c1.1486456900.git.christophe.leroy@c-s.fr>
References: <cover.1486456900.git.christophe.leroy@c-s.fr>
 <d25ee7a13b60dcd005c59169feacb18fb69a06c1.1486456900.git.christophe.leroy@c-s.fr>
From: Li Yang <leoli@freescale.com>
Date: Thu, 9 Feb 2017 17:12:28 -0600
Message-ID: <CADRPPNQaU5an0ituEB62GddFK6_mR4Y7n=yOOypUfSUdMsGsLg@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: ethernet: ucc_geth: fix MEM_PART_MURAM mode
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Qiang Zhao <qiang.zhao@nxp.com>, Scott Wood <oss@buserror.net>,
 "David S. Miller" <davem@davemloft.net>, lkml <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Netdev <netdev@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 7, 2017 at 3:05 AM, Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> Since commit 5093bb965a163 ("powerpc/QE: switch to the cpm_muram
> implementation"), muram area is not part of immrbar mapping anymore
> so immrbar_virt_to_phys() is not usable anymore.
>
> Fixes: 5093bb965a163 ("powerpc/QE: switch to the cpm_muram implementation)
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Acked-by: Li Yang <pku.leo@gmail.com>

Regards,
Leo
