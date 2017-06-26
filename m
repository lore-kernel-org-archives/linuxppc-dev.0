Return-Path: <srs0=7x/w=57=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wwvnX4bllzDr0c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 13:34:56 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wwvnX3hWWz8t9R
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 13:34:56 +1000 (AEST)
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wwvnW6nqzz9s76
 for <linuxppc-dev@ozlabs.org>; Mon, 26 Jun 2017 13:34:55 +1000 (AEST)
Received: by mail-qk0-x244.google.com with SMTP id p21so13217590qke.0
 for <linuxppc-dev@ozlabs.org>; Sun, 25 Jun 2017 20:34:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170603132747.GA18185@amd>
References: <20170603105232.6436-1-bsingharora@gmail.com>
 <20170603132747.GA18185@amd>
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 26 Jun 2017 13:34:52 +1000
Message-ID: <CAKTCnzk2bhFr3BvgQSzQr8TK9DB+bW7TyCtfzq7537F9Ym8QKw@mail.gmail.com>
Subject: Re: [PATCH] kernel/power/suspend: use CONFIG_HAVE_SET_MEMORY for
 include condition
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Len Brown <len.brown@intel.com>, Laura Abbott <labbott@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 3, 2017 at 11:27 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Sat 2017-06-03 20:52:32, Balbir Singh wrote:
>> Kbuild reported a build failure when CONFIG_STRICT_KERNEL_RWX was
>> enabled on powerpc. We don't yet have ARCH_HAS_SET_MEMORY and ppc32
>> saw a build failure.
>>
>> fixes(50327dd kernel/power/snapshot.c: use set_memory.h header)
>>
>> I've only done a basic compile test with a config that has
>> hibernation enabled.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Len Brown <len.brown@intel.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>

Ping. Could we please pick this up? it breaks any attempt to support
STRICT_KERNEL_RWX on powerpc

Balbir Singh.
