Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405tyZ2r0vzF1qr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 02:29:13 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2LFQdCI102392
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 11:29:10 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gusvy0jkp-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 11:29:10 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 21 Mar 2018 15:29:09 -0000
Date: Wed, 21 Mar 2018 20:59:03 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 5/5] powerpc64/ftrace: Implement support for
 ftrace_regs_caller()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@ozlabs.org>, sathnaga@linux.vnet.ibm.com
References: <cover.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
 <764a63e7418b05185434fe660814ce762c93c7d0.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
 <20180321095912.212e0b0d@gandalf.local.home>
 <1521642624.97rikdhoqw.naveen@linux.ibm.com>
 <20180321112221.16cd9c3c@gandalf.local.home>
In-Reply-To: <20180321112221.16cd9c3c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1521646126.5jxja0sxh5.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Steven Rostedt wrote:
> On Wed, 21 Mar 2018 20:07:32 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> I think that will always be set here. ftrace_64_mprofile.S is only built=
=20
>> for -mprofile-kernel and we select HAVE_DYNAMIC_FTRACE_WITH_REGS if=20
>> MPROFILE_KERNEL is enabled. It looks like there is no way to unset just=20
>> CONFIG_DYNAMIC_FTRACE_WITH_REGS and so, for -mprofile-kernel, we can=20
>> assume it is always set?
>=20
> OK, if that's the case, then I'm fine with it.

Thanks for the review!

- Naveen

=
