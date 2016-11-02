Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8DdB0TN4zDrL1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 03:51:09 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA2Gmwap147339
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 12:51:07 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26fkc0c9hc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Nov 2016 12:51:07 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 2 Nov 2016 16:51:02 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1F0F01B08069
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 16:52:52 +0000 (GMT)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA2Gog9215991188
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 16:50:42 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA2GofUN011074
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 12:50:42 -0400
Subject: Re: [PATCH] cxl: Fix error handling
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, imunsie@au1.ibm.com
References: <20161030214047.25037-1-christophe.jaillet@wanadoo.fr>
Cc: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 2 Nov 2016 17:50:40 +0100
MIME-Version: 1.0
In-Reply-To: <20161030214047.25037-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <dc935793-1726-7066-88b4-83c394099f7f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 30/10/2016 à 22:40, Christophe JAILLET a écrit :
> 'cxl_dev_context_init()' returns an error pointer in case of error, not
> NULL. So test it with IS_ERR.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---


Thanks for the 3 patches!

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
