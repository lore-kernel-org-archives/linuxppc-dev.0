Return-Path: <bsingharora@gmail.com>
Received: from mail-vk0-x230.google.com (mail-vk0-x230.google.com
 [IPv6:2607:f8b0:400c:c05::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yzhsP70yszDsNH
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Dec 2017 09:33:29 +1100 (AEDT)
Received: by mail-vk0-x230.google.com with SMTP id s197so7582611vke.11
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 14:33:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOS_Y6SsUJYjrwc5GM-MpLWudWNVgkESKi4evNPs_JppEdQ8TQ@mail.gmail.com>
References: <CAOS_Y6SsUJYjrwc5GM-MpLWudWNVgkESKi4evNPs_JppEdQ8TQ@mail.gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Sun, 17 Dec 2017 09:33:27 +1100
Message-ID: <CAKTCnznn8fyziWvZf+iuVq6zDV4hebrREwuKV+6ZTjpTz0D6oA@mail.gmail.com>
Subject: Re: powerpc64 kernel panic if you disable
 CONFIG_PPC_TRANSACTIONAL_MEM?
To: Rob Landley <rob@landley.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Dec 17, 2017 at 8:34 AM, Rob Landley <rob@landley.net> wrote:
> I just added a ppc64 target to https://github.com/landley/mkroot which
> means I built 4.14 with the attached miniconfig and ran it with the
> attached qemu command line, and it works fine as is but if you remove
> the transactional mem line from the config the kernel panics instead
> of launching a shell prompt:
>
> init[1]: unhandled signal 4 at 0000000010001a04 nip 0000000010001a04
> lr 000000001002ebe8 code 1
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004
>

what does the instruction at 10001a04 look like?

Balbir Singh.
