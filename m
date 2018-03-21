Return-Path: <rjwysocki@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4064RT2jnrzF1wt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 09:36:52 +1100 (AEDT)
Received: by mail-oi0-x241.google.com with SMTP id c3-v6so5730864oib.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 15:36:52 -0700 (PDT)
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <5ccbbf083e26bddfb4ea4f819ed62347ce266f39.1521669820.git.joe@perches.com>
References: <5ccbbf083e26bddfb4ea4f819ed62347ce266f39.1521669820.git.joe@perches.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 Mar 2018 23:36:49 +0100
Message-ID: <CAJZ5v0hYKnPVxbbBY-SDjxBY2Pj12WD3nD9zE--+eZpBzZr-NA@mail.gmail.com>
Subject: Re: [trivial PATCH V2] treewide: Align function definition open/close
 braces
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Will Deacon <will.deacon@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>,
 Sathya Prakash <sathya.prakash@broadcom.com>,
 Chaitra P B <chaitra.basappa@broadcom.com>,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
 Manish Chopra <manish.chopra@cavium.com>, Rahul Verma <rahul.verma@cavium.com>,
 Dept-GELinuxNICDev@cavium.com,
 QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
 Corentin Chary <corentin.chary@gmail.com>,
 Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Adaptec OEM Raid Solutions <aacraid@adaptec.com>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Matthew Wilcox <matthew@wil.cx>,
 Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, "Darrick J. Wong" <darrick.wong@oracle.com>,
 linux-xfs@vger.kernel.org,
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Jiri Kosina <trivial@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
 "the arch/x86 maintainers" <x86@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Kalle Valo <kvalo@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org,
 dri-devel <dri-devel@lists.freedesktop.org>, linux-media@vger.kernel.org,
 MPT-FusionLinux.pdl@broadcom.com,
 "open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
 netdev <netdev@vger.kernel.org>,
 "open list:NETWORKING DRIVERS (WIRELESS)" <linux-wireless@vger.kernel.org>,
 acpi4asus-user@lists.sourceforge.net,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 linux-rtc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
 linux-audit@redhat.com,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 21, 2018 at 11:09 PM, Joe Perches <joe@perches.com> wrote:
> Some functions definitions have either the initial open brace and/or
> the closing brace outside of column 1.
>
> Move those braces to column 1.
>
> This allows various function analyzers like gnu complexity to work
> properly for these modified functions.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Acked-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
> Acked-by: Takashi Iwai <tiwai@suse.de>
> Acked-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> ---
>
> git diff -w still shows no difference.
>
> This patch was sent but December and not applied.
>
> As the trivial maintainer seems not active, it'd be nice if
> Andrew Morton picks this up.
>
> V2: Remove fs/xfs/libxfs/xfs_alloc.c as it's updated and remerge the rest
>
>  arch/x86/include/asm/atomic64_32.h                   |  2 +-
>  drivers/acpi/custom_method.c                         |  2 +-
>  drivers/acpi/fan.c                                   |  2 +-

For the ACPI changes:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
