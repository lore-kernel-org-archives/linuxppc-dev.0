Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3FGH5wCMzDvjR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 01:02:31 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9PE08Sf016990
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 10:02:29 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26a75dxnmx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 10:02:28 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 25 Oct 2016 08:02:27 -0600
Subject: Re: [PATCH] powerpc/pseries: fix spelling mistake: "Attemping" ->
 "Attempting"
To: Colin King <colin.king@canonical.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook
 <keescook@chromium.org>,
 Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20161024220212.8464-1-colin.king@canonical.com>
Cc: linux-kernel@vger.kernel.org
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Tue, 25 Oct 2016 09:02:20 -0500
MIME-Version: 1.0
In-Reply-To: <20161024220212.8464-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <3a78be5a-a913-da9f-7d3c-adce86207702@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/24/2016 05:02 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> trivial fix to spelling mistake in pr_debug message
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
>  arch/powerpc/platforms/pseries/hotplug-cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index a1b63e0..c8929cb 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -553,7 +553,7 @@ static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
>  {
>  	int rc;
> 
> -	pr_debug("Attemping to remove CPU %s, drc index: %x\n",
> +	pr_debug("Attempting to remove CPU %s, drc index: %x\n",
>  		 dn->name, drc_index);
> 
>  	rc = dlpar_offline_cpu(dn);
> 
