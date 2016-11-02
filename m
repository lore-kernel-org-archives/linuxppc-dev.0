Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8DWq3934zDvMv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 03:46:31 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA2Ghb0l132130
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 12:46:28 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26fkc0bupk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Nov 2016 12:46:28 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 2 Nov 2016 16:46:26 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id CA0371B08061
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 16:48:33 +0000 (GMT)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA2GkNZt42401844
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 16:46:23 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA2GkNsB018168
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 10:46:23 -0600
Received: from [9.164.149.107] (icon-9-164-149-107.megacenter.de.ibm.com
 [9.164.149.107])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 uA2GkNor018156
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 10:46:23 -0600
Subject: Re: [PATCH] cxl: Fix error handling
To: linuxppc-dev@lists.ozlabs.org
References: <20161030213451.24624-1-christophe.jaillet@wanadoo.fr>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 2 Nov 2016 17:46:23 +0100
MIME-Version: 1.0
In-Reply-To: <20161030213451.24624-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <73e209d9-ff1b-f313-b5b5-b4c1a864df4d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 30/10/2016 à 22:34, Christophe JAILLET a écrit :
> 'cxl_dev_context_init()' returns an error pointer in case of error, not
> NULL. So test it with IS_ERR.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
