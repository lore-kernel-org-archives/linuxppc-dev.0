Return-Path: <chandan@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD5541A0C98
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 15:10:22 +1100 (AEDT)
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <chandan@linux.vnet.ibm.com>;
 Thu, 14 Jan 2016 09:40:19 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0E4AHMM41680930
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 09:40:17 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0E4AGVH028718
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 09:40:16 +0530
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, chandan@mykolab.com
Subject: Re: [PATCH] powerpc: Wire up copy_file_range() syscall
Date: Thu, 14 Jan 2016 09:40:12 +0530
Message-ID: <13991128.X3BmdRKRSb@localhost.localdomain>
In-Reply-To: <1452725611.14028.0.camel@ellerman.id.au>
References: <1452703822-29844-1-git-send-email-chandan@linux.vnet.ibm.com>
 <1452725611.14028.0.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 14 Jan 2016 09:53:31 Michael Ellerman wrote:
> On Wed, 2016-01-13 at 22:20 +0530, Chandan Rajendra wrote:
> > Test runs on a ppc64 BE guest succeeded.
> 
> Were the tests built 64-bit or 32-bit?
> 

The test tool (xfs_io to be precise) was built as a 64-bit binary.

-- 
chandan
