Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSHnZ6sQ0zDqjk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 03:09:54 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v79H3iuh145688
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Aug 2017 13:08:51 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c82vrxpry-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Aug 2017 13:08:51 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 9 Aug 2017 11:03:49 -0600
Subject: Re: [PATCH] ibmvnic: Fix unused variable warning
To: Michal Suchanek <msuchanek@suse.de>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20170809111602.12170-1-msuchanek@suse.de>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Wed, 9 Aug 2017 10:03:42 -0700
MIME-Version: 1.0
In-Reply-To: <20170809111602.12170-1-msuchanek@suse.de>
Content-Type: text/plain; charset=utf-8
Message-Id: <7872eab5-9af4-a622-990c-59bf92834c05@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/09/2017 04:16 AM, Michal Suchanek wrote:
> Fixes: a248878d7a1d ("ibmvnic: Check for transport event on driver resume")
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---

Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
