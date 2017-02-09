Return-Path: <pku.leo@gmail.com>
Received: from mail-vk0-x241.google.com (mail-vk0-x241.google.com
 [IPv6:2607:f8b0:400c:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vKDWk1mZSzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 10:17:54 +1100 (AEDT)
Received: by mail-vk0-x241.google.com with SMTP id t8so1498525vke.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Feb 2017 15:17:54 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <804a373374f8ea17d971c4b087fcbe24c0edced7.1486456900.git.christophe.leroy@c-s.fr>
References: <cover.1486456900.git.christophe.leroy@c-s.fr>
 <804a373374f8ea17d971c4b087fcbe24c0edced7.1486456900.git.christophe.leroy@c-s.fr>
From: Li Yang <leoli@freescale.com>
Date: Thu, 9 Feb 2017 17:17:51 -0600
Message-ID: <CADRPPNTTvfcMNkXa-ffNv_-WB=bTP-P7FOfui7nEGV=umw8i=g@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc/fsl/qe: get rid of immrbar_virt_to_phys()
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
> immrbar_virt_to_phys() is not used anymore
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Acked-by: Li Yang <pku.leo@gmail.com>

Regards,
Leo
