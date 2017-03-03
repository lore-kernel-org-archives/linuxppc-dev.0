Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZ9g34QVFzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 11:54:07 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id 67so3802386pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Mar 2017 16:54:07 -0800 (PST)
Subject: Re: [PATCH kernel] powerpc/powernv: Fix clobbered MSR
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
References: <20170302064124.26342-1-aik@ozlabs.ru>
 <1488490657.2870.74.camel@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <7e80e311-e7bf-8cf7-8750-96541d5b8dcc@ozlabs.ru>
Date: Fri, 3 Mar 2017 11:54:00 +1100
MIME-Version: 1.0
In-Reply-To: <1488490657.2870.74.camel@kernel.crashing.org>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/03/17 08:37, Benjamin Herrenschmidt wrote:
> On Thu, 2017-03-02 at 17:41 +1100, Alexey Kardashevskiy wrote:
>> With CONFIG_DEBUG_INFO_SPLIT=y, the makefile adds "-gsplit-dwarf" which
>> somehow makes the scripts/gcc-goto.sh test fail and not have
>> CC_HAVE_ASM_GOTO defined so the alternative OPAL_BRANCH() is used
> 
> This needs to be fixed too though. That alternative path has much more
> overhead accross the board. Losing "asm goto" because of a broken test
> is nasty.

I just posted "[RFC PATCH kernel] gcc-goto.sh: Allow to pass with
CONFIG_DEBUG_INFO_SPLIT=y" to Jason + cc: Michael, will see how it goes.



-- 
Alexey
