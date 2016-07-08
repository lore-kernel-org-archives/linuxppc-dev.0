Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rmDHz47rNzDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 22:26:38 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u68COH0j117179
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jul 2016 08:26:35 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2415xqa6c7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Jul 2016 08:26:35 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Fri, 8 Jul 2016 09:26:33 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 5E4C8352006C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 08:26:13 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u68CQUf359113510
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jul 2016 09:26:30 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u68CQUY8013820
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jul 2016 09:26:30 -0300
Subject: Re: [PATCH v2 2/3] nvme: implement DMA_ATTR_NO_WARN
To: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
References: <1467895509-12194-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1467895509-12194-3-git-send-email-mauricfo@linux.vnet.ibm.com>
 <577F5C4A.8070004@jp.fujitsu.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Fri, 8 Jul 2016 09:26:25 -0300
MIME-Version: 1.0
In-Reply-To: <577F5C4A.8070004@jp.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <577F9BF1.8010807@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/08/2016 04:54 AM, Masayoshi Mizuma wrote:
> Here, I think the error messages should not be suppressed because
> the return value of nvme_map_data() is BLK_MQ_RQ_QUEUE_ERROR, so
> the IO returns as -EIO.

Agree; good point.  fixed in v3.

Thanks for reviewing.

-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
