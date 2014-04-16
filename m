Return-Path: <computersforpeace@gmail.com>
Received: from mail-ve0-f173.google.com (mail-ve0-f173.google.com
 [209.85.128.173])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 38E0E14009F
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2014 16:53:23 +1000 (EST)
Received: by mail-ve0-f173.google.com with SMTP id oy12so10039414veb.4
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2014 23:53:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1395478518-22308-1-git-send-email-B48286@freescale.com>
References: <1395478518-22308-1-git-send-email-B48286@freescale.com>
Date: Tue, 15 Apr 2014 23:53:20 -0700
Message-ID: <CAN8TOE8JvG4Xmy20jEjg6rpEGk-4ATibrtr6NdDb2V1=F9XYGQ@mail.gmail.com>
Subject: Re: [v3] mtd: m25p80: Modify the name of mtd_info
From: Brian Norris <computersforpeace@gmail.com>
To: Hou Zhiqiang <B48286@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "Mingkai.Hu@freescale.com" <mingkai.hu@freescale.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 22, 2014 at 1:55 AM, Hou Zhiqiang <B48286@freescale.com> wrote:
> v3:
>         Fix a bug, matching unsigned long long with "%llx".
> v2:
>         1. Fix some code style issue.
>         2. Cast physical address to unsigned long long.

I missed v2 and v3 and commented on v1 instead, sorry. Same comments
apply here though.

Also, can you please include PATCH in the subject? (e.g., [PATCH v3])
See Documentation/SubmittingPatches, item 11.

Thanks,
Brian
