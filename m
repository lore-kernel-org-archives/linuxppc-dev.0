Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRQ0q0ZdKzDr4C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Nov 2017 08:46:50 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9VLhh7E122796
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 17:46:47 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dxuuq9r42-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 17:46:47 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Tue, 31 Oct 2017 17:46:47 -0400
Subject: Re: [PATCH] scsi: ibmvscsi: Convert timers to use timer_setup()
To: Kees Cook <keescook@chromium.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20171025100607.GA145026@beast>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Tue, 31 Oct 2017 14:46:40 -0700
MIME-Version: 1.0
In-Reply-To: <20171025100607.GA145026@beast>
Content-Type: text/plain; charset=utf-8
Message-Id: <8db42ced-307e-15f1-817a-5c4e76c5df58@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/25/2017 03:06 AM, Kees Cook wrote:
> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly.
> 
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
> Cc: linux-scsi@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/scsi/ibmvscsi/ibmvfc.c   | 14 ++++++--------
>  drivers/scsi/ibmvscsi/ibmvscsi.c |  7 +++----
>  2 files changed, 9 insertions(+), 12 deletions(-)

Acked-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
