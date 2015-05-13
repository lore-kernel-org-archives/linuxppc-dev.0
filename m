Return-Path: <john.stultz@linaro.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 10C981A001B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 09:40:38 +1000 (AEST)
Received: from mail-ig0-f175.google.com (mail-ig0-f175.google.com
 [209.85.213.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 91039140283
 for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2015 09:40:37 +1000 (AEST)
Received: by igbyr2 with SMTP id yr2so153400793igb.0
 for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2015 16:40:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <554708E0.1010600@linux.vnet.ibm.com>
References: <20150428084520.3314.62668.stgit@preeti.in.ibm.com>
 <554708E0.1010600@linux.vnet.ibm.com>
Date: Wed, 13 May 2015 16:40:35 -0700
Message-ID: <CALAqxLV6CpWKV_iTP3zNWn=gRGBOjOoejkBvDRFs+ezhPAQspg@mail.gmail.com>
Subject: Re: [PATCH] tick-broadcast: Fix the printing of broadcast masks
From: John Stultz <john.stultz@linaro.org>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, May 3, 2015 at 10:51 PM, Preeti U Murthy
<preeti@linux.vnet.ibm.com> wrote:
> Ping.
>
> Any comments on this patch ?
>

Got this queued for testing, and hopefully 4.2

thanks
-john
