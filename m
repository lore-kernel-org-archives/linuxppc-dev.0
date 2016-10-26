Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t42Gz0hL4zDt2y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 07:50:50 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9QKmXZn013927
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 16:50:48 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26b3dx94w8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 16:50:48 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Thu, 27 Oct 2016 06:50:44 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 40E162CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 07:50:41 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9QKof0O7340336
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 07:50:41 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9QKoe5s012766
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 07:50:41 +1100
Subject: Re: [bug report] [POWERPC] 4xx: Add 405GPr and 405EP support in
 boot wrapper
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: matthias.fuchs@esd-electronics.com, linuxppc-dev@lists.ozlabs.org
Date: Wed, 26 Oct 2016 15:50:39 -0500
In-Reply-To: <20161026190702.GS4418@mwanda>
References: <20161026130311.GA3080@elgon.mountain>
 <1477508243.2828.70.camel@au1.ibm.com> <20161026190702.GS4418@mwanda>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1477515039.2828.71.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-10-26 at 22:07 +0300, Dan Carpenter wrote:
> On Wed, Oct 26, 2016 at 01:57:23PM -0500, Benjamin Herrenschmidt
> wrote:
> > 
> > On Wed, 2016-10-26 at 16:03 +0300, Dan Carpenter wrote:
> > > 
> > >    565          cbdv = ((pllmr & 0x00060000) >> 17) + 1; /*
> > > CPU:PLB */
> > >    566          opdv = ((pllmr & 0x00018000) >> 15) + 1; /*
> > > PLB:OPB */
> > >    567          ppdv = ((pllmr & 0x00001800) >> 13) + 1; /*
> > > PLB:PCI */
> > >                                  ^^^^^^^^^^^^^^^^^
> > > This is zero.  It looks like 0x00000600 was probably intended?
> > 
> > I just checked the spec and for the 405gp and it's 0x6000 (bits 17
> > and
> > 18 in IBM ordering)
> > 
> 
> I'm on the road and there is no way I'm going to remember to do this
> when I get back...  Could you send the patch?

I'll try to remember when I'm out of meeting frenzy ;-)

Cheers,
Ben.
