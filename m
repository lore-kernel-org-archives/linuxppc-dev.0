Return-Path: <jwboyer@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
 [209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 7CB8F1007D5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2011 14:22:20 +1100 (EST)
Received: by vcbfl15 with SMTP id fl15so1013587vcb.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2011 19:22:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1322012084.14573.19.camel@pasglop>
References: <20111122234933.GA28400@thor.bakeyournoodle.com>
 <CA+5PVA7js5kmK3JGDKiYa+xVqojmM2ZedifPHHWFsY7CYrqzYA@mail.gmail.com>
 <1322012084.14573.19.camel@pasglop>
Date: Tue, 22 Nov 2011 22:22:16 -0500
Message-ID: <CA+5PVA4HqcCca15urmfUaQCBC4tKmEbgNJAJViXZh9QXw2s3DQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: 44x: Add mtd ndfc to the ppx44x defconfig
From: Josh Boyer <jwboyer@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 22, 2011 at 8:34 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2011-11-22 at 20:04 -0500, Josh Boyer wrote:
>> On Tue, Nov 22, 2011 at 6:50 PM, Tony Breeds <tony@bakeyournoodle.com> w=
rote:
>> > Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
>>
>> Acked-by: Josh Boyer <jwboyer@gmail.com>
>>
>> Ben, I don't have anything particularly urgent for 3.2 and this seems
>> like it is well within the 3.2 window (defconfig updates usually come
>> later). =A0Want to pick this up yourself, or do you want me to prep a
>> tree somewhere?
>
> I'm working on 3.3 right now, so I'd rather you throw this in there, I
> doesn't seem to be particularily urgent for 3.2 is it? (who actually

Urgent, no.  I'll get a tree going after the holidays.

> uses 4xx_defconfig ?)

The linux-next tree builds it.  It would have caught a compile error
in the NDFC driver much earlier if we had it enabled in the defconfig.

josh
