Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-it0-x22b.google.com (mail-it0-x22b.google.com
 [IPv6:2607:f8b0:4001:c0b::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdxBx0830zDqJV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 04:46:32 +1000 (AEST)
Received: by mail-it0-x22b.google.com with SMTP id m62so1510192itc.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Jun 2017 11:46:32 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20170601173803.8698-1-asarai@suse.de>
References: <20170601173803.8698-1-asarai@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 1 Jun 2017 20:46:29 +0200
Message-ID: <CAMuHMdXkaWg70OidDi0_xALbzwZ+o0eEVEzT5U_6HdewBs4WwA@mail.gmail.com>
Subject: Re: [PATCH] tty: add TIOCGPTPEER ioctl
To: Aleksa Sarai <asarai@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
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

Hi Aleksa,

On Thu, Jun 1, 2017 at 7:38 PM, Aleksa Sarai <asarai@suse.de> wrote:
> --- a/arch/alpha/include/uapi/asm/ioctls.h
> +++ b/arch/alpha/include/uapi/asm/ioctls.h
> @@ -94,6 +94,7 @@
>  #define TIOCSRS485     _IOWR('T', 0x2F, struct serial_rs485)
>  #define TIOCGPTN       _IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
>  #define TIOCSPTLCK     _IOW('T',0x31, int)  /* Lock/unlock Pty */
> +#define TIOCGPTPEER    _IOR('T', 0x41, int) /* Safely open the slave */

Shouldn't the list of definitions be kept sorted, by hex number?
(everywhere)

>  #define TIOCGDEV       _IOR('T',0x32, unsigned int) /* Get primary device node of /dev/console */
>  #define TIOCSIG                _IOW('T',0x36, int)  /* Generate signal on Pty slave */
>  #define TIOCVHANGUP    0x5437

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
