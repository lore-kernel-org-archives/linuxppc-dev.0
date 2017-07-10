Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5t8B65fXzDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 03:52:10 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6AHmjnO137139
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 13:52:08 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bmc3fna6x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 13:52:08 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Tue, 11 Jul 2017 03:52:04 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6AHq29U19791926
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 03:52:02 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6AHprLx007469
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 03:51:53 +1000
Subject: Re: Today's linux-next build fail on powerpc
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Wolfram Sang <wsa@the-dreams.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, Luis
 Oliveira <Luis.Oliveira@synopsys.com>, linux-next
 <linux-next@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 10 Jul 2017 23:21:57 +0530
In-Reply-To: <CAHp75VdSgpviH9U1nh7HVL-t9kHHQeAdDSnAGjsXtFaXXTNnXQ@mail.gmail.com>
References: <1499320823.19784.17.camel@abdul.in.ibm.com>
 <CAHp75VdfjatKMWXzHLr7s3CCAh_-Gd=a2K72pFDdtt1X9Kk7Rw@mail.gmail.com>
 <1499697478.19784.42.camel@abdul.in.ibm.com>
 <CAHp75VdSgpviH9U1nh7HVL-t9kHHQeAdDSnAGjsXtFaXXTNnXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1499709117.19784.44.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-07-10 at 18:17 +0300, Andy Shevchenko wrote:
> On Mon, Jul 10, 2017 at 5:37 PM, Abdul Haleem
> <abdhalee@linux.vnet.ibm.com> wrote:
> > On Fri, 2017-07-07 at 19:36 +0300, Andy Shevchenko wrote:
> >> On Thu, Jul 6, 2017 at 9:00 AM, Abdul Haleem
> >> <abdhalee@linux.vnet.ibm.com> wrote:
> >> > next-20170705 fails to build on powerpc with below errors.
> >> I had sent a fix yesterday. Had you chance to test it?
> 
> > drivers/i2c/busses/i2c-designware-platdrv.c:331:6: error: implicit
> > declaration of function
> > ‘i2c_detect_slave_mode’ [-Werror=implicit-function-declaration]
> >   if (i2c_detect_slave_mode(&pdev->dev))
> >       ^
> >   CC [M]  fs/jffs2/scan.o
> >
> > Please point me to the correct patch you are referring to ?
> 
> commit 8f1a357d41a22009150cf404b5aa5876efdb59b1
> 
>    i2c: Provide a stub for i2c_detect_slave_mode()
> 

Thanks Andy for the fix, the patch fixes the build errors.

Machine booted with no issues.

Reported-and-tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
