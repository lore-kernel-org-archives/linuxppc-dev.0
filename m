Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyQgy54xXzDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 19:49:50 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0A8n8tL058236
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 03:49:48 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27vv8hrdu9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 03:49:47 -0500
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Tue, 10 Jan 2017 14:19:44 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 0241AE005B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 14:20:42 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0A8neCm39321796
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 14:19:40 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0A8nbrL018389
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 14:19:40 +0530
Subject: Re: [PATCH v3 02/15] x86/entry: define _TIF_ALLWORK_MASK flags
 explicitly
To: Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@redhat.com>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <b03212d03f5f112ffa778c30012c7f8301f64929.1481220077.git.jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>,
 Chris J Arges <chris.j.arges@canonical.com>,
 Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Tue, 10 Jan 2017 14:19:31 +0530
MIME-Version: 1.0
In-Reply-To: <b03212d03f5f112ffa778c30012c7f8301f64929.1481220077.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <7315bfd9-f6aa-9cf9-b262-da1a600a65be@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 08 December 2016 11:38 PM, Josh Poimboeuf wrote:
> The _TIF_ALLWORK_MASK macro automatically includes the least-significant
> 16 bits of the thread_info flags, which is less than obvious and tends
> to create confusion and surprises when reading or modifying the code.
>
> Define the flags explicitly.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

For the version with swapped _TIF_SINGLESTEP and _TIF_NEED_RESCHED
flags.

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

-- 
cheers,
Kamalesh.
