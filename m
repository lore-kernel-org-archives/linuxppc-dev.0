Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2nV21rS9zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 12:11:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com,
 andrew.donnellan@au1.ibm.com
Subject: Re: [PATCH V4 7/7] cxl: Add psl9 specific code
In-Reply-To: <2584b575-bc19-d7d8-3017-7c462a5fa800@linux.vnet.ibm.com>
References: <1491574319-11852-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1491574319-11852-8-git-send-email-clombard@linux.vnet.ibm.com>
 <2584b575-bc19-d7d8-3017-7c462a5fa800@linux.vnet.ibm.com>
Date: Wed, 12 Apr 2017 12:11:37 +1000
Message-ID: <87bms2v0h2.fsf@concordia.ellerman.id.au>
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

> Le 07/04/2017 =C3=A0 16:11, Christophe Lombard a =C3=A9crit :
>> The new Coherent Accelerator Interface Architecture, level 2, for the
>> IBM POWER9 brings new content and features:
>> - POWER9 Service Layer
>> - Registers
>> - Radix mode
>> - Process element entry
>> - Dedicated-Shared Process Programming Model
>> - Translation Fault Handling
>> - CAPP
>> - Memory Context ID
>>     If a valid mm_struct is found the memory context id is used for each
>>     transaction associated with the process handle. The PSL uses the
>>     context ID to find the corresponding process element.
>>
>> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
>> ---
>
>
> I'm ok with the code. However checkpatch is complaining about a=20
> tab/space error in native.c

I already fixed it up when I applied them (and a bunch of other things).

> If you have a quick respin, I also have a comment below about the=20
> documentation.

So please send me an incremental patch to update the doco and I'll
squash it before merging the series.

cheers
