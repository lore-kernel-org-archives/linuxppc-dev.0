Return-Path: <bsingharora@gmail.com>
Received: from mail-vk0-x242.google.com (mail-vk0-x242.google.com
 [IPv6:2607:f8b0:400c:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFbW22zWqzF0QT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 00:20:41 +1100 (AEDT)
Received: by mail-vk0-x242.google.com with SMTP id m15so7261135vkf.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jan 2018 05:20:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180104153525.A03F56E5E6@localhost.localdomain>
References: <20180104153525.A03F56E5E6@localhost.localdomain>
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 9 Jan 2018 00:20:38 +1100
Message-ID: <CAKTCnzkuZfjYUAzFUTwoJQawoT-Tta9TNRYXWcsHkuM8bBaxmw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: restore alphabetic order in Kconfig
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 5, 2018 at 2:35 AM, Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> This patch restores the alphabetic order which was broken by
> commit 1e0fc9d1eb2b0 ("powerpc/Kconfig: Enable STRICT_KERNEL_RWX
> for some configs")
>
> Fixes: 1e0fc9d1eb2b0 ("powerpc/Kconfig: Enable STRICT_KERNEL_RWX for some configs")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
Acked-by: Balbir Singh <bsingharora@gmail.com>
