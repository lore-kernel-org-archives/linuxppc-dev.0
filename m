Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x22a.google.com (mail-ua0-x22a.google.com
 [IPv6:2607:f8b0:400c:c08::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4022Cd1j7gzF0sx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 19:42:36 +1100 (AEDT)
Received: by mail-ua0-x22a.google.com with SMTP id i21so597278uak.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 01:42:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180314162325.1b2dea8d@canb.auug.org.au>
References: <20180314162325.1b2dea8d@canb.auug.org.au>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 15 Mar 2018 19:42:33 +1100
Message-ID: <CAKTCnz=4Fun3C5RMp1x3N+rmaU8-Yy3WOVZFyrc_5MNRKaYskg@mail.gmail.com>
Subject: Re: more warnings
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 14, 2018 at 4:23 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> I also get these from a powerpc allyesconfig build of linux-next:
>
> WARNING: vmlinux.o(.text+0x7c81c): Section mismatch in reference from the function .stop_machine_change_mapping() to the function .meminit.text:.create_physical_mapping()
> The function .stop_machine_change_mapping() references
> the function __meminit .create_physical_mapping().
> This is often because .stop_machine_change_mapping lacks a __meminit
> annotation or the annotation of .create_physical_mapping is wrong.
>
> WARNING: vmlinux.o(.text+0x7c828): Section mismatch in reference from the function .stop_machine_change_mapping() to the function .meminit.text:.create_physical_mapping()
> The function .stop_machine_change_mapping() references
> the function __meminit .create_physical_mapping().
> This is often because .stop_machine_change_mapping lacks a __meminit
> annotation or the annotation of .create_physical_mapping is wrong.
>


Hi, Stephen

Patches have been sent to fix this - http://patchwork.ozlabs.org/patch/883991/

Balbir Singh
