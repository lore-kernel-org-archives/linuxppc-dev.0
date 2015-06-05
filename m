Return-Path: <richard.weinberger@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 576C01A0D31
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 18:16:38 +1000 (AEST)
Received: from mail-vn0-x22d.google.com (mail-vn0-x22d.google.com
 [IPv6:2607:f8b0:400c:c0f::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A80B31401F6
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Jun 2015 18:16:37 +1000 (AEST)
Received: by vnbf190 with SMTP id f190so8192235vnb.5
 for <linuxppc-dev@ozlabs.org>; Fri, 05 Jun 2015 01:16:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1433479201.3379.10.camel@cyril>
References: <1433219169-5115-1-git-send-email-cyrilbur@gmail.com>
 <1433479201.3379.10.camel@cyril>
Date: Fri, 5 Jun 2015 10:16:34 +0200
Message-ID: <CAFLxGvxM1V8EMmZotqhSUG-q0cy+NpufeksChjJrD0qSJCSB0g@mail.gmail.com>
Subject: Re: [PATCH V3] drivers/mtd: add powernv flash MTD abstraction driver
From: Richard Weinberger <richard.weinberger@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>, linuxppc-dev@ozlabs.org,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 5, 2015 at 6:40 AM, Cyril Bur <cyrilbur@gmail.com> wrote:
> On Tue, 2015-06-02 at 14:26 +1000, Cyril Bur wrote:
>> Powerpc powernv platforms allow access to certain system flash devices
>> through a firmwarwe interface. This change adds an mtd driver for these
>> flash devices.
>>
>> Minor updates from Jeremy Kerr and Joel Stanley.
>>
>> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
>> ---
>> Hello Brian and MTD folk,
>> Could I please get an ACK for Michael to take this through the powerpc
>> tree.
>> Thanks.
>>
>
> Hello Brian,
>
> As we have some deadlines approaching, I am getting pressure to ensure
> this gets merged upstream as quickly as possible, please let me know if
> there is anything more which can be done.

FYI, Brian is not available for the next 1.5 weeks.
So I fear this driver has to wait for the next merge window.

-- 
Thanks,
//richard
