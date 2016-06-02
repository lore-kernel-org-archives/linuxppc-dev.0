Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLLQM5GL7zDqmF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 07:46:19 +1000 (AEST)
Received: from pps.filterd (m0048827.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u52LjoiN013104
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jun 2016 17:46:17 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23ak3g9xww-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jun 2016 17:46:17 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Fri, 3 Jun 2016 07:46:14 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A291B2BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 07:46:11 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u52LkB4c4653550
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jun 2016 07:46:11 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u52LkBlF008022
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jun 2016 07:46:11 +1000
Subject: Re: [PATCH 2/2] KVM: PPC: hypervisor large decrementer support
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Michael Neuling <mikey@neuling.org>, "Oliver O'Halloran"
 <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@samba.org>
Date: Fri, 03 Jun 2016 07:46:07 +1000
In-Reply-To: <1464762233.30958.135.camel@neuling.org>
References: <1464675936.30958.22.camel@neuling.org>
 <1464679016-10347-1-git-send-email-oohall@gmail.com>
 <1464679016-10347-2-git-send-email-oohall@gmail.com>
 <1464762233.30958.135.camel@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1464903967.3078.316.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-06-01 at 16:23 +1000, Michael Neuling wrote:
> FWIW you can use:
>         andis. reg,reg,(LPCR_LD)@ha

@h in that case. Probably the same result but technically @ha is for
arithmetic operations.

Cheers,
Ben.
