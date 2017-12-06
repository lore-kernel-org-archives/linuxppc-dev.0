Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ysPF16CmbzDrpn
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Dec 2017 03:28:37 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB6GQdcJ054947
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Dec 2017 11:28:35 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2epjmpddux-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Dec 2017 11:28:35 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 6 Dec 2017 11:28:34 -0500
Subject: Re: [PATCH v3] ppc64 boot: Wait for boot cpu to show up if nr_cpus
 limit is about to hit.
To: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: mahesh@linux.vnet.ibm.com, npiggin@gmail.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus
 <paulus@samba.org>, Liu ping fan <kernelfans@gmail.com>
References: <20171106173426.8902-1-cascardo@canonical.com>
 <20171129124035.qp3sdmfprcbwh2sn@calabresa>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Wed, 6 Dec 2017 14:28:24 -0200
MIME-Version: 1.0
In-Reply-To: <20171129124035.qp3sdmfprcbwh2sn@calabresa>
Content-Type: text/plain; charset=utf-8
Message-Id: <02a3f733-567d-8c99-abca-82066e08d980@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/29/2017 10:40 AM, Thadeu Lima de Souza Cascardo wrote:
> Ping. Any further reviews/comments? Or any chance of this getting
> applied soon?
> 
> Thanks.
> Cascardo.
> 


Cross-referencing 2 threads on the same topic:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-November/166328.html


Liu ping fan asked the state of this patch in the above link of mailing
list thread.
Let's choose one of the threads to further discuss the solution to this
long-term bug!

Thanks,


Guilherme
