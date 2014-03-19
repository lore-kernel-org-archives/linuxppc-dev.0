Return-Path: <linus971@gmail.com>
Received: from mail-vc0-x235.google.com (mail-vc0-x235.google.com
 [IPv6:2607:f8b0:400c:c03::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D94652C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 03:04:32 +1100 (EST)
Received: by mail-vc0-f181.google.com with SMTP id id10so9254112vcb.40
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Mar 2014 09:04:28 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20140319152619.GB10406@linux.vnet.ibm.com>
References: <20140319152619.GB10406@linux.vnet.ibm.com>
Date: Wed, 19 Mar 2014 09:04:28 -0700
Message-ID: <CA+55aFxzDiCEUwVYye0w=sOFVQjMPMKJ6ee=L2sST8aQZ-55Zw@mail.gmail.com>
Subject: Re: Tasks stuck in futex code (in 3.14-rc6)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Davidlohr Bueso <davidlohr@hp.com>, Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 19, 2014 at 8:26 AM, Srikar Dronamraju
<srikar@linux.vnet.ibm.com> wrote:
>
> I reverted b0c29f79ecea0b6fbcefc999e70f2843ae8306db on top of v3.14-rc6 and confirmed that
> reverting the commit solved the problem.

Ok. I'll give Peter and Davidlohr a few days to perhaps find something
obvious, but I guess we'll need to revert it from 3.14 and try again
later unless some fix comes up quickly..

Oh well.

             Linus
