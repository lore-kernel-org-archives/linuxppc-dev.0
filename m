Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xk0VX0q61zDqgx
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 10:29:23 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v810Svn1059163
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 20:29:21 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cpnp0vx6d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 20:29:20 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 31 Aug 2017 18:29:20 -0600
Subject: Re: [PATCH 19/31] timer: Remove open-coded casts for .data and
 .function
To: Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Samuel Ortiz <samuel@sortiz.org>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 netdev@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1504222183-61202-1-git-send-email-keescook@chromium.org>
 <1504222183-61202-20-git-send-email-keescook@chromium.org>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Thu, 31 Aug 2017 17:29:13 -0700
MIME-Version: 1.0
In-Reply-To: <1504222183-61202-20-git-send-email-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <35df171b-7a0c-d4bc-b90d-254283232e72@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/31/2017 04:29 PM, Kees Cook wrote:
> This standardizes the callback and data prototypes in several places that
> perform casting, in an effort to remove more open-coded .data and
> .function uses in favor of setup_timer().
> 
> Cc: Samuel Ortiz <samuel@sortiz.org>
> Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-scsi@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/net/irda/bfin_sir.c      |  5 +++--
>  drivers/scsi/ibmvscsi/ibmvfc.c   | 14 ++++++--------
>  drivers/scsi/ibmvscsi/ibmvscsi.c |  8 ++++----
>  3 files changed, 13 insertions(+), 14 deletions(-)

Resending from correct email address.

For ibmvfc & ibmvscsi portions:

Acked-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
