Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ksLX5KVSzF3TF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 17:11:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Guenter Roeck <linux@roeck-us.net>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-hwmon@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 jdelvare@suse.com, stewart@linux.vnet.ibm.com
Subject: Re: [PATCH 2/3] hwmon: (ibmpowernv): Add support to read 64 bit
 sensors
In-Reply-To: <20180509172926.GA20996@roeck-us.net>
References: <1525688738-9185-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1525688738-9185-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20180509172926.GA20996@roeck-us.net>
Date: Mon, 14 May 2018 17:11:14 +1000
Message-ID: <87y3gmpv8t.fsf@concordia.ellerman.id.au>
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

Guenter Roeck <linux@roeck-us.net> writes:

> On Mon, May 07, 2018 at 03:55:37PM +0530, Shilpasri G Bhat wrote:
>> The firmware has supported for reading sensor values of size u32.
>> This patch adds support to use newer firmware functions which allows
>> to read the sensors of size u64.
>> 
>> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
>
> I won't apply for the time being since it depends on patch 1/3 which is
> outside hwmon.

Do you mind if I take the series via the powerpc tree?

cheers
