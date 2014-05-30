Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8B8D31A0705
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 May 2014 00:05:48 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Fri, 30 May 2014 19:35:45 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id B37BA394003E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 May 2014 19:35:42 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4UE5qY854001834
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 May 2014 19:35:53 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4UE5fiJ025005
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 May 2014 19:35:41 +0530
Message-ID: <5388902A.6050301@linux.vnet.ibm.com>
Date: Fri, 30 May 2014 19:35:30 +0530
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] powerpc/powernv: hwmon driver for power values, fan
 rpm and temperature
References: <20140519141931.9248.11356.stgit@neelegup-tp-t420.in.ibm.com>
 <53858F02.2020808@roeck-us.net> <1401262871.8262.22.camel@pasglop>
In-Reply-To: <1401262871.8262.22.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: sbhat@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, jdelvare@suse.de,
 lm-sensors@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 05/28/2014 01:11 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2014-05-28 at 00:23 -0700, Guenter Roeck wrote:
>> Consider using of_property_read_u32().
>>
>>> +             sdata[count].id = *sensor_id;
>>> +             sdata[count].type = type;
> Especially since this is broken for Little Endian !
>
> Neelesh, please make sure you test your patch on LE.
>
> Cheers,
> Ben.

Fixing it and will surely test on LE as well before posting.

- Neelesh
