Return-Path: <arndbergmann@gmail.com>
Received: from mail-ot0-x242.google.com (mail-ot0-x242.google.com
 [IPv6:2607:f8b0:4003:c0f::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whs2Q0v98zDqNB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 22:49:18 +1000 (AEST)
Received: by mail-ot0-x242.google.com with SMTP id t31so1971397ota.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Jun 2017 05:49:18 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20170603141515.9529-2-asarai@suse.de>
References: <20170603141515.9529-1-asarai@suse.de>
 <20170603141515.9529-2-asarai@suse.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Jun 2017 14:49:15 +0200
Message-ID: <CAK8P3a2Y2U58dfAxRYPKQL2-o8ufpkvxxF07c_LCr5DOuQ4=vw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] tty: add compat_ioctl callbacks
To: Aleksa Sarai <asarai@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-alpha@vger.kernel.org,
 "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-sh@vger.kernel.org,
 sparclinux <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org,
 linux-arch <linux-arch@vger.kernel.org>,
 Christian Brauner <christian.brauner@ubuntu.com>,
 Valentin Rothberg <vrothberg@suse.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 3, 2017 at 4:15 PM, Aleksa Sarai <asarai@suse.de> wrote:
> In order to avoid future diversions between fs/compat_ioctl.c and
> drivers/tty/pty.c, define .compat_ioctl callbacks for the relevant
> tty_operations structs. Since both pty_unix98_ioctl() and
> pty_bsd_ioctl() are compatible between 32-bit and 64-bit userspace no
> special translation is required.
>
> Signed-off-by: Aleksa Sarai <asarai@suse.de>

Looks good,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
