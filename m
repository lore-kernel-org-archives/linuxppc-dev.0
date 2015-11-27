Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C50771A0B10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 16:40:46 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 27 Nov 2015 15:40:45 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BD1182BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 16:40:42 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAR5eHrQ28049540
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 16:40:25 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAR5e2UU028740
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 16:40:10 +1100
Message-ID: <5657EABD.9050705@au1.ibm.com>
Date: Fri, 27 Nov 2015 16:31:41 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/4] powerpc/powernv: Remove OPALv2 firmware define and
 references
References: <1448599526-31073-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1448599526-31073-3-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1448599526-31073-3-git-send-email-stewart@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27/11/15 15:45, Stewart Smith wrote:
> OPALv2 only ever existed in the lab and didn't escape to the world.
> All OPAL systems in the wild are OPALv3.
>
> The probability of there being an OPALv2 system still powered on
> anywhere inside IBM is approximately zero, let alone anyone
> expecting to run mainline kernels.
>
> So, start to remove references to OPALv2.
>
> Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>

Was going to comment that you should've removed the OPAL v1 line in 
cpuinfo, but it seems you do that in the next patch.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
