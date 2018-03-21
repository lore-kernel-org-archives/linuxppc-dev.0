Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405zs61tmbzF1qr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 06:10:17 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2LJ6Xb1014749
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 15:10:12 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2guw2hrrn5-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 15:10:12 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 21 Mar 2018 19:10:10 -0000
Date: Thu, 22 Mar 2018 00:40:05 +0530
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
 <1521646126.5jxja0sxh5.naveen@linux.ibm.com>
 <20180321113142.7291ded1@gandalf.local.home>
In-Reply-To: <20180321113142.7291ded1@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1521659240.f7qx4q0lp4.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Steven Rostedt wrote:
> On Wed, 21 Mar 2018 20:59:03 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> Thanks for the review!
>=20
> You're welcome. Note, I did put "Acked-by" and not "Reviewed-by"
> because my "Reviewed-by" is usually a bit more thorough than what I did
> for your patches. That's because it's been a while since I have worked
> on PPC and don't feel comfortable adding "Reviewed-by" for PPC code. :-/

Sure, I understand. As long as the rest of the changes look fine, that's=20
good. Michael Ellerman wrote the -mprofile-kernel ftrace_caller()=20
implementation, so I'll look forward to his review of that part.

- Naveen

=
