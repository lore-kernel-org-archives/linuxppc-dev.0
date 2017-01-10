Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyJyh1DYDzDqN4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 15:32:11 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0A4SfV1092882
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jan 2017 23:32:09 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27vmy4xrfm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Jan 2017 23:32:09 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 10 Jan 2017 14:32:06 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C90963578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 15:32:04 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0A4W4sq3932426
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 15:32:04 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0A4W4Xb010249
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 15:32:04 +1100
Subject: Re: bootx_init.c:88: undefined reference to `__stack_chk_fail_local'
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Christian Kujau <lists@nerdbynature.de>, Christophe LEROY
 <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Mon, 09 Jan 2017 22:32:02 -0600
In-Reply-To: <alpine.DEB.2.20.999.1701091739320.5450@trent.utfs.org>
References: <alpine.DEB.2.20.99.1701030715390.31470@trent.utfs.org>
 <81ef821b-8af2-0ee5-ab35-58639548dab7@c-s.fr>
 <alpine.DEB.2.20.99.1701040957380.31470@trent.utfs.org>
 <alpine.DEB.2.20.999.1701091739320.5450@trent.utfs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1484022722.21117.8.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-01-09 at 18:11 -0800, Christian Kujau wrote:
> So, with -fno-stack-protector my GCC 4.9.2 compiles with 
> CC_STACKPROTECTOR_STRONG=y but panics during boot:

How can it make any sense to have -fno-stack-protector and
CC_STACKPROTECTOR_STRONG=y at the same time ?

Ben.
