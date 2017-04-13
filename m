Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3dJ70XvJzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 21:05:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com
Subject: Re: [PATCH V4 7/7] cxl: Add psl9 specific code
In-Reply-To: <50091fa6-d6f5-47ff-dab3-ab9e2c50ab6b@linux.vnet.ibm.com>
References: <1491574319-11852-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1491574319-11852-8-git-send-email-clombard@linux.vnet.ibm.com>
 <12e9c746-4f52-d807-2e4f-32ad0b827fb2@au1.ibm.com>
 <50091fa6-d6f5-47ff-dab3-ab9e2c50ab6b@linux.vnet.ibm.com>
Date: Thu, 13 Apr 2017 21:05:57 +1000
Message-ID: <87wpao8t4a.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:

> Le 12/04/2017 =C3=A0 09:52, Andrew Donnellan a =C3=A9crit :
>> On 08/04/17 00:11, Christophe Lombard wrote:
>>> +static u32 get_phb_index(struct device_node *np)
>>>  {
>>>      u32 phb_index;
>>>
>>>      if (of_property_read_u32(np, "ibm,phb-index", &phb_index))
>>> -        return 0;
>>> +        return -ENODEV;
>>
>> Function is unsigned.
>
> [Christophe is off till the end of the week, so I'm following up]
>
> Michael: what's the easiest for you at this point? Shall I send a new=20
> version of the 7th patch with all changes consolidated (tab error + doc=20
> + Andrew's remark above)?

An incremental patch would have been easiest, but that's OK I've taken
your remix.

cheers
