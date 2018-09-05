Return-Path: <paul@paul-moore.com>
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4251ym183szF2R6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 21:42:20 +1000 (AEST)
Received: by mail-lj1-f193.google.com with SMTP id p10-v6so5955869ljg.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Sep 2018 04:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <1536012923-16275-1-git-send-email-henrik@austad.us>
In-Reply-To: <1536012923-16275-1-git-send-email-henrik@austad.us>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 5 Sep 2018 07:42:04 -0400
Message-ID: <CAHC9VhR7Zana3xTEj2jUGXb+hBzyh69g0rBg_p_4tkbjtCUdpw@mail.gmail.com>
Subject: Re: [PATCH] [RFC v2] Drop all 00-INDEX files from Documentation/
To: henrik@austad.us
Cc: linux-doc@vger.kernel.org, corbet@lwn.net, bhelgaas@google.com,
 paulmck@linux.vnet.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, axboe@kernel.dk,
 robh+dt@kernel.org, mark.rutland@arm.com, b.zolnierkie@samsung.com,
 linus.walleij@linaro.org, davem@davemloft.net, isdn@linux-pingi.de,
 yamada.masahiro@socionext.com, michal.lkml@markovi.net, peterz@infradead.org,
 mingo@redhat.com, will.deacon@arm.com, ralf@linux-mips.org,
 paul.burton@mips.com, jhogan@kernel.org, jejb@parisc-linux.org, deller@gmx.de,
 rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, gregkh@linuxfoundation.org,
 jslaby@suse.com, broonie@kernel.org, tglx@linutronix.de, pbonzini@redhat.com,
 rkrcmar@redhat.com, zbr@ioremap.net, hpa@zytor.com, x86@kernel.org,
 akpm@linux-foundation.org, raven@themaw.net, jacek.anaszewski@gmail.com,
 rppt@linux.vnet.ibm.com, jjj@gmx.de, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org, netdev@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-mips@linux-mips.org,
 linux-security-module@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-spi@vger.kernel.org, kvm@vger.kernel.org,
 haustad@cisco.com
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 3, 2018 at 6:15 PM Henrik Austad <henrik@austad.us> wrote:
> This is a respin with a wider audience (all that get_maintainer returned)
> and I know this spams a *lot* of people. Not sure what would be the correct
> way, so my apologies for ruining your inbox.
>
> The 00-INDEX files are supposed to give a summary of all files present
> in a directory, but these files are horribly out of date and their
> usefulness is brought into question. Often a simple "ls" would reveal
> the same information as the filenames are generally quite descriptive as
> a short introduction to what the file covers (it should not surprise
> anyone what Documentation/sched/sched-design-CFS.txt covers)
>
> A few years back it was mentioned that these files were no longer really
> needed, and they have since then grown further out of date, so perhaps
> it is time to just throw them out.
>
> A short status yields the following _outdated_ 00-INDEX files, first
> counter is files listed in 00-INDEX but missing in the directory, last
> is files present but not listed in 00-INDEX.
>
> List of outdated 00-INDEX:
> Documentation: (4/10)
> Documentation/sysctl: (0/1)
> Documentation/timers: (1/0)
> Documentation/blockdev: (3/1)
> Documentation/w1/slaves: (0/1)
> Documentation/locking: (0/1)
> Documentation/devicetree: (0/5)
> Documentation/power: (1/1)
> Documentation/powerpc: (0/5)
> Documentation/arm: (1/0)
> Documentation/x86: (0/9)
> Documentation/x86/x86_64: (1/1)
> Documentation/scsi: (4/4)
> Documentation/filesystems: (2/9)
> Documentation/filesystems/nfs: (0/2)
> Documentation/cgroup-v1: (0/2)
> Documentation/kbuild: (0/4)
> Documentation/spi: (1/0)
> Documentation/virtual/kvm: (1/0)
> Documentation/scheduler: (0/2)
> Documentation/fb: (0/1)
> Documentation/block: (0/1)
> Documentation/networking: (6/37)
> Documentation/vm: (1/3)
>
> Then there are 364 subdirectories in Documentation/ with several files that
> are missing 00-INDEX alltogether (and another 120 with a single file and no
> 00-INDEX).
>
> I don't really have an opinion to whether or not we /should/ have 00-INDEX,
> but the above 00-INDEX should either be removed or be kept up to date. If
> we should keep the files, I can try to keep them updated, but I rather not
> if we just want to delete them anyway.
>
> As a starting point, remove all index-files and references to 00-INDEX and
> see where the discussion is going.
>
> Again, sorry for the insanely wide distribution.
>
> Signed-off-by: Henrik Austad <henrik@austad.us>
...
> Signed-off-by: Henrik Austad <haustad@cisco.com>
> ---
>  Documentation/00-INDEX                  | 428 --------------------------------
...

Looks reasonable to me, you can add my ACK for the NetLabel bits.

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
