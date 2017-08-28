Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xh0t35q4WzDqCY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 04:39:23 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7SIagIB023543
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 14:39:21 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cmp7ngkga-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 14:39:21 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 28 Aug 2017 12:39:20 -0600
Subject: Re: [PATCH] tty: hvcs: make ktermios const
To: Bhumika Goyal <bhumirks@gmail.com>, julia.lawall@lip6.fr,
 gregkh@linuxfoundation.org, jslaby@suse.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1503945031-28202-1-git-send-email-bhumirks@gmail.com>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 11:39:15 -0700
MIME-Version: 1.0
In-Reply-To: <1503945031-28202-1-git-send-email-bhumirks@gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <b64bc118-7664-f34f-f47d-519f7b38fbd0@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/28/2017 11:30 AM, Bhumika Goyal wrote:
> Make this const as it is not modified anywhere.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
