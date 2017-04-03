Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxR4H0wNCzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Apr 2017 19:04:14 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3393ZDe068157
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Apr 2017 05:04:05 -0400
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29kdra237c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Apr 2017 05:04:05 -0400
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Mon, 3 Apr 2017 14:34:00 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3393wQn21037176
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Apr 2017 14:33:58 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3393udK006658
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Apr 2017 14:33:57 +0530
Subject: Re: [PowerPC][next-20170324][kselftest] kernel Oops when running
 tm/tm-signal-context-chk-vsx
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, Cyril Bur <cyrilbur@gmail.com>
Date: Mon, 03 Apr 2017 14:33:51 +0530
In-Reply-To: <1491209923.7788.9.camel@abdul.in.ibm.com>
References: <1490612559.8344.15.camel@abdul.in.ibm.com>
 <871sthbu12.fsf@concordia.ellerman.id.au>
 <1491209923.7788.9.camel@abdul.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1491210231.7788.12.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-04-03 at 14:28 +0530, Abdul Haleem wrote:
> On Tue, 2017-03-28 at 21:00 +1100, Michael Ellerman wrote:
> > Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:
> > 
> > > Hi,
> > >
> > > While running kernel self tests on ppc64, tm/tm-signal-context-chk-vsx
> > > tests fails with Oops message. 
> > >
> > > I was able to reproduce only twice out of 20 runs on next-20170324 only.
> > > so it is difficult to bisect the commit causing the issue.
> > 
> > Can you try mainline as of this commit:
> > 
> > 605df8d674ac ("selftests/powerpc: Replace stxvx and lxvx with stxvd2x/lxvd2x")
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?id=605df8d674ac65e044a0bf4998b28c2f350b7f9e
> > 
> > cheers
> > 
> 
> 
> Trace is not reproducible on mainline with above commit.
> 
> Cyril was able to reproduce it and is working on it.
> 
> 
> 
> 
cc Cyril Bur <cyrilbur@gmail.com>

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
