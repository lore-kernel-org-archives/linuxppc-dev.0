Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-f173.google.com (mail-yk0-f173.google.com
 [209.85.160.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 89BCB1A2759
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 20:39:10 +1000 (AEST)
Received: by ykdu9 with SMTP id u9so925543ykd.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2015 03:39:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1441621698.8979.6.camel@ellerman.id.au>
References: <1434092231-4155-1-git-send-email-kda@linux-powerpc.org>
 <CAOJe8K0UrsVQraHrxKUptOB9sVr_U9LEB3Ji6j4nMenHKNt2dg@mail.gmail.com>
 <1434676130.3678.124.camel@kernel.crashing.org>
 <CAOJe8K13odLN__uQCc=zXoFYMyjwzEd10eDKG_ZEq5oZf1376A@mail.gmail.com>
 <1441621698.8979.6.camel@ellerman.id.au>
Date: Mon, 7 Sep 2015 13:39:07 +0300
Message-ID: <CAOJe8K05qVMkC433iZnnBzNBCGD+h5St1rqAvcyCnugMxiGNrA@mail.gmail.com>
Subject: Re: [PATCH] agp/uninorth: fix a memleak in create_gatt_table
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, airlied@gmail.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/7/15, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Mon, 2015-09-07 at 10:30 +0300, Denis Kirjanov wrote:
>> On 6/19/15, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>> > On Thu, 2015-06-18 at 17:34 +0300, Denis Kirjanov wrote:
>> >> On 6/12/15, Denis Kirjanov <kda@linux-powerpc.org> wrote:
>> >> > Fix the memory leak in create_gatt_table:
>> >> > we've lost a kfree on the exit path for the pages array allocated
>> >> > in uninorth_create_gatt_table
>> >> >
>> >> > Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
>> >>
>> >> Hi Ben, Michael
>> >>
>> >> Will you take the patch through your trees or do I need to send it to
>> >> Dave Airlie?
>> >
>> > I haven't had a chance to review yet...
>>
>> Ping...
>
> Hi Denis,
>
> Have you built and/or boot tested this?
>

Hi,

yes, sure. Actually I've spotted this through the kmemleak. With the
patch applied scanner is happy :)

> cheers
>
>
>
