Return-Path: <joel.stan@gmail.com>
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DsV86MR0zDrWW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 15:48:16 +1000 (AEST)
Received: by mail-qk1-x741.google.com with SMTP id g13-v6so371202qki.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 22:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <82bbb913ffd8bdc040a012152ee968cd0c6ccf4e.1537218487.git.christophe.leroy@c-s.fr>
In-Reply-To: <82bbb913ffd8bdc040a012152ee968cd0c6ccf4e.1537218487.git.christophe.leroy@c-s.fr>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 18 Sep 2018 15:18:02 +0930
Message-ID: <CACPK8XdeT_FF_PHjqOh3e18jDhsFOdECVDd+Z2vWt8pSk5damA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/makefile: remove check on obsolete GCC versions
To: christophe.leroy@c-s.fr
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hey Christophe,

On Tue, 18 Sep 2018 at 15:13, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>
> Since commit cafa0010cd51 ("Raise the minimum required gcc version
> to 4.6"), it is not possible to build kernel with GCC lower than 4.6
>
> This patch removes checkbin tests addressing older versions of GCC.

This is the same as Nick's patch:

 https://patchwork.ozlabs.org/patch/969624/

Cheers,

Joel
