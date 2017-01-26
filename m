Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8SSR3X90zDq62
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 03:44:39 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0QGiBJ3142315
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 11:44:37 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 287d7xurqe-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 11:44:36 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Thu, 26 Jan 2017 11:44:36 -0500
Subject: Re: [PATCH net 2/5] ibmvnic: Fix MTU settings
To: David Miller <davem@davemloft.net>
References: <1485378143-5084-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
 <1485378143-5084-2-git-send-email-tlfalcon@linux.vnet.ibm.com>
 <20170125.230504.215468934911959234.davem@davemloft.net>
Cc: netdev@vger.kernel.org, wvoigt@us.ibm.com, jallen@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Date: Thu, 26 Jan 2017 10:44:31 -0600
MIME-Version: 1.0
In-Reply-To: <20170125.230504.215468934911959234.davem@davemloft.net>
Content-Type: text/plain; charset=windows-1252
Message-Id: <783c7683-1cc2-6128-e19c-fd2c3c16cf4b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/25/2017 10:05 PM, David Miller wrote:
> From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
> Date: Wed, 25 Jan 2017 15:02:20 -0600
>
>> In the current driver, the MTU is set to the maximum value
>> capable for the backing device. This patch sets the MTU to the
>> default value for a Linux net device.
> Why are you doing this?
>
> What happens to users who depend upon the current behavior.
>
> They will break, and that isn't acceptable.
>
The current behavior was already broken.  We were seeing firmware errors when sending jumbo sized packets .  We plan to add proper support for jumbo sized packets as soon as possible.  
