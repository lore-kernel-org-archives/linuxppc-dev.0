Return-Path: <srs0=ytve=2p=au1.ibm.com=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcGqF3fXVzDqKn
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 21:53:29 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vcGqF37XQz8tDD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 21:53:29 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vcGqD6PlMz9sNC
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Mar 2017 21:53:28 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v26AnFuL093368
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Mar 2017 05:53:23 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28ytn385eb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 06 Mar 2017 05:53:22 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Mon, 6 Mar 2017 20:53:19 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 948B42BB0059
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Mar 2017 21:53:18 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v26ArAuT37355638
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Mar 2017 21:53:18 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v26AqjxR023669
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Mar 2017 21:52:46 +1100
Subject: Re: [PATCH v3] powerpc/xics: Work around limitations of OPAL XICS
 priority handling
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Michael Ellerman <mpe@ellerman.id.au>, bsingharora@gmail.com
Cc: linuxppc-dev@ozlabs.org
Date: Mon, 06 Mar 2017 21:52:21 +1100
In-Reply-To: <87innmpx0z.fsf@concordia.ellerman.id.au>
References: <1488629006-17180-1-git-send-email-mpe@ellerman.id.au>
 <1488755402.2870.118.camel@au1.ibm.com>
 <87innmpx0z.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1488797541.2870.127.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-03-06 at 20:36 +1100, Michael Ellerman wrote:
> > According to the HW guys, that should be 5ms in case the powerbus
> > is
> > really really busy.
> 
> Is that a metric or imperial "really really" ?  :D

No idea ;-) Could be the amount of time after which their own timeouts
kick in.

> I'll fold in a change to 5ms, and rebase because it's going to
> stable.

Cheers,
Ben.
