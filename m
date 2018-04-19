Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40RVBs5NNKzF222
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 16:56:21 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3J6oXXR028393
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 02:56:19 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hen26b1qc-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 02:56:18 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 19 Apr 2018 07:56:16 +0100
Date: Thu, 19 Apr 2018 12:26:10 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc64s: Print exception vector name alongside the
 trap number
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
References: <20180418090205.30844-1-naveen.n.rao@linux.vnet.ibm.com>
 <1524093296.11062.358.camel@kernel.crashing.org>
In-Reply-To: <1524093296.11062.358.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1524120733.j6godr67ze.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2018-04-18 at 14:32 +0530, Naveen N. Rao wrote:
>>=20
>> +#ifdef CONFIG_PPC_BOOK3S_64
>> +static char *print_trap(unsigned long trapno)
>> +{
>> +	trapno &=3D 0xff0;
>> +	switch (trapno) {
>> +		case 0x100:	return "SRESET";
>> +		case 0x200:	return "MCE";
>> +		case 0x300:	return "DSI";
>> +		case 0x380:	return "DSISLB";
>> +		case 0x400:	return "ISI";
>> +		case 0x480:	return "ISISLB";
>=20
> 380 and 480 should probably be "DSEG" and "ISEG" ... they may or may
> not involve the SLB.

Ok, thanks for the review.

- Naveen

=
