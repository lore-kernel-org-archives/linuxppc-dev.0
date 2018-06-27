Return-Path: <arndbergmann@gmail.com>
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com
 [IPv6:2a00:1450:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Fzqd3jbdzF153
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2018 20:37:00 +1000 (AEST)
Received: by mail-lj1-x244.google.com with SMTP id x3-v6so1208180ljj.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2018 03:37:00 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <87y3f06e9a.fsf@concordia.ellerman.id.au>
References: <20180619140229.3615110-1-arnd@arndb.de>
 <87y3f06e9a.fsf@concordia.ellerman.id.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 27 Jun 2018 12:36:56 +0200
Message-ID: <CAK8P3a2HwOe2D4LXgFsfhFXpeUBpHZiB5PCk0nkAwqX3NKCmFA@mail.gmail.com>
Subject: Re: [PATCH 1/3] [v2] powerpc: mac: fix rtc read/write functions
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Ungerer <gerg@linux-m68k.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Meelis Roos <mroos@linux.ee>, Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 27, 2018 at 6:32 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> So I think I can take this patch in isolation via the powerpc tree as a
> fix for 4.18.
>
> I'll leave the other two alone.
>

Yes, that is what I had intended with this series but should have made
clearer. The two m68k patches are 4.19 material.

      Arnd
