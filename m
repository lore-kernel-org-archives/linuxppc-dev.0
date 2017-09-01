Return-Path: <turtle.in.the.kernel@gmail.com>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xk0T84tpJzDqgB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 10:28:12 +1000 (AEST)
Received: by mail-qk0-x241.google.com with SMTP id a77so910913qkb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 17:28:12 -0700 (PDT)
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
From: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
Message-ID: <571a97d3-97ed-e86f-71c8-afdc5237d244@gmail.com>
Date: Thu, 31 Aug 2017 17:28:07 -0700
MIME-Version: 1.0
In-Reply-To: <1504222183-61202-20-git-send-email-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
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
For ibmvfc & ibmvscsi portions:

Acked-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
