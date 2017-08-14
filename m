Return-Path: <victora@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWV5k3jQmzDrCQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 08:04:58 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7EM4stC057002
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 18:04:56 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cbkurh198-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 18:04:55 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <victora@linux.vnet.ibm.com>;
 Mon, 14 Aug 2017 16:04:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 14 Aug 2017 19:06:31 -0300
From: Victor Aoqui <victora@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, victora@br.ibm.com,
 mauricfo@linux.vnet.ibm.com
Subject: Re: [PATCH v3] powerpc/mm: Implemented default_hugepagesz
 verification for powerpc
In-Reply-To: <87zibf3mfg.fsf@linux.vnet.ibm.com>
References: <20170724235202.5675-1-victora@linux.vnet.ibm.com>
 <87zibf3mfg.fsf@linux.vnet.ibm.com>
Message-Id: <5c722efebd21bcd56c2a857154bb1830@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em 2017-08-04 02:57, Aneesh Kumar K.V escreveu:
> Victor Aoqui <victora@linux.vnet.ibm.com> writes:
> 
>> Implemented default hugepage size verification (default_hugepagesz=)
>> in order to allow allocation of defined number of pages (hugepages=)
>> only for supported hugepage sizes.
>> 
>> Signed-off-by: Victor Aoqui <victora@linux.vnet.ibm.com>
> 
> I am still not sure about this. With current upstream we get
> 
>  PCI: Probing PCI hardware
>  PCI: Probing PCI hardware done
> 
> 
>  HugeTLB: unsupported default_hugepagesz 2097152. Reverting to
> 16777216
> 
>  HugeTLB registered 16.0 MiB page size, pre-allocated 0 pages
> 
> 
>  HugeTLB registered 16.0 GiB page size, pre-allocated 0 pages
> 
> That warning is added by
> 
> d715cf804a0318e83c75c0a7abd1a4b9ce13e8da
> 
> Which should be good enough right ?
> 
> -aneesh

Hi Aneesh,

Sorry for the delay. I was on vacation.
Yes, that solves the issue. This patch was accepted when I was fixing 
the last version.
Sorry for the inconvenience.

-- 
Victor Aoqui
