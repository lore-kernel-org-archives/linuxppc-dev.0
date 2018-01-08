Return-Path: <srs0=aphn=ed=linux.vnet.ibm.com=tyreld@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFpzl0jBRzDqvT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 08:57:55 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zFpzk6q3dz8t1b
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 08:57:54 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zFpzk2zbMz9s9Y
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2018 08:57:54 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.21) with SMTP id
 w08LtR58025853
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Jan 2018 16:57:52 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fcgtggdgm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 08 Jan 2018 16:57:51 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 8 Jan 2018 16:57:50 -0500
Subject: Re: [PATCH 11/11] powerpc/powernv: Check device-tree for RFI flush
 settings
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, peterz@infradead.org, linux-kernel@vger.kernel.org,
 npiggin@gmail.com, oohall@gmail.com, anton@samba.org, paulus@samba.org,
 tglx@linutronix.de
References: <20180108165453.26066-1-mpe@ellerman.id.au>
 <20180108165453.26066-11-mpe@ellerman.id.au>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Mon, 8 Jan 2018 13:57:44 -0800
MIME-Version: 1.0
In-Reply-To: <20180108165453.26066-11-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <6837547b-3ad3-cc08-eaa9-94e595971a77@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/08/2018 08:54 AM, Michael Ellerman wrote:
> From: Oliver O'Halloran <oohall@gmail.com>
> 
> New device-tree properties are available which tell the hypervisor
> settings related to the RFI flush. Use them to determine the
> appropriate flush instruction to use, and whether the flush is
> required.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
