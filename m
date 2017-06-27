Return-Path: <srs0=jsry=6a=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxkvb0Vk9zDr0s
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 21:58:03 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wxkvZ70FQz8sX0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 21:58:02 +1000 (AEST)
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wxkvZ2g4lz9s74
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Jun 2017 21:58:02 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id m54so906639qtb.1
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Jun 2017 04:58:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1602211.zd022FB7i2@aspire.rjw.lan>
References: <20170603105232.6436-1-bsingharora@gmail.com>
 <20170603132747.GA18185@amd>
 <CAKTCnzk2bhFr3BvgQSzQr8TK9DB+bW7TyCtfzq7537F9Ym8QKw@mail.gmail.com>
 <1602211.zd022FB7i2@aspire.rjw.lan>
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 27 Jun 2017 21:57:58 +1000
Message-ID: <CAKTCnz=1AixH3BVV8PuRLTwn6DZ=Lj9rM697K0sKTo3sypM0MQ@mail.gmail.com>
Subject: Re: [PATCH] kernel/power/suspend: use CONFIG_HAVE_SET_MEMORY for
 include condition
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Len Brown <len.brown@intel.com>,
 Laura Abbott <labbott@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 27, 2017 at 7:07 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, June 26, 2017 01:34:52 PM Balbir Singh wrote:
>> On Sat, Jun 3, 2017 at 11:27 PM, Pavel Machek <pavel@ucw.cz> wrote:
>> > On Sat 2017-06-03 20:52:32, Balbir Singh wrote:
>> >> Kbuild reported a build failure when CONFIG_STRICT_KERNEL_RWX was
>> >> enabled on powerpc. We don't yet have ARCH_HAS_SET_MEMORY and ppc32
>> >> saw a build failure.
>> >>
>> >> fixes(50327dd kernel/power/snapshot.c: use set_memory.h header)
>> >>
>> >> I've only done a basic compile test with a config that has
>> >> hibernation enabled.
>> >>
>> >> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> >> Cc: Len Brown <len.brown@intel.com>
>> > Acked-by: Pavel Machek <pavel@ucw.cz>
>>
>> Ping. Could we please pick this up? it breaks any attempt to support
>> STRICT_KERNEL_RWX on powerpc
>
> Yes, I'm going to pick it up for 4.13.

Thanks,
Balbir Singh.
