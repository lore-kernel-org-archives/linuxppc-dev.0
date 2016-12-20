Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjSLt2PQyzDwKV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 17:20:05 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBK6K1Z4007880
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 01:20:03 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27ew0tfwr2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 01:20:03 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 20 Dec 2016 16:19:42 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id EC44A2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 17:19:39 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBK6Jdm356295456
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 17:19:39 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBK6JdlD004796
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 17:19:39 +1100
Subject: Re: a question about powervm
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Liu ping fan <kernelfans@gmail.com>, Michal Suchanek <hramrach@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 20 Dec 2016 17:19:36 +1100
In-Reply-To: <CAFgQCTum4X2np+dV3-hkQ8MzvSwEEg-u7ZfCrZxDetdh9hOAgw@mail.gmail.com>
References: <CAFgQCTv4SmBdp91BNKiy6PzijLCzyYHFoezZeqBVbJPwCP=PkA@mail.gmail.com>
 <CAOMqctQJaLO_2_XhE7SGLyvQYvUEgxSNoussEiPvdpS2cDRc5w@mail.gmail.com>
 <CAFgQCTum4X2np+dV3-hkQ8MzvSwEEg-u7ZfCrZxDetdh9hOAgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1482214776.15937.39.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-12-20 at 11:30 +0800, Liu ping fan wrote:
> Thank you for the explanation. And sorry not to explain my question
> clearly.
> I wonders about the mapping between guest-CPU and physical cpu. On
> powerVM, except the feature exposed by host, it is 1:1 map right?

No, not necessarily.

Cheers,
Ben.
