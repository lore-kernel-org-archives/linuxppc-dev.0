Return-Path: <oohall@gmail.com>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vX0Cl0HwDzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 22:41:22 +1100 (AEDT)
Received: by mail-qk0-x242.google.com with SMTP id n127so16294272qkf.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 03:41:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87lgsrrjfb.fsf@concordia.ellerman.id.au>
References: <20170224062054.31408-1-matthew.brown.dev@gmail.com>
 <87lgsrrjfb.fsf@concordia.ellerman.id.au>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Mon, 27 Feb 2017 22:41:20 +1100
Message-ID: <CAOSf1CF2-E6eV5bf95qr-uYxcxEdhpLevWbmHW97virJhNxS4g@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/powernv: add hdat attribute to sysfs
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 27, 2017 at 9:56 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Matt Brown <matthew.brown.dev@gmail.com> writes:
>> diff --git a/arch/powerpc/platforms/powernv/opal-hdat.c b/arch/powerpc/platforms/powernv/opal-hdat.c
>> new file mode 100644
>> index 0000000..3315dd3
>> --- /dev/null
>> +++ b/arch/powerpc/platforms/powernv/opal-hdat.c
>> @@ -0,0 +1,65 @@
> ...
>> +
>> +
>> +/* HDAT attribute for sysfs */
>> +static struct bin_attribute hdat_attr = {
>> +     .attr = {.name = "hdat", .mode = 0444},
>                                          ^^^^
> ajd and oohal report to my office.

I don't think there's anything in the HDAT that's sensitive. That
said, this might not be true in the future so making it only readable
by root might be a good idea.

Oliver
