Return-Path: <B25806@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 335AF2C00DB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 12:52:30 +1000 (EST)
Received: from mail223-ch1 (localhost [127.0.0.1])	by
 mail223-ch1-R.bigfish.com (Postfix) with ESMTP id 7CABA4A018E	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 02:52:24 +0000 (UTC)
Received: from CH1EHSMHS032.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.241])	by mail223-ch1.bigfish.com (Postfix) with ESMTP id
 7EF0B160049	for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 02:52:12
 +0000 (UTC)
Message-ID: <51F87D20.6070801@freescale.com>
Date: Wed, 31 Jul 2013 10:57:36 +0800
From: Chunhe Lan <b25806@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2] powerpc/85xx: Add P1023RDB board support
References: <1375210628.30721.78@snotra>
In-Reply-To: <1375210628.30721.78@snotra>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/31/2013 02:57 AM, Scott Wood wrote:
> On 07/30/2013 06:40:29 AM, Chunhe Lan wrote: +
>> +    lbc: localbus@ff605000 {
>> +        reg = <0 0xff605000 0 0x1000>;
>> +
>> +        /* NOR, NAND Flashes */
>> +        ranges = <0x0 0x0 0x0 0xec000000 0x04000000
>> +              0x1 0x0 0x0 0xffa00000 0x08000000>;
>
> Is there no FPGA attached to eLBC?

     Yes, p1023rdb does not have FPGA attached to eLBC.

Thanks,
-Chunhe
