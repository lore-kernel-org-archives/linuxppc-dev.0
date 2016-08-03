Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4RLJ0gcqzDqgf
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 07:39:51 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u73LdAmP057058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Aug 2016 17:39:50 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24kkag5226-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Aug 2016 17:39:49 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Wed, 3 Aug 2016 18:39:47 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id D08931DC006D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 17:39:36 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u73LdjWc29032806
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Aug 2016 18:39:45 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u73LdjXt013113
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Aug 2016 18:39:45 -0300
Subject: Re: [PATCH] powerpc: convert 'iommu_alloc failed' messages to dynamic
 debug
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
References: <1465563831-6565-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1465686148.19533.28.camel@kernel.crashing.org>
 <575EB4DE.9080807@linux.vnet.ibm.com>
 <1465853216.3022.26.camel@kernel.crashing.org>
 <57A2486F.6000208@linux.vnet.ibm.com>
 <1470260080.12584.111.camel@kernel.crashing.org>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Wed, 3 Aug 2016 18:39:44 -0300
MIME-Version: 1.0
In-Reply-To: <1470260080.12584.111.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <57A264A0.6020302@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/03/2016 06:34 PM, Benjamin Herrenschmidt wrote:
> I think this is best done by the relevant community maintainer,
> I just threw an idea but I'm not that familiar with the details:-)

Ok, sure; got it.

> Did you send them to the lkml list ?

Yup, plus a few others lists from get_maintainer.pl iirc.

Mailing list archive links:
- linux-kernel: http://marc.info/?l=linux-kernel&m=146798084822100&w=2
- linux-doc: http://marc.info/?l=linux-doc&m=146798085522104&w=2
- linux-nvme: 
http://lists.infradead.org/pipermail/linux-nvme/2016-July/005349.html
- linuxppc-dev: 
https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-July/145624.html

Thanks,


-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
