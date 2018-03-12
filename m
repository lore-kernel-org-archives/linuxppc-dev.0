Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 400HMx0N81zF08f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 23:28:43 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2CCJI0l105778
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 08:28:40 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gnrm02k0r-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 08:28:40 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Mon, 12 Mar 2018 08:28:39 -0400
Subject: Re: [PATCH] powerpc/mm: Fix section mismatch warning in
 stop_machine_change_mapping()
To: Balbir Singh <bsingharora@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <1520628358-1762-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <CAKTCnzmdNx01cx94J3mn0auDFrRuOs1PvwsxvOt9VK0AtQf7eA@mail.gmail.com>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Mon, 12 Mar 2018 09:28:33 -0300
MIME-Version: 1.0
In-Reply-To: <CAKTCnzmdNx01cx94J3mn0auDFrRuOs1PvwsxvOt9VK0AtQf7eA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c12c1909-30e2-e3be-c288-806168dba9bb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir,

On 03/11/2018 03:23 AM, Balbir Singh wrote:
> Looks reasonable, I'd recommend trying to compile with MEMORY_HOTPLUG
> and MEMORY_HOTREMOVE enabled/disabled as well

Thanks for reviewing.

I should have mentioned it :) I did that (disable CONFIG_MEMORY_HOTPLUG)
and all the related functions are not included in vmlinux, since they
are guarded under that config option.

cheers,
Mauricio
