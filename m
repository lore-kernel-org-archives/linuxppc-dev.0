Return-Path: <pc@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNv4f3dngzDqNB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 23:25:54 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4BDIb1a090180
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 09:25:52 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ackdwhjtk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 09:25:51 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pc@us.ibm.com>;
 Thu, 11 May 2017 07:25:49 -0600
Reply-To: pc@us.ibm.com
Subject: Re: [PATCH] powerpc/64s: dt_cpu_ftrs boot time setup option
References: <20170511112441.30287-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Paul Clarke <pc@us.ibm.com>
Date: Thu, 11 May 2017 08:25:44 -0500
MIME-Version: 1.0
In-Reply-To: <20170511112441.30287-1-npiggin@gmail.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <9b214f48-9d56-440c-f6d0-6308ff47305d@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/11/2017 06:24 AM, Nicholas Piggin wrote:
> Provide a dt_cpu_ftrs= cmdline option to disable the dt_cpu_ftrs CPU
> feature discovery, and fall back to the "cputable" based version.

This boat has already sailed, I think, but "ftrs"?  Was it too difficult to type "features"?  This seems like something that should be easy and intuitive to find and understand.

:-)

PC
