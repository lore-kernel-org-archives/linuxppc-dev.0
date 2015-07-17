Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D65F31A0072
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 12:00:44 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Fri, 17 Jul 2015 12:00:44 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 79A362CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 12:00:41 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6H20Yno63635478
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 12:00:42 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6H208Pj028149
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 12:00:09 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Zumeng Chen <zumeng.chen@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, paulus <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "romeo.cane.ext" <romeo.cane.ext@coriant.com>
Subject: Re: BUG: perf error on syscalls for powerpc64.
In-reply-to: <20150717015104.GA25558@us.ibm.com>
References: <CA+Y31wfLFe11nh9AVs2JgKrxpMc6qxxDyCfey52HT23S7RJ_zw@mail.gmail.com>
 <1437037461.15828.2.camel@ellerman.id.au>
 <CA+Y31wf16voXS6psDUDpNjMFTD8HTMwrdn=sDXC_B1=n7m=1FQ@mail.gmail.com>
 <20150717015104.GA25558@us.ibm.com>
Date: Fri, 17 Jul 2015 11:59:44 +1000
Message-Id: <1437098328-sup-6685@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Sukadev Bhattiprolu's message of 2015-07-17 11:51:04 +1000:
> Are you seeing this on big-endian or little-endian system?
> 
> IIRC, I saw the opposite behavior on an LE system a few months ago.
> i.e. without 1028ccf5, 'perf listf|grep syscall' failed.
> 
> Applying 1028ccf5, seemed to fix it.

You could be on to something there - IIRC the ABI was changed for LE to
remove the dot symbols. Might be worth testing on both.

Cheers,
-Ian
