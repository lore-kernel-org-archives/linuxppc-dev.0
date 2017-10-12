Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCNNP0P7vzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 18:52:04 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9C7iLUs056198
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 03:52:01 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dj31uc2pg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 03:52:01 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 12 Oct 2017 01:52:00 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, hemant@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/powernv: Add kernel cmdline parameter to disable
 imc
In-Reply-To: <06fe39eb-d5fe-4472-56b4-f66390d7fad9@linux.vnet.ibm.com>
References: <1507531597-25947-1-git-send-email-anju@linux.vnet.ibm.com>
 <87wp43wf2v.fsf@concordia.ellerman.id.au> <87infmeonf.fsf@linux.vnet.ibm.com>
 <06fe39eb-d5fe-4472-56b4-f66390d7fad9@linux.vnet.ibm.com>
Date: Thu, 12 Oct 2017 18:51:51 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <87sheoby7c.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
> On Wednesday 11 October 2017 01:55 AM, Stewart Smith wrote:
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>> Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
>>>
>>>> Add a kernel command line parameter option to disable In-Memory Collec=
tion
>>>> (IMC) counters and add documentation. This helps in debug.
>>> I'd really rather we didn't. Do we *really* need this?
>>>
>>> We don't have command line parameters to disable any of the other ~20
>>> PMUs, why is this one special?
>
> This one is really helpful in debugging, incase if we want to proceed=20
> without nest counters=C2=A0 OR
> core counters . But if we have the facility to do the same from=20
> petitboot, its fine.

https://patchwork.ozlabs.org/patch/824497/ (skiboot patch) should do the
same thing, right? That means we come up with them off (as we should
have from the start) and if you don't use the PMUs then the ucode won't
be started.

--=20
Stewart Smith
OPAL Architect, IBM.
