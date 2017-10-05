Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7MgL5w08zDrF8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 06:06:06 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v95J4FcD039505
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Oct 2017 15:06:04 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ddrnd6kck-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Oct 2017 15:06:03 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 5 Oct 2017 13:06:03 -0600
References: <427d4a01-e0ec-9a52-46cb-685c43962a96@users.sourceforge.net>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc/perf/hv-24x7: Delete an error message for a
 failed memory allocation in create_events_from_catalog()
In-reply-to: <427d4a01-e0ec-9a52-46cb-685c43962a96@users.sourceforge.net>
Date: Thu, 05 Oct 2017 16:05:53 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87mv555sa6.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Thanks, Markus.

SF Markus Elfring <elfring@users.sourceforge.net> writes:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 5 Oct 2017 18:02:05 +0200
>
> Omit an extra message for a memory allocation failure in this function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/powerpc/perf/hv-24x7.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
> index 9c88b82f6229..f21f30aaf9bd 100644
> --- a/arch/powerpc/perf/hv-24x7.c
> +++ b/arch/powerpc/perf/hv-24x7.c
> @@ -766,7 +766,6 @@ static int create_events_from_catalog(struct attribute ***events_,
>  	 */
>  	event_data = vmalloc(event_data_bytes);
>  	if (!event_data) {
> -		pr_err("could not allocate event data\n");
>  		ret = -ENOMEM;
>  		goto e_free;
>  	}

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> 

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
