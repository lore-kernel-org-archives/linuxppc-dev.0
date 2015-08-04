Return-Path: <ranshalit@gmail.com>
Received: from mail-io0-x229.google.com (mail-io0-x229.google.com
 [IPv6:2607:f8b0:4001:c06::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 13E181A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 06:26:47 +1000 (AEST)
Received: by ioeg141 with SMTP id g141so29066557ioe.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2015 13:26:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1438714472.2097.89.camel@freescale.com>
References: <CAJ2oMhJgnPGUPKRGBXZALYcrn+sL8Nt0A6gfPN+Ei_c+06mUPg@mail.gmail.com>
 <1438714472.2097.89.camel@freescale.com>
Date: Tue, 4 Aug 2015 23:26:44 +0300
Message-ID: <CAJ2oMhLzck9SxgzcXpEXVk_Yf0KoM=D4cOToizoOUPQFZ4JjWA@mail.gmail.com>
Subject: Re: GPMC in device tree
From: Ran Shalit <ranshalit@gmail.com>
To: Scott Wood <scottwood@freescale.com>
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

On Tue, Aug 4, 2015 at 9:54 PM, Scott Wood <scottwood@freescale.com> wrote:
> On Tue, 2015-08-04 at 18:29 +0300, Ran Shalit wrote:
>> Hello,
>>
>> I would please like to ask if describing flash nor used with GPMC,
>> whould be done as described in:
>> https://www.kernel.org/doc/Documentation/devicetree/bindings/mtd/gpmc-nor.txt
>> It is described in the above link as "TI's GPMC", so I'm not sure if
>> it is relevent for powerpc too.
>
> That binding is for TI GPMC.
>
> Are you saying you have some PPC chip that has a flash controller called GPMC?
>
> -Scott
>

Hi Scott,

Thanks, I've worked with TI's chips, so I now understand that I made
here some confusion...
It is GPCM , not GPMC, my mistake.
We already configured it in u-boot, but on doing read/write from
kernel it doesn not work.
It seems that for the linux to use the correct driver, we need to
define the nor in the device tree.
Is there any example how to define nor GPCM in device tree ? Is it
possible not to override the existing GPCM configuration ?

Thank you!
Ran
