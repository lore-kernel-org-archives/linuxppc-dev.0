Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sp86p0nHYzDrL7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 17:25:38 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: UBSAN: Undefined behaviour in
 /home/mathieu/tmp/linux-4.6.4/drivers/scsi/scsi_devinfo.c:458:21
In-Reply-To: <CA+7wUsxFPKZQOYZ12f7uU7e6eSS6aTx8MfjrNZHPMMDUiys63g@mail.gmail.com>
References: <CA+7wUszQjtBHWkGSAUKtbv8yFrHLAQ-9aZZSOM-vmgJZw4VOww@mail.gmail.com>
 <CA+7wUsxFPKZQOYZ12f7uU7e6eSS6aTx8MfjrNZHPMMDUiys63g@mail.gmail.com>
Date: Tue, 04 Oct 2016 17:25:37 +1100
Message-ID: <87mvik4om6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mathieu Malaterre <malat@debian.org> writes:

> On Sat, Oct 1, 2016 at 3:43 PM, Mathieu Malaterre <malat@debian.org> wrote:
> [...]
>> [    1.443124] UBSAN: Undefined behaviour in
>> /home/mathieu/tmp/linux-4.6.4/drivers/scsi/scsi_devinfo.c:458:21
> [...]
>
> Fixed by: https://lkml.org/lkml/2016/8/8/665

Thanks.

> Sorry for the noise.

No worries. UBSAN warnings can be either driver/subsystem or arch
specific, so if you hit any more it's probably best to send them to
linuxppc and also whatever the subsystem list is (eg. linux-scsi in this
case).

cheers
