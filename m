Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zp0h21cTnzF1mJ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Feb 2018 05:52:01 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1NIoFEY137283
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 13:51:59 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gapyk40th-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 13:51:58 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Fri, 23 Feb 2018 18:51:56 -0000
Date: Fri, 23 Feb 2018 10:51:47 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/2] selftests/powerpc: Add core file test for Protection
 Key registers
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180223183344.21038-1-bauerman@linux.vnet.ibm.com>
 <20180223183344.21038-2-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180223183344.21038-2-bauerman@linux.vnet.ibm.com>
Message-Id: <20180223185147.GJ5559@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 23, 2018 at 03:33:44PM -0300, Thiago Jung Bauermann wrote:
> This test verifies that the AMR, IAMR and UAMOR are being written to a
> process' core file.
> 

Acked-by: Ram Pai <linuxram@us.ibm.com>
Tested-by: Ram Pai <linuxram@us.ibm.com>

> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---
>  tools/testing/selftests/powerpc/ptrace/Makefile    |   5 +-
>  tools/testing/selftests/powerpc/ptrace/core-pkey.c | 460 +++++++++++++++++++++
>  2 files changed, 464 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/core-pkey.c
> 
.snip...

RP
