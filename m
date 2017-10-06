Return-Path: <gromero@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7nL72fM1zDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 22:22:39 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v96BLgNc042436
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Oct 2017 07:22:37 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2de75h5dwr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Oct 2017 07:22:36 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gromero@linux.vnet.ibm.com>;
 Fri, 6 Oct 2017 07:22:35 -0400
Subject: Re: [PATCH 2/3] powerpc/tm: P9 disabled suspend mode workaround
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20171006074643.25269-1-cyrilbur@gmail.com>
 <20171006074643.25269-2-cyrilbur@gmail.com>
Cc: mikey@neuling.org
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
Date: Fri, 6 Oct 2017 08:22:30 -0300
MIME-Version: 1.0
In-Reply-To: <20171006074643.25269-2-cyrilbur@gmail.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <59D76776.60207@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Cyril,

On 06-10-2017 04:46, Cyril Bur wrote:
> [added by Cyril Bur]
> As the no-suspend firmware change is novel and untested using it should
> be opt in by users. Furthumore, currently the kernel has no method to

I forgot to mention on my last reply, but should s/Furthumore/Furthermore/ ?

Regards,
Gustavo
