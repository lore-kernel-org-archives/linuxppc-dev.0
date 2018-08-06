Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41kK544zF6zF2DY
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2018 10:58:00 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w760sgwQ124506
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Aug 2018 20:57:58 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kpb8b1hhb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Aug 2018 20:57:57 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 6 Aug 2018 01:57:56 +0100
Subject: Re: [PATCH] misc: cxl: changed asterisk position
To: Parth Y Shah <sparth1292@gmail.com>, fbarrat@linux.vnet.ibm.com,
 arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1533291638-22224-1-git-send-email-sparth1292@gmail.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 6 Aug 2018 10:57:50 +1000
MIME-Version: 1.0
In-Reply-To: <1533291638-22224-1-git-send-email-sparth1292@gmail.com>
Message-Id: <bd46a5cf-1027-e6c3-4840-e638aaa547ef@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/08/18 20:20, Parth Y Shah wrote:
> Resolved <"foo* bar" should be "foo *bar"> error
> 
> Signed-off-by: Parth Y Shah <sparth1292@gmail.com>

Thanks for picking this up.

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   drivers/misc/cxl/fault.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
> index 70dbb6d..d45f3e6 100644
> --- a/drivers/misc/cxl/fault.c
> +++ b/drivers/misc/cxl/fault.c
> @@ -33,7 +33,7 @@ static bool sste_matches(struct cxl_sste *sste, struct copro_slb *slb)
>    * This finds a free SSTE for the given SLB, or returns NULL if it's already in
>    * the segment table.
>    */
> -static struct cxl_sste* find_free_sste(struct cxl_context *ctx,
> +static struct cxl_sste *find_free_sste(struct cxl_context *ctx,
>   				       struct copro_slb *slb)
>   {
>   	struct cxl_sste *primary, *sste, *ret = NULL;
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
