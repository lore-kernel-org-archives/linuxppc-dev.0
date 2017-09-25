Return-Path: <alexei.starovoitov@gmail.com>
Received: from mail-wr0-x22e.google.com (mail-wr0-x22e.google.com
 [IPv6:2a00:1450:400c:c0c::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y18dg0JmgzDsN9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 02:28:06 +1000 (AEST)
Received: by mail-wr0-x22e.google.com with SMTP id w12so8773154wrc.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 09:28:06 -0700 (PDT)
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 Sep 2017 09:27:43 -0700
Message-ID: <CAADnVQLmSbLHwj9m33kpzAidJPvq3cbdnXjaew6oTLqHWrBbZQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] Speculative page faults
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, kirill@shutemov.name,
 Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@kernel.org>,
 dave@stgolabs.net,
 Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>,
 haren@linux.vnet.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 npiggin@gmail.com,
 bsingharora@gmail.com, Tim Chen <tim.c.chen@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 18, 2017 at 12:15 AM, Laurent Dufour
<ldufour@linux.vnet.ibm.com> wrote:
> Despite the unprovable lockdep warning raised by Sergey, I didn't get any
> feedback on this series.
>
> Is there a chance to get it moved upstream ?

what is the status ?
We're eagerly looking forward for this set to land,
since we have several use cases for tracing that
will build on top of this set as discussed at Plumbers.
