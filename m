Return-Path: <arndbergmann@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSX8J5GPCzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 07:26:24 +1100 (AEDT)
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com
 [IPv6:2607:f8b0:4003:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vSX8J0wB8z9s74
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Feb 2017 07:26:24 +1100 (AEDT)
Received: by mail-oi0-x242.google.com with SMTP id f204so618521oia.1
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 12:26:24 -0800 (PST)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20170220123403.41239bbc@roar.ozlabs.ibm.com>
References: <1487313139-21959-1-git-send-email-mpe@ellerman.id.au>
 <1487313139-21959-4-git-send-email-mpe@ellerman.id.au>
 <20170220123403.41239bbc@roar.ozlabs.ibm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 21 Feb 2017 21:26:21 +0100
Message-ID: <CAK8P3a3v6E4V7uKxKyvr1NbumyDdMoE4wYkomePatjEF4jN1pw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/9] powerpc/4xx: Create 4xx pseudo-platform in
 platforms/4xx
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 20, 2017 at 3:34 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> On Fri, 17 Feb 2017 17:32:14 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> We have a lot of code in sysdev for supporting 4xx, ie. either 40x or
>> 44x. Instead it would be cleaner if it was all in platforms/4xx.
>>
>> This is slightly odd in that we don't actually define any machines in
>> the 4xx platform, as is usual for a platform directory. But still it
>> seems like a better result to have all this related code in a directory
>> by itself.
>
> What about the other things in sysdev that support multiple platforms?

Some of them have subsystem specific directories in drivers these
days, e.g. drivers/pci/host and drivers/irqchip. Some others that are
shared with ARM or ARM64 platforms are already being moved to
drivers/soc/

> Why not just put the new 4xx subdirectory under sysdev?

arch/powerpc/platforms/40x/ only has four small C files, you could also
move everything to platforms/4xx/ instead.

     Arnd
