Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 68A201A0163
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2015 18:56:06 +1000 (AEST)
Message-ID: <1440924965.907.1.camel@ellerman.id.au>
Subject: Re: [PATCH][RESEND] cxl: Set up and enable PSL Timebase
From: Michael Ellerman <mpe@ellerman.id.au>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>
Cc: imunsie@au1.ibm.com, mikey@neuling.org, linuxppc-dev@ozlabs.org
Date: Sun, 30 Aug 2015 18:56:05 +1000
In-Reply-To: <55E00FC0.5090906@linux.vnet.ibm.com>
References: <55E00FC0.5090906@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-08-28 at 09:37 +0200, Philippe Bergheaud wrote:
> This patch configures the PSL Timebase function and enables it,
> after the CAPP has been initialized by OPAL.
> 
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> ---
>   drivers/misc/cxl/cxl.h |  5 +++++
>   drivers/misc/cxl/pci.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index e7af256..19489c6 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -83,8 +83,10 @@ static const cxl_p1_reg_t CXL_PSL_AFUSEL  = {0x00B0};
>   /* 0x00C0:7EFF Implementation dependent area */
>   static const cxl_p1_reg_t CXL_PSL_FIR1      = {0x0100};
>   static const cxl_p1_reg_t CXL_PSL_FIR2      = {0x0108};
> +static const cxl_p1_reg_t CXL_PSL_Timebase  = {0x0110};
>   static const cxl_p1_reg_t CXL_PSL_VERSION   = {0x0118};
>   static const cxl_p1_reg_t CXL_PSL_RESLCKTO  = {0x0128};
> +static const cxl_p1_reg_t CXL_PSL_TB_CTLSTAT = {0x0140};
>   static const cxl_p1_reg_t CXL_PSL_FIR_CNTL  = {0x0148};
>   static const cxl_p1_reg_t CXL_PSL_DSNDCTL   = {0x0150};
>   static const cxl_p1_reg_t CXL_PSL_SNWRALLOC = {0x0158};


The whitespace here is all fubar, see the double spaces on the context lines.

I've fixed it up this time, but please try and fix your mailer, I think you're
using Thunderbird? :

  https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/email-clients.txt#n209

cheers
