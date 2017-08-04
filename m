Return-Path: <srs0=y5bh=7g=au1.ibm.com=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xP6VG2bTCzDqk7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 23:00:38 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xP6VG1HxMz8vs6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 23:00:38 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xP6VF4B4bz9s65
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Aug 2017 23:00:37 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v74Cx4A9044468
 for <linuxppc-dev@ozlabs.org>; Fri, 4 Aug 2017 09:00:34 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c4r42w31y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 04 Aug 2017 09:00:33 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Fri, 4 Aug 2017 23:00:31 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v74D0S5027394160
 for <linuxppc-dev@ozlabs.org>; Fri, 4 Aug 2017 23:00:28 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v74D0J3i006158
 for <linuxppc-dev@ozlabs.org>; Fri, 4 Aug 2017 23:00:19 +1000
Subject: Re: 4.13-rc3: Unrecoverable exception 4100
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Andreas Schwab <schwab@linux-m68k.org>, linuxppc-dev@ozlabs.org
Date: Fri, 04 Aug 2017 23:00:27 +1000
In-Reply-To: <87vam3lhtn.fsf@linux-m68k.org>
References: <87vam3lhtn.fsf@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1501851627.2664.90.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-08-04 at 12:59 +0200, Andreas Schwab wrote:
> I'm getting a lot of Unrecoverable exception 4100 with 4.13-rc3:

Hi Andeas !

Any chance you can bisect this ?

Thanks !

Cheers,
Ben.
