Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zhb5d5XRyzF13Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 10:21:57 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Cyril Bur <cyrilbur@gmail.com>
Subject: Re: [PATCH V3 0/9] powerpc: Support for ibm,dynamic-memory-v2
In-Reply-To: <53bf14ae-bb01-585d-3d40-2d8afeb5d345@linux.vnet.ibm.com>
References: <151214667699.64022.17601877129884655591.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <87a7yz3wjo.fsf@concordia.ellerman.id.au>
 <53bf14ae-bb01-585d-3d40-2d8afeb5d345@linux.vnet.ibm.com>
Date: Thu, 15 Feb 2018 10:21:55 +1100
Message-ID: <873723qhrg.fsf@concordia.ellerman.id.au>
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

Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:

> On 12/03/2017 09:13 PM, Michael Ellerman wrote:
>> Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:
>> 
>>> This patch set provides a series of updates to de-couple the LMB
>>> information provided in the device tree property from the device
>>> tree property format. This eases the ability to support a new
>>> format for the dynamic memory property, ibm,dynamic-memory-v2.
>> 
>> Something in here is still blowing up for me in a KVM guest:
>
> So, it looks like this series was applied despite observing this KVM
> guest crash.

The crash has gone away for me, I do that KVM guest test on every push.

So I applied the series, but yeah you're right that was probably silly
of me.

cheers
