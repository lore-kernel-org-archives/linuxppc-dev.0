Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7h5k1H16zDqC2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 11:26:01 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3K1IkhQ096685
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 21:25:49 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29x6x1rx6p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 21:25:48 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 20 Apr 2017 11:25:46 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3K1PaSo37879866
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 11:25:44 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3K1PBma021025
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 11:25:11 +1000
Date: Thu, 20 Apr 2017 11:24:47 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru
Subject: Re: [PATCH v3 2/2] powerpc/eeh: Clean up and document event handling
 functions
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20170419073927.29224-1-ruscur@russell.cc>
 <20170419073927.29224-2-ruscur@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170419073927.29224-2-ruscur@russell.cc>
Message-Id: <20170420012447.GA31771@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 19, 2017 at 05:39:27PM +1000, Russell Currey wrote:
>Remove unnecessary tags in eeh_handle_normal_event(), and add function
>comments for eeh_handle_normal_event() and eeh_handle_special_event().
>
>The only functional difference is that in the case of a PE reaching the
>maximum number of failures, rather than one message telling you of this
>and suggesting you reseat the device, there are two separate messages.
>
>Suggested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>Signed-off-by: Russell Currey <ruscur@russell.cc>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
