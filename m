Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMLd050nFzDrdr
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 13:59:16 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7S3x39c116888
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Aug 2016 23:59:13 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 253rc107g5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Aug 2016 23:59:13 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Sun, 28 Aug 2016 13:59:10 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0F4872CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 13:59:08 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7S3x7pQ58327228
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 13:59:07 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7S3x7RF017322
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 13:59:07 +1000
Subject: Re: [PATCH v3 0/5] kexec_file: Add buffer hand-over for the next
 kernel
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org,
 linux-security-module@vger.kernel.org,
 linux-ima-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Dave
 Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Baoquan He
 <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Stewart Smith
 <stewart@linux.vnet.ibm.com>, Eric Richter <erichte@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>
Date: Sat, 27 Aug 2016 23:59:00 -0400
In-Reply-To: <2766587.yalBJ6tfVf@hactar>
References: <1472149111-30598-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160825141243.e8a3f0f864b5d9dee496a1e4@linux-foundation.org>
 <2766587.yalBJ6tfVf@hactar>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1472356740.2640.37.camel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-08-25 at 19:17 -0300, Thiago Jung Bauermann wrote:
> Am Donnerstag, 25 August 2016, 14:12:43 schrieb Andrew Morton:
> > I grabbed these two patch series.  I also merged the "IMA:
> > Demonstration code for kexec buffer passing." demonstration patch just
> > to get things a bit of testing.
> 
> Thank you very much!

Thank you, Andrew.

> > I assume that once the "ima: carry the
> > measurement list across kexec" series has stabilised, I should drop the
> > demo patch and also grab those?  If so, pelase start cc'ing me.
> 
> I'm not sure how Mimi is planning to upstream that series.

I'll re-post the patches shortly, cc'ing you.  It will contain support
for saving the binary measurement list on one architecture (eg. little
endian) and restoring it on another (eg. big endian).

Mimi
