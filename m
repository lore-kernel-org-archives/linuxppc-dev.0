Return-Path: <linus971@gmail.com>
Received: from mail-vb0-x232.google.com (mail-vb0-x232.google.com
 [IPv6:2607:f8b0:400c:c02::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 498D22C011F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 02:47:15 +1000 (EST)
Received: by mail-vb0-f50.google.com with SMTP id x14so2334515vbb.37
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Sep 2013 09:47:11 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1379910958.6625.3.camel@pasglop>
References: <1379620267-25191-1-git-send-email-fweisbec@gmail.com>
 <CA+55aFyXf370Ds6FH5wPPycZLSPD5qiP7rjWqxwDetfHfKjg1w@mail.gmail.com>
 <alpine.DEB.2.02.1309201244080.4089@ionos.tec.linutronix.de>
 <20130920162603.GA30381@localhost.localdomain>
 <CA+55aFyBcjP2U6ipzZay=FdhzA4oFNwE4tU0OcJJhwFvgoeALw@mail.gmail.com>
 <CAFTL4hzucS5nJbCrArPv9zfY=QpyUESMK2Th0tKFHVCjDP7-eA@mail.gmail.com>
 <1379799901.24090.6.camel@pasglop> <523E4F8A.7020708@zytor.com>
 <1379824754.24090.11.camel@pasglop>
 <1379824861.24090.12.camel@pasglop>
 <20130922162410.GA10649@laptop.programming.kicks-ass.net>
 <1379887000.24090.19.camel@pasglop>
 <CA+55aFwaf_Wst=AS75ydBJVQ6aJxPfAzXdt-UXj3qC9WeUt7kw@mail.gmail.com>
 <1379889489.24090.34.camel@pasglop>
 <1379910958.6625.3.camel@pasglop>
Date: Mon, 23 Sep 2013 09:47:11 -0700
Message-ID: <CA+55aFwcPU+fAqDGp0QhSYip7MYPBB+kQiU4GHEdgMo82i7RVg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/irq: Run softirqs off the top of the irq stack
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: James Hogan <james.hogan@imgtec.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <fweisbec@gmail.com>, Helge Deller <deller@gmx.de>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 22, 2013 at 9:35 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> This is the "band aid" discussed so far for the stack overflow
> problem for powerpc.

I don't think it's a "band-aid" in any way, except perhaps in the
sense that there are certainly other things we can also do in this
series (ie I liked Frederic's cleanups etc).

                     Linus
