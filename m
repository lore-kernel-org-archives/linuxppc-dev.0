Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x229.google.com (mail-pf0-x229.google.com
 [IPv6:2607:f8b0:400e:c00::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D05531A039B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 10:45:33 +1100 (AEDT)
Received: by mail-pf0-x229.google.com with SMTP id e127so19829265pfe.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 15:45:33 -0800 (PST)
Subject: Re: [V3] powerpc/powernv: Remove support for p5ioc2
To: Michael Ellerman <mpe@ellerman.id.au>, Russell Currey
 <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
References: <20160217124131.3E1D6140770@ozlabs.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <56C50615.1030601@ozlabs.ru>
Date: Thu, 18 Feb 2016 10:45:25 +1100
MIME-Version: 1.0
In-Reply-To: <20160217124131.3E1D6140770@ozlabs.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2016 11:41 PM, Michael Ellerman wrote:
> On Mon, 2016-08-02 at 04:08:20 UTC, Russell Currey wrote:
>> "p5ioc2 is used by approximately 2 machines in the world, and has never
>> ever been a supported configuration."
>>
>> The code for p5ioc2 is essentially unused and complicates what is already
>> a very complicated codebase.  Its removal is essentially a "free win" in
>> the effort to simplify the powernv PCI code.
>>
>> In addition, support for p5ioc2 has been dropped from skiboot.  There's no
>> reason to keep it around in the kernel.
>>
>> Signed-off-by: Russell Currey <ruscur@russell.cc>
>> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
>
> Applied to powerpc next, thanks.
>
> https://git.kernel.org/powerpc/c/2de50e9674fc4ca3c6174b0447


WOW! Nice :( I am using one, every day, even for HV KVM sometime. Thanks, 
folks.


-- 
Alexey
