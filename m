Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x22d.google.com (mail-wm0-x22d.google.com
 [IPv6:2a00:1450:400c:c09::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTK066ddRzDqhH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 16:06:14 +1000 (AEST)
Received: by mail-wm0-x22d.google.com with SMTP id n184so105582227wmn.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 23:06:14 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <1465874771.18900.4.camel@ellerman.id.au>
References: <CA+7wUsxzwTkWKgRH5yG2rNawcJZYYFLaQP0aun8YUD5eoC1i-g@mail.gmail.com>
 <1465874771.18900.4.camel@ellerman.id.au>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 14 Jun 2016 08:05:52 +0200
Message-ID: <CA+7wUsyTQCZZJO7jR7Wm-tkHQARGTANkfoqcdDwefG=Vmtr_GA@mail.gmail.com>
Subject: Re: Rational for having CONFIG_FB_RADEON=m
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Tue, Jun 14, 2016 at 5:26 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Mon, 2016-06-13 at 17:46 +0200, Mathieu Malaterre wrote:
>
>> 2. Try to fix `radeonfb` so that it is able to kick offb out of the
>> way. Eg: https://lists.freedesktop.org/archives/dri-devel/2010-August/002907.html
>>
>> From my understanding it would make sense to go for (2), since it
>> would allow for proper support for CONFIG_FB_RADEON=m on PowerMac. In
>> this case, would such patch be accepted ?
>
> Sounds like the right fix to me. Ben's patch above was merged, so it's supposed
> to kick out offb AFAICS, the fact that it can't seems like a bug.

I can do a `modprobe radeon` just fine, thanks to this patch. A
similar patch needs to be applied for `radeonfb` now. I'll work on it
ASAP.

-M
