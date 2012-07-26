Return-Path: <pku.leo@gmail.com>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 54EDC2C007D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 00:02:03 +1000 (EST)
Received: by obbeh20 with SMTP id eh20so2572199obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2012 07:02:00 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <1342788159-27529-1-git-send-email-chenhui.zhao@freescale.com>
References: <1342788159-27529-1-git-send-email-chenhui.zhao@freescale.com>
Date: Thu, 26 Jul 2012 22:02:00 +0800
Message-ID: <CADRPPNSw5Yn7EgHt5fm2vYr+zxC4T+JbsvT812u2JPKELNcA6g@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] power management patch set
From: Li Yang <leoli@freescale.com>
To: Zhao Chenhui <chenhui.zhao@freescale.com>, scottwood@freescale.com,
 galak@kernel.crashing.org
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 20, 2012 at 8:42 PM, Zhao Chenhui
<chenhui.zhao@freescale.com> wrote:
> Changes for v8:
> * Separated the cpu hotplug patch into three patches, as follows
>   [PATCH v8 1/7] powerpc/smp: use a struct epapr_spin_table to replace macros
>   [PATCH v8 2/7] powerpc/smp: add generic_set_cpu_up() to set cpu_state as CPU_UP_PREPARE
>   [PATCH v8 4/7] powerpc/85xx: add HOTPLUG_CPU support
>
> * Replaced magic numbers with macros in "[PATCH 5/7] powerpc/85xx: add sleep and deep sleep support"
>
> * no change to the rest of the patch set

Hi Kumar,

How about picking about this series for 3.6?  The review seems to
settle down for this revision.


Hi Scott,

Thanks for the review comments provided.  We'd like to get the ACK
from you for the series if you can.

Regards,
Leo
