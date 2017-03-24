Return-Path: <srs0=h86y=3b=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vq9PD2klJzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 15:27:12 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vq9PD24D9z8t7F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 15:27:12 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vq9PC5sZKz9s7s
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2017 15:27:11 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2O4NmVo027254
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2017 00:27:09 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29cm3tmst9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2017 00:27:09 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 23 Mar 2017 22:27:08 -0600
Date: Thu, 23 Mar 2017 21:26:55 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Neuling <michael.neuling@au1.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, stewart@linux.vnet.ibm.com,
 linuxppc-dev@ozlabs.org, apopple@au1.ibm.com, oohall@gmail.com
Subject: Re: [PATCH v3 03/10] VAS: Define vas_init() and vas_exit()
References: <1489721642-5657-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1489721642-5657-4-git-send-email-sukadev@linux.vnet.ibm.com>
 <1490328509.28113.55.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1490328509.28113.55.camel@au1.ibm.com>
Message-Id: <20170324042655.GA8330@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling [michael.neuling@au1.ibm.com] wrote:
> On Thu, 2017-03-16 at 20:33 -0700, Sukadev Bhattiprolu wrote:
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3673,8 +3673,6 @@ F:=A0=A0=A0=A0=A0=A0=A0=A0arch/powerpc/platforms/=
powernv/pci-cxl.c
> > =A0F:=A0=A0=A0=A0=A0drivers/misc/cxl/
> > =A0F:=A0=A0=A0=A0=A0include/misc/cxl*
> > =A0F:=A0=A0=A0=A0=A0include/uapi/misc/cxl.h
> > -F:=A0=A0=A0=A0=A0Documentation/powerpc/cxl.txt
> > -F:=A0=A0=A0=A0=A0Documentation/ABI/testing/sysfs-class-cxl
> >=20
>=20
> This shouldn't be deleted.

Yes, I will fix it.

Thanks

Sukadev
>=20
> Mikey
