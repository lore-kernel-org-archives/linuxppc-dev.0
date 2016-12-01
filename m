Return-Path: <zohar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTfTK4D3KzDwN5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 12:14:45 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tTfTK0Gz8z9t1P
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Dec 2016 12:14:44 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB11EM43034882
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2016 20:14:42 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 272347k4y0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2016 20:14:42 -0500
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 1 Dec 2016 06:44:39 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 18F771258026
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Dec 2016 06:45:41 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB11E3X627918494
 for <linuxppc-dev@ozlabs.org>; Thu, 1 Dec 2016 06:44:03 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB11EY7t002072
 for <linuxppc-dev@ozlabs.org>; Thu, 1 Dec 2016 06:44:36 +0530
Subject: Re: [PATCH v11 0/8] powerpc: Implement kexec_file_load()
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, dyoung@redhat.com,
 stewart@linux.vnet.ibm.com, bauerman@linux.vnet.ibm.com
Date: Wed, 30 Nov 2016 20:14:31 -0500
In-Reply-To: <1480511026.18110.102.camel@linux.vnet.ibm.com>
References: <1480423554-6411-1-git-send-email-mpe@ellerman.id.au>
 <20161129134518.7ddc9b733b65b5eed94acd3e@linux-foundation.org>
 <87inr5po0n.fsf@concordia.ellerman.id.au>
 <1480511026.18110.102.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1480554871.24704.7.camel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-11-30 at 08:03 -0500, Mimi Zohar wrote:
> On Wed, 2016-11-30 at 15:52 +1100, Michael Ellerman wrote:

> Thaigo tested the patches yesterday.   Everything seemed fine.  After
> cherry picking the kexec_file_load() patches and rebasing the
> restore_kexec patches on top of it in my tree, there were some problems.
> Perhaps there is some dependencies that I'm missing.

There was one last change based on Dmitry Kasatkin's review, that I
implemented incorrectly which caused the failure.  It's now fixed.
Sorry for the delay ...

Mimi
