Return-Path: <pku.leo@gmail.com>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F16A41007D4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2012 18:22:28 +1100 (EST)
Received: by eaan11 with SMTP id n11so223048eaa.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2012 23:22:22 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <1329284944-17943-1-git-send-email-qiang.liu@freescale.com>
References: <1329284944-17943-1-git-send-email-qiang.liu@freescale.com>
Date: Wed, 15 Feb 2012 15:22:22 +0800
Message-ID: <CADRPPNQ8LUr13J4k8fsBYSSxXVuxFdEvKyL4abxZpY32Meh=uQ@mail.gmail.com>
Subject: Re: [PATCH V2 RESEND] fsl-sata: I/O load balancing
From: Li Yang <leoli@freescale.com>
To: Qiang Liu <qiang.liu@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 15, 2012 at 1:49 PM, Qiang Liu <qiang.liu@freescale.com> wrote:

Hi Liu Qiang,

The patch is fine except for the title and comment.  It's too vague to
say I/O load balancing.  You need explicit description like "add
interrupt coalescing support" as title.

> Reduce interrupt signals through reset Interrupt Coalescing Control Reg.
> Provide dynamic method to adjust interrupt signals and timer ticks by sysfs.
> It is a tradeoff for different applications.

How about:

Adds support for interrupt coalescing feature to reduce interrupt
events.  Provides mechanism of adjusting coalescing count and timeout
tick by sysfs on runtime, so that tradeoff of latency and CPU load can
be made depending on applications.

- Leo
