Return-Path: <stewart@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 147D11A0C54
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 07:10:37 +1000 (AEST)
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 254241401DD
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2015 07:10:35 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 9 Apr 2015 17:10:33 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id F046E38C8052
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2015 17:10:31 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t39LANwa25297080
 for <linuxppc-dev@ozlabs.org>; Thu, 9 Apr 2015 21:10:31 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t39L9w9r032268
 for <linuxppc-dev@ozlabs.org>; Thu, 9 Apr 2015 17:09:59 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc/powernv: display reason for Malfunction Alert
 HMI.
In-Reply-To: <20150409141305.6963.46929.stgit@mars>
References: <20150409141305.6963.46929.stgit@mars>
Date: Fri, 10 Apr 2015 07:09:39 +1000
Message-ID: <m37ftlvwj0.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
> The V2 version of HMI event now carries additional information for
> Malfunction Alert. It now contains error information about CORE and NX
> checkstop. This patch checks and displays the check stop reason before
> panic.
>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Acked in a the-api-is-present-in-firmware capacity.

Although patch should be against opal-api.h now rather than opal.h, so
that needs fixing before merging.

So,
Somewhat-Nearly-Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
