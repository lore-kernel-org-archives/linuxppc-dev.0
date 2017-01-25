Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v7vtX670MzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 06:16:52 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0PJ9RZd150875
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 14:16:50 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 286rd60qhe-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 14:16:49 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 26 Jan 2017 05:16:46 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 514553578053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 06:16:45 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0PJGbPn35651686
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 06:16:45 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0PJGCDn022522
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 06:16:13 +1100
Subject: Re: [PATCH v4 2/5] ia64: reuse append_elf_note() and final_note()
 functions
To: Tony Luck <tony.luck@gmail.com>
References: <148363729327.11570.6244765717789390817.stgit@hbathini.in.ibm.com>
 <148363740554.11570.4870634597647436827.stgit@hbathini.in.ibm.com>
 <20170106020324.GB2863@dhcp-128-65.nay.redhat.com>
 <38a7807c-cd95-670d-30d3-c45e7921ea11@linux.vnet.ibm.com>
 <0748026f-a459-9022-3658-a75cb0633f40@linux.vnet.ibm.com>
 <CA+8MBb+g604VGLLibB+eOAtF_h1r5mYJRdjaGE8UgWQ+JPGDdg@mail.gmail.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Dave Young <dyoung@redhat.com>, kexec-ml <kexec@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 "vgoyal@redhat.com" <vgoyal@redhat.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Thu, 26 Jan 2017 00:45:52 +0530
MIME-Version: 1.0
In-Reply-To: <CA+8MBb+g604VGLLibB+eOAtF_h1r5mYJRdjaGE8UgWQ+JPGDdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <04b96f50-f77d-9446-975f-7d44accfe583@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 24 January 2017 11:53 PM, Tony Luck wrote:
> On Tue, Jan 24, 2017 at 10:11 AM, Hari Bathini
> <hbathini@linux.vnet.ibm.com> wrote:
>
>> Hello IA64 folks,
>>
>> Could you please review this patch..?
> It looks OK in principal.  My lab is in partial disarray at the
> moment (just got back from a sabbatical) so I can't test
> build and boot. Have you cross-compiled it (or gotten a success
> build report from zero-day)?

I haven't gotten a success/failure build report from zero-day. Not sure 
what to make of it.
But I did try cross-compiling and it was successful. Should that do?

Thanks
Hari


> If you have ... then add an Acked-by: Tony Luck <tony.luck@intel.com>
>
> -Tony
>
