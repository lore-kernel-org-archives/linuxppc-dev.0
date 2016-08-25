Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKz7W0XYHzDqB7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 08:17:26 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7PM8cgp002333
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 18:17:24 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 251fpgckkc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 18:17:24 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 25 Aug 2016 19:17:22 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id DFC881DC006D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 18:17:08 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7PMHIQW4669694
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 19:17:18 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7PMHHgL014842
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 19:17:18 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-ima-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Eric Richter <erichte@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v3 0/5] kexec_file: Add buffer hand-over for the next
 kernel
Date: Thu, 25 Aug 2016 19:17:15 -0300
In-Reply-To: <20160825141243.e8a3f0f864b5d9dee496a1e4@linux-foundation.org>
References: <1472149111-30598-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160825141243.e8a3f0f864b5d9dee496a1e4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <2766587.yalBJ6tfVf@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Donnerstag, 25 August 2016, 14:12:43 schrieb Andrew Morton:
> I grabbed these two patch series.  I also merged the "IMA:
> Demonstration code for kexec buffer passing." demonstration patch just
> to get things a bit of testing.

Thank you very much!

> I assume that once the "ima: carry the
> measurement list across kexec" series has stabilised, I should drop the
> demo patch and also grab those?  If so, pelase start cc'ing me.

I'm not sure how Mimi is planning to upstream that series.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
