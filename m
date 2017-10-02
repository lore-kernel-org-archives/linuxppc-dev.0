Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5d0566S9zDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 09:59:33 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v92Mwme9128503
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Oct 2017 18:59:30 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dbt1qukkb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Oct 2017 18:59:30 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Mon, 2 Oct 2017 16:59:29 -0600
Subject: Re: [PATCH] drivers: of: increase MAX_RESERVED_REGIONS to 32
To: Stewart Smith <stewart@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 linux-kernel@vger.kernel.org, obh+dt@kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <CAL_JsqL29j59wJtmOAuD=N7Tccv2rxEMav90yxTyGTfhwHQUsw@mail.gmail.com>
 <20170926084000.29105-1-stewart@linux.vnet.ibm.com>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Mon, 2 Oct 2017 19:58:30 -0300
MIME-Version: 1.0
In-Reply-To: <20170926084000.29105-1-stewart@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <ddd472b4-6eea-80a3-53c6-bd63b565ff63@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/26/2017 05:40 AM, Stewart Smith wrote:
> The simple fix is to bump the length of the array to 32 which "should be
> enough for everyone(TM)".

Tested-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>

# uname -r
4.14.0-rc3

# dmesg
[    0.000000] opal: OPAL detected !
[    0.000000] crashkernel: memory value expected
[    0.000000] OF: reserved mem: not enough space all defined regions.
[    0.000000] OF: reserved mem: not enough space all defined regions.
[    0.000000] OF: reserved mem: not enough space all defined regions.
[    0.000000] OF: reserved mem: not enough space all defined regions.
[    0.000000] Allocated 2883584 bytes for 2048 pacas at c00000000fd40000
<...>

# uname -r
4.14.0-rc3.of32maxrsvdmemregions

# dmesg | head
[    0.000000] opal: OPAL detected !
[    0.000000] crashkernel: memory value expected
[    0.000000] Allocated 2883584 bytes for 2048 pacas at c00000000fd40000
<...>


-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
