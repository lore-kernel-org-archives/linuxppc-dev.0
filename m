Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJql73JjFzDvnb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 03:41:07 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAGGdS3r013614
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 11:41:04 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26qxsd25g3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 11:41:04 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Wed, 16 Nov 2016 09:41:03 -0700
Date: Wed, 16 Nov 2016 10:40:57 -0600
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: mpe@ellerman.id.au, hannes@cmpxchg.org, mhocko@kernel.org,
 vdavydov.dev@gmail.com, Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RESEND] [PATCH v1 3/3] powerpc: fix node_possible_map limitations
References: <1479253501-26261-1-git-send-email-bsingharora@gmail.com>
 <1479253501-26261-4-git-send-email-bsingharora@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <1479253501-26261-4-git-send-email-bsingharora@gmail.com>
Message-Id: <20161116164057.mzlhfigsuwn53r72@arbab-laptop.austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 16, 2016 at 10:45:01AM +1100, Balbir Singh wrote:
>Reverts: commit 3af229f2071f
>("powerpc/numa: Reset node_possible_map to only node_online_map")

Nice! With this limitation going away, I have a small patch to enable 
onlining new nodes via memory hotplug. Incoming.

-- 
Reza Arbab
