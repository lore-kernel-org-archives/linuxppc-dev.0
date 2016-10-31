Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6ktH4KRRzDvRT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 17:27:18 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9V6IvrK071143
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 02:27:17 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26dsvb5vhv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 02:27:16 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 31 Oct 2016 16:27:14 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E5D0C2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 17:27:11 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9V6RBi866977948
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 17:27:11 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9V6RBLm020480
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 17:27:11 +1100
Subject: Re: [PATCH] cxl: Fix error handling
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, imunsie@au1.ibm.com,
 fbarrat@linux.vnet.ibm.com
References: <20161030213451.24624-1-christophe.jaillet@wanadoo.fr>
Cc: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 31 Oct 2016 17:27:10 +1100
MIME-Version: 1.0
In-Reply-To: <20161030213451.24624-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <e6e4eb09-28d1-ad7c-6ab3-8e954c27ed23@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 31/10/16 08:34, Christophe JAILLET wrote:
> 'cxl_dev_context_init()' returns an error pointer in case of error, not
> NULL. So test it with IS_ERR.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
> un-compiled because I don't have the required  cross build environment.

Builds fine here.

In future, you might want to bundle all 3 of your patches either into 1 
patch (while they are changes which can be done separately, it's all 
fixes to one type of problem in relation to one function, so personally 
I'm okay with that) or send it as a series, so that it's clear to 
everyone that they're all related fixes.

Additionally, having the same patch subject line for two patches sent in 
short succession is a bit confusing - in future, try and avoid that.


Andrew

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
