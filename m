Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DF9932C02A1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 15:39:09 +1000 (EST)
Message-ID: <51DCF3A1.6050101@windriver.com>
Date: Wed, 10 Jul 2013 13:39:45 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Subject: Re: [v3][PATCH 1/8] powerpc/book3e: rename interrupt_end_book3e with
 __end_interrupts
References: <1373357007-30785-1-git-send-email-tiejun.chen@windriver.com>
 <1373357007-30785-2-git-send-email-tiejun.chen@windriver.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D070AE11F@039-SN2MPN1-011.039d.mgd.msft.net>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D070AE11F@039-SN2MPN1-011.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/10/2013 01:17 PM, Bhushan Bharat-R65777 wrote:
>
>
>> -----Original Message-----
>> From: Linuxppc-dev [mailto:linuxppc-dev-
>> bounces+bharat.bhushan=freescale.com@lists.ozlabs.org] On Behalf Of Tiejun Chen
>> Sent: Tuesday, July 09, 2013 1:33 PM
>> To: benh@kernel.crashing.org
>> Cc: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org
>> Subject: [v3][PATCH 1/8] powerpc/book3e: rename interrupt_end_book3e with
>> __end_interrupts
>>
>> We can rename 'interrupt_end_book3e' with '__end_interrupts' then book3s/book3e
>> can share this unique label to make sure we can use this conveniently.
>
> I think we can be consistent with start and end names, no?

Are you saying to rename 'interrupt_base_book3e' with '__base_interrupts' here? 
But seems optional since book3s have no this similar start label, so I'd like to 
keep that as original now.

Lets listen other comments firstly.

Tiejun
