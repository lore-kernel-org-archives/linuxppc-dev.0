Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448AD1A01CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 15:25:51 +1000 (AEST)
Received: from [192.168.1.139] (ppp-93-104-85-152.dynamic.mnet-online.de
 [93.104.85.152]) by smtp.strato.de (RZmta 37.8 DYNA|AUTH)
 with ESMTPSA id L05f8ar695JlN9N
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH
 bits, eq. 15360 bits RSA)) (Client did not present a certificate)
 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 9 Jul 2015 07:19:47 +0200 (CEST)
Subject: PASEMI: PA6T board doesn't boot with the RC1 of kernel 4.2 anymore
To: linuxppc-dev@lists.ozlabs.org
References: <559BB716.6040001@xenosoft.de> <559BC99D.20608@xenosoft.de>
 <559D653F.2060307@xenosoft.de>
 <1436394990.3948.113.camel@kernel.crashing.org>
 <1436406135.18682.3.camel@ellerman.id.au>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <559E0472.3020601@xenosoft.de>
Date: Thu, 9 Jul 2015 07:19:46 +0200
MIME-Version: 1.0
In-Reply-To: <1436406135.18682.3.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All

Many thanks for your answers. You're right. It is something wrong with 
my bisect. I will do another bisect. I will evaluate the one "sometimes 
boots" with good.

Thanks

Christian

On 09 July 2015 03:42 AM, Michael Ellerman wrote:
> On Thu, 2015-07-09 at 08:36 +1000, Benjamin Herrenschmidt wrote:
>> On Wed, 2015-07-08 at 20:00 +0200, Christian Zigotzky wrote:
>>> Dear Linuxppc-dev mailing list,
>>>
>>> I used git bisect and found out that the following commit is the problem.
>>>
>>> commit 3ceaccdf92073d193f0bfbe24280dd736e3fed86
>>> Author: Dave Hansen <dave.hansen@linux.intel.com>
>> There is no way that commit affects anything on that platform, it only
>> changes a file in arch/x86 that isn't compiled on a powerpc build. You
>> must have made a mistake in your bisection, possibly the one "sometimes
>> boots" should be considered good, but I can't say for sure.
>>
>> Michael has a PA6T board at work, so I assume he will see if he can
>> reproduce.
> Yeah I can't reproduce here.
>
> I think you need to bisect again and look for the particular crash you
> reported. If you see that crash then mark it bad, else mark it good.
>
> cheers
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
