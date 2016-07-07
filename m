Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlcnm1zXmzDr2s
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 22:46:52 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u67CkjLl048515
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 08:46:49 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2415xna074-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jul 2016 08:46:49 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Thu, 7 Jul 2016 09:46:47 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id E759C352006C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 08:46:25 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u67Ckhe756426528
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 09:46:43 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u67Ckh12004641
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 09:46:43 -0300
Subject: Re: [PATCH 2/3] nvme: implement DMA_ATTR_NO_WARN
To: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
References: <1467839013-22481-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1467839013-22481-3-git-send-email-mauricfo@linux.vnet.ibm.com>
 <878txep9di.fsf@linux.vnet.ibm.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Thu, 7 Jul 2016 09:46:39 -0300
MIME-Version: 1.0
In-Reply-To: <878txep9di.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <577E4F2F.3090905@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/06/2016 09:41 PM, Gabriel Krisman Bertazi wrote:
> checkpatch.pl complains about line wrapping.  Other than that, this
> looks good to me.

I'll submit a v2 w/ that and typos fixed.
Thanks for reviewing.

-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
