Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ytW0l1wWkzDr26
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Dec 2017 22:51:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, Colin King <colin.king@canonical.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "open list\:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
 <linuxppc-dev@lists.ozlabs.org>, kernel-janitors@vger.kernel.org,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc/xmon: use ARRAY_SIZE on various array sizing
 calculations
In-Reply-To: <CAKTCnzmNKtg1morOPS7D3iGHFxZxd1uioex1eGtChBVppcctKA@mail.gmail.com>
References: <20171207110134.22566-1-colin.king@canonical.com>
 <CAKTCnzmNKtg1morOPS7D3iGHFxZxd1uioex1eGtChBVppcctKA@mail.gmail.com>
Date: Fri, 08 Dec 2017 22:51:50 +1100
Message-ID: <87efo5h1yh.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:

> On Thu, Dec 7, 2017 at 10:01 PM, Colin King <colin.king@canonical.com> wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Use the ARRAY_SIZE macro on several arrays to determine their size.
>> Improvement suggested by coccinelle.
>
> This file is taken from binutils and re-licensed. Keeping the file
> as-is helps apply newer patches easily on top as opposed to redoing
> the changes. I would prefer not to move to ARRAY_SIZE and stick to
> what's already in the file.

Yep.

Thanks but no thanks on this one Colin.

Is there a checkpatch blacklist anywhere? So we don't keep discovering
things in this file that need to be fixed?

cheers
