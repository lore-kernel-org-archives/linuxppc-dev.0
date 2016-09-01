Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sQ4Ly5WwVzDrcD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Sep 2016 00:26:34 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u81ENM9U057822
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2016 10:26:32 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 256b4ebqgf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Sep 2016 10:26:32 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Thu, 1 Sep 2016 11:26:29 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id E2C4D1DC0051
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 10:26:16 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u81EQQDT4260040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2016 11:26:26 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u81EQQg2028664
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2016 11:26:26 -0300
Subject: Re: [PATCH] powerpc: add kernel parameter iommu_alloc_quiet
To: Torsten Duwe <duwe@lst.de>
References: <1472734602-14330-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <20160901133937.GA8644@lst.de>
Cc: jthumshirn@suse.com, linuxppc-dev@lists.ozlabs.org
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Thu, 1 Sep 2016 11:26:22 -0300
MIME-Version: 1.0
In-Reply-To: <20160901133937.GA8644@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <2098ad4f-a02f-d893-cf2f-c062e19f4dfd@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/01/2016 10:39 AM, Torsten Duwe wrote:
> JFYI, my strongly preferred solution would still be to just dev_dbg() the whole thing.
> Which group of people would be interested in these messages, after all?

Certainly understandable.

Ben didn't like the idea to convert the messages to dynamic debug [1],
(with which I agree/understand nowadays) and suggested us to look for
a different approach.

[1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-June/144196.html

-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
