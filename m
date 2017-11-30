Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x244.google.com (mail-ua0-x244.google.com
 [IPv6:2607:f8b0:400c:c08::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ynb8K64WbzDrbJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 22:41:21 +1100 (AEDT)
Received: by mail-ua0-x244.google.com with SMTP id p33so5510915uag.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 03:41:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8703033cf68861aba6424b8c13694e9823f50f98.1511506950.git.christophe.leroy@c-s.fr>
References: <8703033cf68861aba6424b8c13694e9823f50f98.1511506950.git.christophe.leroy@c-s.fr>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 30 Nov 2017 22:41:18 +1100
Message-ID: <CAKTCnz=uhF1Bup0Zy3oiRDp70NpJrMPRSZZr6R3=s3BuRHnkMg@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/lib/code-patching: refactor
 patch_instruction()
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 24, 2017 at 6:31 PM, Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> patch_instruction() uses almost the same sequence as
> __patch_instruction()
>
> This patch refactor it so that patch_instruction() uses
> __patch_instruction() instead of duplicating code.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>
