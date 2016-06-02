Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (unknown [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rL2Vk3CM1zDqcV
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 19:49:02 +1000 (AEST)
Received: from pps.filterd (m0048827.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u529fPI4042250
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jun 2016 05:48:50 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23a469d3ju-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jun 2016 05:48:50 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Thu, 2 Jun 2016 19:48:47 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1CCC12BB0063
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 19:48:35 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u529mOCS2228716
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jun 2016 19:48:29 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u529mNQW008878
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jun 2016 19:48:24 +1000
Date: Thu, 02 Jun 2016 17:47:47 +0800
From: xinhui <xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>
CC: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, mingo@redhat.com,
 paulmck@linux.vnet.ibm.com, waiman.long@hpe.com
Subject: Re: [PATCH v5 0/6] powerPC/pSeries use pv-qpsinlock as the default
 spinlock implemention
References: <1464859590-5292-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160602093350.GY3190@twins.programming.kicks-ass.net>
In-Reply-To: <20160602093350.GY3190@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <575000C3.2020708@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 2016年06月02日 17:33, Peter Zijlstra wrote:
>
>
> I'm thinking one copy a day is quite enough...
>
sorry for noise.
In recent days, our smtp server has some bugs that mails' Message-Id is changed by accident.
So I resend them just for sure.
sorry again...
