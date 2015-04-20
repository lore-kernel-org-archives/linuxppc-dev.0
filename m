Return-Path: <sergei.shtylyov@cogentembedded.com>
Received: from mail-lb0-f171.google.com (mail-lb0-f171.google.com
 [209.85.217.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC0BB1A1AE1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 19:49:24 +1000 (AEST)
Received: by lbbuc2 with SMTP id uc2so126183190lbb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 02:49:20 -0700 (PDT)
Message-ID: <5534CB9D.1080600@cogentembedded.com>
Date: Mon, 20 Apr 2015 12:49:17 +0300
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Baolin Wang <baolin.wang@linaro.org>, tglx@linutronix.de
Subject: Re: [PATCH 01/11] linux/time64.h:Introduce the 'struct itimerspec64'
 for 64bit
References: <1429509459-17068-1-git-send-email-baolin.wang@linaro.org>
 <1429509459-17068-2-git-send-email-baolin.wang@linaro.org>
In-Reply-To: <1429509459-17068-2-git-send-email-baolin.wang@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: pang.xunlei@linaro.org, peterz@infradead.org, heiko.carstens@de.ibm.com,
 paulus@samba.org, cl@linux.com, heenasirwani@gmail.com,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, y2038@lists.linaro.org,
 rafael.j.wysocki@intel.com, ahh@google.com, fweisbec@gmail.com, pjt@google.com,
 riel@redhat.com, arnd@arndb.de, richardcochran@gmail.com,
 schwidefsky@de.ibm.com, john.stultz@linaro.org, rth@twiddle.net,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, tj@kernel.org, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 4/20/2015 8:57 AM, Baolin Wang wrote:

> This patch introduces the 'struct itimerspec64' for 64bit to replace itimerspec,
> and also introduces the conversion methods: itimerspec64_to_itimerspec() and
> itimerspec_to_itimerspec64(), that makes itimerspec to ready for 2038 year.

    "To" not needed here.

> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

[...]

WBR, Sergei
