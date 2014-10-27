Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 243D51A0054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 17:20:17 +1100 (AEDT)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EBB34140082
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2014 17:20:15 +1100 (AEDT)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 27 Oct 2014 11:50:12 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id DD623125804F
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2014 11:50:00 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9R6Kdj521495824
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2014 11:50:39 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9R6K2bZ013783
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2014 11:50:06 +0530
Message-ID: <544DE410.8090009@linux.vnet.ibm.com>
Date: Mon, 27 Oct 2014 11:50:00 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V3] powerpc, xmon: Enable HW instruction breakpoint on
 POWER8
References: <1412855321-21276-1-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1412855321-21276-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Michael Ellerman <michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/09/2014 05:18 PM, Anshuman Khandual wrote:
> This patch enables support for hardware instruction breakpoints
> on POWER8 with the help of a new register CIABR (Completed
> Instruction Address Breakpoint Register). With this patch, single
> hardware instruction breakpoint can be added and cleared during
> any active xmon debug session. This hardware based instruction
> breakpoint mechanism works correctly along with the existing TRAP
> based instruction breakpoints available on xmon.

Hey Michael,

Any updates on this patch ?
