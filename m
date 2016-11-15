Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHs7J5pHqzDvn5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 13:40:12 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, Balbir Singh <bsingharora@gmail.com>
Subject: Re: [powerpc v5 0/3] Enable IAMR storage keys for radix
In-Reply-To: <1479125778-18496-1-git-send-email-bsingharora@gmail.com>
References: <1479125778-18496-1-git-send-email-bsingharora@gmail.com>
Date: Tue, 15 Nov 2016 13:40:12 +1100
Message-ID: <87bmxhzcs3.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:

> The first patch sets up AMOR in hypervisor mode. AMOR
> needs to be setup before IAMR (details of AMOR/IAMR in
> each patch). The second patch enables detection of exceptions
> generated due to instruction fetch violations caused
> and OOPSs' the task. The third patch enables IAMR for
> both hypervisor and guest kernels.
>
> I've tested with patch series with a sample hack and
> payload.
>
> Chris Smart helped with the series, reviewing and
> providing valuable feedback
>
> Changelog
>   Remove __init annotation for iamr and amor init
>
> Balbir Singh (3):
>   Setup AMOR in HV mode
>   Enable storage keys for radix - user mode execution

These should be "powerpc/mm/radix: ...".

>   Detect instruction fetch denied and report

And that should be "powerpc/mm: ..."

cheers
