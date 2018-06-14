Return-Path: <pedromfc@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4164s21y18zDrnp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 23:55:50 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5EDpGc7145574
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 09:55:47 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jkrx2b63b-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 09:55:47 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pedromfc@linux.vnet.ibm.com>;
 Thu, 14 Jun 2018 09:55:47 -0400
From: Pedro Franco de Carvalho <pedromfc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 2/5] powerpc: Flush checkpointed gpr state for 32-bit
 processes in ptrace
In-Reply-To: <87d0wvtolp.fsf@concordia.ellerman.id.au>
References: <20180607152534.29427-1-pedromfc@linux.vnet.ibm.com>
 <20180607152534.29427-3-pedromfc@linux.vnet.ibm.com>
 <87d0wvtolp.fsf@concordia.ellerman.id.au>
Date: Thu, 14 Jun 2018 10:55:41 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <874li5mq02.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Can you add a helper that does it and use that helper in these two
> functions. Then if you can send me another patch that converts all the
> other uses to use the new helper.

Yes, I'll do this.

Thanks!

--
Pedro
