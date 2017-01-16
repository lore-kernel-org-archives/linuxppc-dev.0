Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v2TJD6C6TzDqMg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 10:01:48 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0GMwnBe128124
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 18:01:46 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2813rsypq4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 18:01:46 -0500
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 17 Jan 2017 04:31:42 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 9094C394005C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 04:31:39 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0GN0nSe28377244
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 04:30:49 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0GN1cDA013749
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 04:31:38 +0530
Date: Tue, 17 Jan 2017 10:01:35 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Normal service will resume shortly ...
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <87pojncpt6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87pojncpt6.fsf@concordia.ellerman.id.au>
Message-Id: <20170116230135.GA11961@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 16, 2017 at 08:33:09PM +1100, Michael Ellerman wrote:
>Hi folks,
>
>I'm back from paternity leave, and will start processing patches in the
>next day or two.
>
>If you've sent a fix that should go into 4.10 that hasn't been merged
>yet, please feel free to reply to this message giving me a pointer to
>it.
>

Michael, welcome back! Please take a look on below one and merge to
4.10 if possible, thanks!

https://patchwork.ozlabs.org/patch/711604/  ... which reads as
"powerpc/eeh: Enable IO path on permanent error"

Thanks,
Gavin
