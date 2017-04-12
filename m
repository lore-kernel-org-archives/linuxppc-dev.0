Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2nWy6jXQzDq7j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 12:13:18 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com,
 andrew.donnellan@au1.ibm.com
Subject: Re: [PATCH V4 6/7] cxl: Isolate few psl8 specific calls
In-Reply-To: <1c31a1d5-dbff-bf57-213c-e6b38a82b807@linux.vnet.ibm.com>
References: <1491574319-11852-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1491574319-11852-7-git-send-email-clombard@linux.vnet.ibm.com>
 <1c31a1d5-dbff-bf57-213c-e6b38a82b807@linux.vnet.ibm.com>
Date: Wed, 12 Apr 2017 12:13:18 +1000
Message-ID: <878tn6v0e9.fsf@concordia.ellerman.id.au>
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
>> Point out the specific Coherent Accelerator Interface Architecture,
>> level 1, registers.
>> Code and functions specific to PSL8 (CAIA1) must be framed.
>>
>> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
>> ---
>
> There are a few changes in native.c which are about splitting long=20
> strings, but that's minor. And the rest looks ok.

It is minor, so I fixed it up when applying. But in future please don't
split long strings, it makes them harder to grep for.

cheers
