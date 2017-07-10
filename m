Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5nrP1Dq6zDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 00:38:12 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6AEXdsw018738
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 10:38:10 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bmax69t3a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 10:38:10 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Tue, 11 Jul 2017 00:38:06 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6AEc3ZN23658750
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 00:38:03 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6AEc1h4016759
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 00:38:02 +1000
Subject: Re: Today's linux-next build fail on powerpc
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Wolfram Sang <wsa@the-dreams.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, Luis
 Oliveira <Luis.Oliveira@synopsys.com>, linux-next
 <linux-next@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 10 Jul 2017 20:07:58 +0530
In-Reply-To: <CAHp75VdfjatKMWXzHLr7s3CCAh_-Gd=a2K72pFDdtt1X9Kk7Rw@mail.gmail.com>
References: <1499320823.19784.17.camel@abdul.in.ibm.com>
 <CAHp75VdfjatKMWXzHLr7s3CCAh_-Gd=a2K72pFDdtt1X9Kk7Rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1499697478.19784.42.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-07-07 at 19:36 +0300, Andy Shevchenko wrote:
> On Thu, Jul 6, 2017 at 9:00 AM, Abdul Haleem
> <abdhalee@linux.vnet.ibm.com> wrote:
> > Hi Luis,
> >
> > next-20170705 fails to build on powerpc with below errors.
> 
> Hi,
> 
> I had sent a fix yesterday. Had you chance to test it?
> 
> 

Are these the one you are referring to ?

[v1,2/2] ACPI / boot: Don't define unused variables 
[v1,1/2] ACPI / boot: Correct address space of __acpi_map_table()

Applying above patches did not fix the build failure.

drivers/i2c/busses/i2c-designware-platdrv.c:331:6: error: implicit
declaration of function
‘i2c_detect_slave_mode’ [-Werror=implicit-function-declaration]
  if (i2c_detect_slave_mode(&pdev->dev))
      ^
  CC [M]  fs/jffs2/scan.o

Please point me to the correct patch you are referring to ?

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
