Return-Path: <arndbergmann@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6DJB3JKYzDqb4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 17:30:18 +1000 (AEST)
Received: by mail-oi0-x244.google.com with SMTP id f134so14644706oig.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 00:30:18 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20170711001207.GA11642@glebfm.cloud.tilaa.com>
References: <20170711001207.GA11642@glebfm.cloud.tilaa.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 11 Jul 2017 09:30:14 +0200
Message-ID: <CAK8P3a1uJc0dNoELw1KWKnc9Lme3HDxR2Coj0-snuCmO4n-81A@mail.gmail.com>
Subject: Re: [PATCH] tty: Fix TIOCGPTPEER ioctl definition
To: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Cc: Aleksa Sarai <asarai@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, Christian Brauner <christian.brauner@ubuntu.com>,
 Valentin Rothberg <vrothberg@suse.com>, "Dmitry V. Levin" <ldv@altlinux.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-alpha@vger.kernel.org,
 "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-sh@vger.kernel.org,
 sparclinux <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org,
 linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 11, 2017 at 2:12 AM, Gleb Fotengauer-Malinovskiy
<glebfm@altlinux.org> wrote:
> This ioctl does nothing to justify an _IOC_READ or _IOC_WRITE flag
> because it doesn't copy anything from/to userspace to access the
> argument.
>
> Fixes: 54ebbfb1 ("tty: add TIOCGPTPEER ioctl")
> Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
