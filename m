Return-Path: <cseo@linux.vnet.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF5EA1A003F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jan 2016 09:30:58 +1100 (AEDT)
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cseo@linux.vnet.ibm.com>;
 Fri, 15 Jan 2016 20:30:52 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 5199F352006E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 17:30:44 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0FMSdpZ63832244
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 20:28:39 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0FMUntd001053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 17:30:49 -0500
Subject: Re: [PATCH] Add hwcap2 bits for POWER9
To: Tulio Magno Quites Machado Filho <tuliom@linux.vnet.ibm.com>,
 "Carlos O'Donell" <carlos@redhat.com>
References: <568C272D.6000705@linux.vnet.ibm.com>
 <87egdsi4om.fsf@totoro.br.ibm.com> <1452267366.5201.12.camel@vnet.ibm.com>
 <568FE3D0.7080008@linaro.org> <87wprgdu3u.fsf@totoro.br.ibm.com>
 <5693C861.9030308@redhat.com> <87bn8revra.fsf@totoro.br.ibm.com>
Cc: Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 libc-alpha@sourceware.org, linuxppc-dev@lists.ozlabs.org,
 Steve Munroe <munroesj@linux.vnet.ibm.com>
From: Carlos Eduardo Seo <cseo@linux.vnet.ibm.com>
Message-ID: <56997314.9060102@linux.vnet.ibm.com>
Date: Fri, 15 Jan 2016 20:30:44 -0200
MIME-Version: 1.0
In-Reply-To: <87bn8revra.fsf@totoro.br.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 1/11/16 5:55 PM, Tulio Magno Quites Machado Filho wrote:
>
> However, I do agree with the concerns raised by Peter and Adhemerval: glibc
> should be in sync with the kernel by the time of the release in order to
> guarantee both bits are reserved for the exact same goal and we should have
> both AT_HWCAP and AT_PLATFORM supporting the new processor.
> With that said, I was planning to revert both commits d2de9ef7 and b1f19b8e
> if we don't get the kernel patch accepted into the powerpc tree in time for
> the release 2.23.
>

Kernel patch is in, commit f689b742f217b2ffe7925f8a6521b208ee995309

Regards,

-- 
Carlos Eduardo Seo
Software Engineer - Linux on Power Toolchain
cseo@linux.vnet.ibm.com
