Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPsxD5QfjzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 23:37:36 +1100 (AEDT)
Received: by mail-oi0-x244.google.com with SMTP id u143so3684031oif.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 04:37:36 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <CAJZ5v0gNcGtnXpE1n6LSq7ey+UDKx+oQfmTg0_PgFwzB0Dd_5A@mail.gmail.com>
References: <cover.1487314666.git.joe@perches.com>
 <CAJZ5v0gNcGtnXpE1n6LSq7ey+UDKx+oQfmTg0_PgFwzB0Dd_5A@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Feb 2017 13:37:33 +0100
Message-ID: <CAMuHMdWsG0DboaLqXag53Vejwvc5PPY2k2gy9PSdHWbNEx6nRQ@mail.gmail.com>
Subject: Re: [PATCH 00/35] treewide trivial patches converting pr_warning to
 pr_warn
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Joe Perches <joe@perches.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Karol Herbst <karolherbst@gmail.com>,
 Pekka Paalanen <ppaalanen@gmail.com>, Richard Weinberger <richard@nod.at>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, tboot-devel@lists.sourceforge.net,
 nouveau@lists.freedesktop.org, oprofile-list@lists.sf.net,
 sfi-devel@simplefirmware.org, xen-devel@lists.xenproject.org,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Lars Ellenberg <drbd-dev@lists.linbit.com>,
 virtualization@lists.linux-foundation.org,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 gigaset307x-common@lists.sourceforge.net,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 MTD Maling List <linux-mtd@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 acpi4asus-user@lists.sourceforge.net,
 platform-driver-x86@vger.kernel.org,
 "open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
 "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, alpha <linux-alpha@vger.kernel.org>,
 "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Rafael,

On Fri, Feb 17, 2017 at 1:27 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Feb 17, 2017 at 8:11 AM, Joe Perches <joe@perches.com> wrote:
>> There are ~4300 uses of pr_warn and ~250 uses of the older
>> pr_warning in the kernel source tree.
>>
>> Make the use of pr_warn consistent across all kernel files.
>>
>> This excludes all files in tools/ as there is a separate
>> define pr_warning for that directory tree and pr_warn is
>> not used in tools/.
>>
>> Done with 'sed s/\bpr_warning\b/pr_warn/' and some emacsing.
>
> Sorry about asking if that has been asked already.
>
> Wouldn't it be slightly less intrusive to simply redefined
> pr_warning() as a synonym for pr_warn()?

That's already the case.

This series cleans up the cruft, so we can catch all users with
"git grep -w pr_warn".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
