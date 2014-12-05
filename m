Return-Path: <alessio.bogani@elettra.eu>
Received: from spamalot.elettra.eu (spamalot.elettra.trieste.it
 [140.105.206.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5AEC71A0CE1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 19:11:03 +1100 (AEDT)
Received: from spamalot.elettra.eu (localhost.localdomain [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id 9FF87440DAF_4816891B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 08:10:57 +0000 (GMT)
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (verified OK))
 by spamalot.elettra.eu (Sophos Email Appliance) with ESMTPSA id
 1E7CE43E066_4816891F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 08:10:57 +0000 (GMT)
Received: by mail-wi0-f179.google.com with SMTP id ex7so544586wid.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Dec 2014 00:10:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1417724162.334.5.camel@freescale.com>
References: <1417685009-1640-1-git-send-email-alessio.bogani@elettra.eu>
 <1417724162.334.5.camel@freescale.com>
Date: Fri, 5 Dec 2014 09:10:56 +0100
Message-ID: <CAPk1OjGNctTjMcUFtdKL_iOXt_ym11CXqc9eC9BbzywzE3VxQQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] powerpc/85xx: Add support for Emerson/Artesyn
 MVME2500.
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

On 4 December 2014 at 21:16, Scott Wood <scottwood@freescale.com> wrote:
> On Thu, 2014-12-04 at 10:23 +0100, Alessio Igor Bogani wrote:
>> +/include/ "fsl/pq3-mpic-message-B.dtsi"
>
> The MPIC message include should be done in the SoC file -- it's not
> board-specific.
>
> For some reason I don't see this dtsi being included by anything
> currently.

For the moment I'll remove it.

>> @@ -80,33 +82,21 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>>  CONFIG_DEVTMPFS=y
>>  CONFIG_DEVTMPFS_MOUNT=y
>>  CONFIG_MTD=y
>> -CONFIG_MTD_OF_PARTS=y
>>  CONFIG_MTD_CMDLINE_PARTS=y
>> -CONFIG_MTD_CHAR=y
>> -CONFIG_MTD_BLKDEVS=y
>>  CONFIG_MTD_BLOCK=y
>>  CONFIG_FTL=y
>>  CONFIG_MTD_CFI=y
>> -CONFIG_MTD_GEN_PROBE=y
>> -CONFIG_MTD_MAP_BANK_WIDTH_1=y
>> -CONFIG_MTD_MAP_BANK_WIDTH_2=y
>> -CONFIG_MTD_MAP_BANK_WIDTH_4=y
>> -CONFIG_MTD_CFI_I1=y
>> -CONFIG_MTD_CFI_I2=y
>
> Are these removals due to make savedefconfig?

Yes

> Please have a separate
> patch that just runs make savedefconfig first, so that we can see what
> actual changes are being made.

Sure!

> Otherwise, looks good.

Thanks!

Ciao,
Alessio
