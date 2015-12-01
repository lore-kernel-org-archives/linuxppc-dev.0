Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 79F921A017D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 19:08:38 +1100 (AEDT)
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 1 Dec 2015 13:38:35 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 627A8125801E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 13:38:51 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB1886q911075808
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 13:38:08 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB18857G008871
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 13:38:06 +0530
Message-ID: <565D5563.5000900@linux.vnet.ibm.com>
Date: Tue, 01 Dec 2015 13:38:03 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] selftests/powerpc: Standardise TM calls
References: <1448946504-11653-1-git-send-email-rashmicy@gmail.com>
 <1448946504-11653-2-git-send-email-rashmicy@gmail.com>
In-Reply-To: <1448946504-11653-2-git-send-email-rashmicy@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/01/2015 10:38 AM, Rashmica Gupta wrote:
> Currently tbegin, tend etc are written as opcodes or asm instructions. So
> standardise these to asm instructions.

I think the asm instructions can be used with only newer versions of GCC.
But not sure, does it work with the older gcc as well ?
