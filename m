Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJz1n5vyGzDrVT
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 05:10:05 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6SJ9vtT105824
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 15:10:03 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c0648hcdk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 15:10:02 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 28 Jul 2017 15:10:01 -0400
Date: Fri, 28 Jul 2017 12:09:56 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dzickus@redhat.com,
 sfr@canb.auug.org.au, linuxarm@huawei.com,
 Nicholas Piggin <npiggin@gmail.com>, abdhalee@linux.vnet.ibm.com,
 sparclinux@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
Reply-To: paulmck@linux.vnet.ibm.com
References: <20170727014214.GH3730@linux.vnet.ibm.com>
 <20170727143400.23e4d2b2@roar.ozlabs.ibm.com>
 <20170727124913.GL3730@linux.vnet.ibm.com>
 <20170727144903.000022a1@huawei.com>
 <20170727173923.000001b2@huawei.com>
 <20170727165245.GD3730@linux.vnet.ibm.com>
 <20170728084411.00001ddb@huawei.com>
 <20170728125416.j7gcgvnxgv2gq73u@tardis>
 <20170728145530.GE3730@linux.vnet.ibm.com>
 <20170728184129.GA24364@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170728184129.GA24364@linux.vnet.ibm.com>
Message-Id: <20170728190956.GA26640@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 28, 2017 at 11:41:29AM -0700, Paul E. McKenney wrote:
> On Fri, Jul 28, 2017 at 07:55:30AM -0700, Paul E. McKenney wrote:
> > On Fri, Jul 28, 2017 at 08:54:16PM +0800, Boqun Feng wrote:

[ . . . ]

> > Even though Jonathan's testing indicates that it didn't fix this
> > particular problem:
> > 
> > Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> And while we are at it:
> 
> Tested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

Not because it it fixed the TREE01 issue -- it did not.  But as near
as I can see, it didn't cause any additional issues.

							Thanx, Paul
