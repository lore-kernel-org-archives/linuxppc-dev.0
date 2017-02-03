Return-Path: <linus971@gmail.com>
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com
 [IPv6:2607:f8b0:4003:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vFMm421RwzDqBX
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Feb 2017 03:30:12 +1100 (AEDT)
Received: by mail-oi0-x242.google.com with SMTP id w144so1767026oiw.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Feb 2017 08:30:12 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1486115647-27680-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1486115647-27680-1-git-send-email-ard.biesheuvel@linaro.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 Feb 2017 08:30:09 -0800
Message-ID: <CA+55aFz8faoGYBqkHuGPy4yp+SU5brCbkOCdZNTgfdDzkN8hOw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] modversions: redefine kcrctab entries as 32-bit
 values
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Jessica Yu <jeyu@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>,
 Michal Marek <mmarek@suse.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>,
 Al Viro <viro@zeniv.linux.org.uk>,
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

On Fri, Feb 3, 2017 at 1:54 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> This v4 is a followup to [0] 'modversions: redefine kcrctab entries as
> relative CRC pointers' [...]

ok, I have this in a local branch now, assuming it passes my
(admittedly fairly superficial) testing I'll merge it so that we can
put this whole sorry saga behind us.

Thanks,

             Linus
