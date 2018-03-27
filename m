Return-Path: <linus971@gmail.com>
Received: from mail-it0-x231.google.com (mail-it0-x231.google.com
 [IPv6:2607:f8b0:4001:c0b::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409GxB0Rc1zF21g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 14:40:13 +1100 (AEDT)
Received: by mail-it0-x231.google.com with SMTP id m134-v6so8590815itb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 20:40:13 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <8a8ee344-fb19-3ed9-f7dc-db63f703e6d3@physik.fu-berlin.de>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-5-linux@dominikbrodowski.net>
 <20180318174014.GR30522@ZenIV.linux.org.uk>
 <CA+55aFwuZCpAZRpsTGiUmG065ZHHpj+03_NeWiy-OGkMGw7e3g@mail.gmail.com>
 <20180318181848.GU30522@ZenIV.linux.org.uk>
 <20180319042300.GW30522@ZenIV.linux.org.uk>
 <20180319092920.tbh2xwkruegshzqe@gmail.com>
 <20180319232342.GX30522@ZenIV.linux.org.uk>
 <20180322001532.GA18399@ZenIV.linux.org.uk>
 <20180326004017.GA2211@ZenIV.linux.org.uk>
 <20180326034750.GN30522@ZenIV.linux.org.uk>
 <CA+55aFw8VGnVgaWHVFP-LChMNaoANOwT18jJEWzSCRLFeRGcmA@mail.gmail.com>
 <428751c8-6920-096b-8694-a3f1b8990bdf@physik.fu-berlin.de>
 <CA+55aFwp-T-WFN95j7u5nn2BExxviJCx1-RgD3Mnu1AN_GYD3w@mail.gmail.com>
 <8a8ee344-fb19-3ed9-f7dc-db63f703e6d3@physik.fu-berlin.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 26 Mar 2018 17:40:10 -1000
Message-ID: <CA+55aFzHL1L_SEt_xqmJBfRRngTm4qbQGwxFvqSXw-MD2BiAOQ@mail.gmail.com>
Subject: Re: [RFC] new SYSCALL_DEFINE/COMPAT_SYSCALL_DEFINE wrappers
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Ingo Molnar <mingo@kernel.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 linux-arch <linux-arch@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
 James Hogan <jhogan@kernel.org>, linux-mips <linux-mips@linux-mips.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 linux-s390 <linux-s390@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Jiri Slaby <jslaby@suse.com>, "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 26, 2018 at 4:37 PM, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> What about a tarball with a minimal Debian x32 chroot? Then you can
> install interesting packages you would like to test yourself.

That probably works fine.

          Linus
