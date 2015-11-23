Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2105D1A0384
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 22:33:03 +1100 (AEDT)
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43EC31401F0
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Nov 2015 22:33:02 +1100 (AEDT)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 23 Nov 2015 17:02:59 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 88A30394005C
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Nov 2015 17:02:55 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tANBWIUb48103510
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Nov 2015 17:02:19 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tANBWEpt032637
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Nov 2015 17:02:17 +0530
Message-ID: <5652F93C.2020109@linux.vnet.ibm.com>
Date: Mon, 23 Nov 2015 17:02:12 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au,
 benh@kernel.crashing.org
CC: linuxppc-dev@ozlabs.org, paulus@samba.org, sam.bobroff@au1.ibm.com
Subject: Re: [PATCH v2 2/3] selftests/powerpc: Add TM signal return test
References: <1447992934-18905-1-git-send-email-mikey@neuling.org>
 <1447992934-18905-3-git-send-email-mikey@neuling.org>
In-Reply-To: <1447992934-18905-3-git-send-email-mikey@neuling.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/20/2015 09:45 AM, Michael Neuling wrote:
> Test the kernel's signal return code to ensure that it doesn't crash
> when both the transactional and suspend MSR bits are set in the signal
> context.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Tested-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
