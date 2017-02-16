Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vP2z109ggzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 15:21:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Cc: jallen@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/pseries: Fix build break when MEMORY_HOTREMOVE=n
In-Reply-To: <aa351118-d400-be1e-5b48-136eefc9ca7d@linux.vnet.ibm.com>
References: <1487214078-3893-1-git-send-email-mpe@ellerman.id.au>
 <aa351118-d400-be1e-5b48-136eefc9ca7d@linux.vnet.ibm.com>
Date: Thu, 16 Feb 2017 15:21:16 +1100
Message-ID: <87zihmkbpf.fsf@concordia.ellerman.id.au>
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

Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:

> On 02/15/2017 09:01 PM, Michael Ellerman wrote:
>> We broke the build when CONFIG_MEMORY_HOTREMOVE=3Dn:
>>=20
>>   arch/powerpc/platforms/pseries/hotplug-memory.c:821:8: error: implicit
>>   declaration of function 'dlpar_memory_readd_by_index'
>>=20
>> Add a dummy to fix it.
>>=20
>> Fixes: e70d59700fc3 ("powerpc/pseries: Introduce memory hotplug READD op=
eration")
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Looks like we both saw the same thing today, this was patch 1/4 in the
> 'Implement indexed-count memory hotplug'=E2=80=8B patchset I sent out ear=
lier today.

Ah right, sorry. My auto builds hit it overnight, and then I sent it
before checking mail today.

> Perhaps I should have sent that as a separate patch.

No biggy.

cheers
