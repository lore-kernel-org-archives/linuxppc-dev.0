Return-Path: <SRS0=hW9q=GM=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406SQm1JMHzF1sl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 00:37:29 +1100 (AEDT)
Date: Thu, 22 Mar 2018 09:37:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Will Deacon
 <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng
 <boqun.feng@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown
 <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Sathya Prakash
 <sathya.prakash@broadcom.com>, Chaitra P B <chaitra.basappa@broadcom.com>,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, Manish
 Chopra <manish.chopra@cavium.com>, Rahul Verma <rahul.verma@cavium.com>,
 Dept-GELinuxNICDev@cavium.com, QCA ath9k Development
 <ath9k-devel@qca.qualcomm.com>, Corentin Chary <corentin.chary@gmail.com>,
 Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>,
 Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Adaptec OEM Raid Solutions
 <aacraid@adaptec.com>, "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, Matthew Wilcox
 <matthew@wil.cx>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields"
 <bfields@fieldses.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Mark
 Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, "Darrick J.
 Wong" <darrick.wong@oracle.com>, linux-xfs@vger.kernel.org, Paul Moore
 <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, Timur Tabi
 <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li
 <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Jiri Kosina
 <trivial@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter
 Anvin" <hpa@zytor.com>, x86@kernel.org, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Kalle Valo <kvalo@codeaurora.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
 linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, acpi4asus-user@lists.sourceforge.net,
 platform-driver-x86@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
 linux-audit@redhat.com, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [trivial PATCH V2] treewide: Align function definition
 open/close braces
Message-ID: <20180322093720.2254cfbb@gandalf.local.home>
In-Reply-To: <5ccbbf083e26bddfb4ea4f819ed62347ce266f39.1521669820.git.joe@perches.com>
References: <5ccbbf083e26bddfb4ea4f819ed62347ce266f39.1521669820.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 21 Mar 2018 15:09:32 -0700
Joe Perches <joe@perches.com> wrote:

> diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
> index ad1d6164e946..50f44b7b2b32 100644
> --- a/kernel/trace/trace_printk.c
> +++ b/kernel/trace/trace_printk.c
> @@ -196,7 +196,7 @@ struct notifier_block module_trace_bprintk_format_nb = {
>  };
>  
>  int __trace_bprintk(unsigned long ip, const char *fmt, ...)
> - {
> +{
>  	int ret;
>  	va_list ap;
>  
> @@ -214,7 +214,7 @@ int __trace_bprintk(unsigned long ip, const char *fmt, ...)
>  EXPORT_SYMBOL_GPL(__trace_bprintk);
>  
>  int __ftrace_vbprintk(unsigned long ip, const char *fmt, va_list ap)
> - {
> +{
>  	if (unlikely(!fmt))
>  		return 0;
>  

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
