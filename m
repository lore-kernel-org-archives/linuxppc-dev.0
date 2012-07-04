Return-Path: <akinobu.mita@gmail.com>
Received: from mail-gh0-f179.google.com (mail-gh0-f179.google.com
 [209.85.160.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 81E6F2C0201
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2012 20:07:22 +1000 (EST)
Received: by ghbg24 with SMTP id g24so6147839ghb.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jul 2012 03:07:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120703134120.dc89c7ae.akpm@linux-foundation.org>
References: <1341035970-20490-1-git-send-email-akinobu.mita@gmail.com>
 <20120703134120.dc89c7ae.akpm@linux-foundation.org>
Date: Wed, 4 Jul 2012 19:07:18 +0900
Message-ID: <CAC5umyhLEp_T1BF6LRNLBMcO-QEE6_hTLL1PAd=65yYRBg3rpQ@mail.gmail.com>
Subject: Re: [PATCH -v5 0/6] notifier error injection
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Pavel Machek <pavel@ucw.cz>,
 =?ISO-8859-1?Q?Am=E9rico_Wang?= <xiyou.wangcong@gmail.com>,
 linux-pm@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2012/7/4 Andrew Morton <akpm@linux-foundation.org>:
> On Sat, 30 Jun 2012 14:59:24 +0900
> Akinobu Mita <akinobu.mita@gmail.com> wrote:
>
>> This provides kernel modules that can be used to test the error handling
>> of notifier call chain failures by injecting artifical errors to the
>> following notifier chain callbacks.
>
> No updates to Documentation/fault-injection/?

Thanks for the remainder.
I'll prepare to add a document to it.
