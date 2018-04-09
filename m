Return-Path: <arbab@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Kjjx103RzDqhm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 07:14:44 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w39LEcKD025248
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Apr 2018 17:14:42 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h8aygdkvh-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Apr 2018 17:14:42 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.ibm.com>;
 Mon, 9 Apr 2018 17:14:41 -0400
Date: Mon, 9 Apr 2018 16:14:36 -0500
From: Reza Arbab <arbab@linux.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, rashmica.g@gmail.com
Subject: Re: [PATCH 1/2] powerpc/mm: Flush cache on memory hot(un)plug
References: <20180406052424.29841-1-bsingharora@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <20180406052424.29841-1-bsingharora@gmail.com>
Message-Id: <20180409211435.lfchiz7bm6wq5nyk@arbab-laptop.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 06, 2018 at 03:24:23PM +1000, Balbir Singh wrote:
>This patch adds support for flushing potentially dirty
>cache lines when memory is hot-plugged/hot-un-plugged.

Acked-by: Reza Arbab <arbab@linux.ibm.com>

-- 
Reza Arbab
