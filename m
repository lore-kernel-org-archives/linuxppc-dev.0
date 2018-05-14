Return-Path: <groeck7@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40kxsv5zVBzF3Rx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 20:35:15 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id w3-v6so5299987pgv.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 03:35:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 2/3] hwmon: (ibmpowernv): Add support to read 64 bit
 sensors
To: Michael Ellerman <mpe@ellerman.id.au>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-hwmon@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 jdelvare@suse.com, stewart@linux.vnet.ibm.com
References: <1525688738-9185-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1525688738-9185-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20180509172926.GA20996@roeck-us.net>
 <87y3gmpv8t.fsf@concordia.ellerman.id.au>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <6bcd8e6b-2f95-2ddd-ed6e-50815e46948b@roeck-us.net>
Date: Mon, 14 May 2018 03:35:09 -0700
MIME-Version: 1.0
In-Reply-To: <87y3gmpv8t.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/14/2018 12:11 AM, Michael Ellerman wrote:
> Guenter Roeck <linux@roeck-us.net> writes:
> 
>> On Mon, May 07, 2018 at 03:55:37PM +0530, Shilpasri G Bhat wrote:
>>> The firmware has supported for reading sensor values of size u32.
>>> This patch adds support to use newer firmware functions which allows
>>> to read the sensors of size u64.
>>>
>>> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>>
>> Acked-by: Guenter Roeck <linux@roeck-us.net>
>>
>> I won't apply for the time being since it depends on patch 1/3 which is
>> outside hwmon.
> 
> Do you mind if I take the series via the powerpc tree?
> 

Fine with me.

Guenter
