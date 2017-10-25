Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMYwy75lyzDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Oct 2017 02:30:10 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9PFQxHq164388
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 11:30:08 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dtw3r8q7f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 11:30:08 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 25 Oct 2017 09:30:07 -0600
Subject: Re: [PATCH] powerpc/powernv: Enable reset_devices parameter to issue
 a PHB reset
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 maurosr@linux.vnet.ibm.com
References: <20171012222153.24905-1-gpiccoli@linux.vnet.ibm.com>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Wed, 25 Oct 2017 13:30:02 -0200
MIME-Version: 1.0
In-Reply-To: <20171012222153.24905-1-gpiccoli@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <d32f9721-6353-824a-a243-787608347db3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

V2 just sent to linuxppc-dev[0] list, with some simplifications.
This one is then officially dropped!

Thanks,


Guilherme

[0] http://patchwork.ozlabs.org/patch/830320
