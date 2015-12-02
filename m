Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 22A641A0286
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 15:41:34 +1100 (AEDT)
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 2 Dec 2015 10:11:31 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 2B3AE3940061
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 10:11:29 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB24fSoS63242302
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Dec 2015 10:11:28 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB24fRCX000948
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Dec 2015 10:11:28 +0530
Message-ID: <565E7677.6080407@linux.vnet.ibm.com>
Date: Wed, 02 Dec 2015 10:11:27 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, Rashmica Gupta <rashmicy@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] selftests/powerpc: Standardise TM calls
References: <1448946504-11653-1-git-send-email-rashmicy@gmail.com>
 <1448946504-11653-2-git-send-email-rashmicy@gmail.com>
 <565D5563.5000900@linux.vnet.ibm.com>
 <1449027654.11810.8.camel@ellerman.id.au>
In-Reply-To: <1449027654.11810.8.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/02/2015 09:10 AM, Michael Ellerman wrote:
> On Tue, 2015-12-01 at 13:38 +0530, Anshuman Khandual wrote:
>> > On 12/01/2015 10:38 AM, Rashmica Gupta wrote:
>>> > > Currently tbegin, tend etc are written as opcodes or asm instructions. So
>>> > > standardise these to asm instructions.
>> > 
>> > I think the asm instructions can be used with only newer versions of GCC.
>> > But not sure, does it work with the older gcc as well ?
> No they don't work with all versions of GCC.
> 
> The HTM instructions were added in 4.9 AFAICS, but also backported to 4.8. That
> seems old enough to me.
> 
> Also we have another test (tm-syscall) which is already using the tbegin
> instruction, and no one has complained, so I don't think anyone is trying to
> build the selftests with really old compilers.

Its only a concern if you try to build these self tests on some older distro.
But then some other self tests dont build there because of lack of newer
compiler options. Its generic problem not something specific to this test.
