Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zywnw3DLlzF1jp
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Mar 2018 18:28:03 +1100 (AEDT)
Subject: Re: [PATCH 4.14 1/4] powerpc/mm/slice: Remove intermediate bitmap copy
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <69684e92a32d00c491540e8adfa34fcb50c36244.1520468013.git.christophe.leroy@c-s.fr>
 <20180310001043.GD13963@kroah.com>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <39af0017-6a9c-a032-8167-40b5f30840f8@c-s.fr>
Date: Sat, 10 Mar 2018 08:27:54 +0100
MIME-Version: 1.0
In-Reply-To: <20180310001043.GD13963@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 10/03/2018 à 01:10, Greg Kroah-Hartman a écrit :
> On Fri, Mar 09, 2018 at 04:48:59PM +0100, Christophe Leroy wrote:
>> Upstream 326691ad4f179e6edc7eb1271e618dd673e4736d
> 
> There is no such git commit id in Linus's tree :(
> 
> Please fix up and resend the series.

I checked again, it is there

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/powerpc/mm/slice.c?h=next-20180309&id=326691ad4f179e6edc7eb1271e618dd673e4736d

The id seems to be exactly the same.

Christophe

> 
> thanks,
> 
> greg k-h
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
