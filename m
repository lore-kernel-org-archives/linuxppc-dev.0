Return-Path: <andy.shevchenko@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0gPb4crBzDrnb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 23:31:15 +1100 (AEDT)
Received: by mail-qk0-x243.google.com with SMTP id h19so18070787qkj.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 04:31:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1513556924.31581.51.camel@perches.com>
References: <1513556924.31581.51.camel@perches.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 18 Dec 2017 14:31:12 +0200
Message-ID: <CAHp75Vfw=AQHkiC7WhUkuytxG_reO8rmEfpA7z-2yAekFQ4AYQ@mail.gmail.com>
Subject: Re: [trivial PATCH] treewide: Align function definition open/close
 braces
To: Joe Perches <joe@perches.com>
Cc: Jiri Kosina <trivial@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 MPT-FusionLinux.pdl@broadcom.com,
 linux-scsi <linux-scsi@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
 "open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>,
 acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 linux-rtc@vger.kernel.org,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>, ocfs2-devel@oss.oracle.com,
 linux-xfs@vger.kernel.org, linux-audit@redhat.com,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 18, 2017 at 2:28 AM, Joe Perches <joe@perches.com> wrote:
> Some functions definitions have either the initial open brace and/or
> the closing brace outside of column 1.
>
> Move those braces to column 1.
>
> This allows various function analyzers like gnu complexity to work
> properly for these modified functions.
>
> Miscellanea:
>
> o Remove extra trailing ; and blank line from xfs_agf_verify
>
> Signed-off-by: Joe Perches <joe@perches.com>

>  drivers/platform/x86/eeepc-laptop.c                  |  2 +-

> diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
> index 5a681962899c..4c38904a8a32 100644
> --- a/drivers/platform/x86/eeepc-laptop.c
> +++ b/drivers/platform/x86/eeepc-laptop.c
> @@ -492,7 +492,7 @@ static void eeepc_platform_exit(struct eeepc_laptop *eeepc)
>   * potentially bad time, such as a timer interrupt.
>   */
>  static void tpd_led_update(struct work_struct *work)
> - {
> +{
>         struct eeepc_laptop *eeepc;
>
>         eeepc = container_of(work, struct eeepc_laptop, tpd_led_work);
> diff --git a/drivers/rtc/rtc-ab-b5ze-s3.c b/drivers/rtc/rtc-ab-b5ze-s3.c
> index a319bf1e49de..ef5c16dfabfa 100644

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

for PDx86 changes.


-- 
With Best Regards,
Andy Shevchenko
