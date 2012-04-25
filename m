Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 508B9B6FAA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2012 19:22:49 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Wed, 25 Apr 2012 14:52:44 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3P9MQ8A20512816
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2012 14:52:26 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3PEr3oi026241
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2012 00:53:03 +1000
Message-ID: <4F97C243.80806@in.ibm.com>
Date: Wed, 25 Apr 2012 14:52:11 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH 0/2] Kdump support for 47x
References: <20120416082449.27331.12488.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20120416082449.27331.12488.stgit@suzukikp.in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/16/2012 01:56 PM, Suzuki K. Poulose wrote:
> The following series implements Kexec/Kdump support for
> PPC_47x based platforms. Doesn't support SMP yet.
>
> I have tested these patches on the following simulators:
>          1) simics
>          2) IBM ISS for ppc476.
>
> Changes since V1:
>   * Initialize the SPRN_PID to kernel pid (0) before the TLB operations in
>     setup_map_47x
>
>

Josh,

Did you get a chance to look at this ?

Thanks

Suzuki

> ---
>
> Suzuki K. Poulose (2):
>        [47x] Enable CRASH_DUMP
>        [47x] Kernel support for KEXEC
>
>
>   arch/powerpc/Kconfig          |    4 -
>   arch/powerpc/kernel/misc_32.S |  195 ++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 191 insertions(+), 8 deletions(-)
>
