Return-Path: <sumedhtirodkar@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.174])
	by ozlabs.org (Postfix) with ESMTP id C9735DDEDD
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 18:56:38 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 27so2030091wfd.15
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Feb 2009 23:56:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1234041420.31963.66.camel@pasglop>
References: <d2b9ccd90902062213l48c063e1gd536a347f1fbe861@mail.gmail.com>
	<1234041420.31963.66.camel@pasglop>
Date: Mon, 23 Feb 2009 13:26:37 +0530
Message-ID: <d2b9ccd90902222356n5fc9899dt86d10a234cc5eb51@mail.gmail.com>
Subject: Re: hash-table creation...
From: sumedh tirodkar <sumedhtirodkar@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks a lot...paging mechanism working successfully...

Regards,
Sumedh

On Sun, Feb 8, 2009 at 2:47 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sat, 2009-02-07 at 11:43 +0530, sumedh tirodkar wrote:
>> Hello,
>>
>> I wanted algorithm for creating hash tables used in paging mechanism..
>> In the manual that i read i got algorithm to convert Effective Address
>> to Real Address using these hash tables that are created..but i could
>> not find how these hash tables are created in first place using the
>> Real addresses.
>> Is there any document available for the same?
>
> There's one MMU hash table. It's allocated & cleared by the kernel
> during early boot or by the hypervisor and pointed to by the SDR1
> register.
>
> It's populated by code in arch/powerpc/mm/hash_low_64.S or
> hash_low_32.S, typically as the result of a hash miss exception.
>
> Ben.
>
>
