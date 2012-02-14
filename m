Return-Path: <a.p.zijlstra@chello.nl>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5DD471007D3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2012 07:01:00 +1100 (EST)
Message-ID: <1329249629.2293.22.camel@twins>
Subject: Re: smp: Start up non-boot CPUs asynchronously
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Tue, 14 Feb 2012 21:00:29 +0100
In-Reply-To: <4F3ABCC1.5020000@linux.vnet.ibm.com>
References: <20120130205444.22f5e26a@infradead.org>
 <20120131125232.GD4408@elte.hu>	<20120131054155.371e8307@infradead.org>
 <20120131143130.GF13676@elte.hu>	<20120131072216.1ce78e50@infradead.org>
 <20120131161207.GA18357@elte.hu>	<20120131082439.575978c0@infradead.org>
 <4F3A1891.8060001@linux.vnet.ibm.com>	<4F3A2DFB.5000209@linux.vnet.ibm.com>
 <CADyApD0o4UYsTkqf2H2yJZ-d05NAyRAEc6z+m1gJEogc=cZLqQ@mail.gmail.com>
 <4F3ABCC1.5020000@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, mikey@neuling.org,
 gregkh@linuxfoundation.org, Ingo Molnar <mingo@elte.hu>,
 linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
 Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Arjan van de Ven <arjan@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Arjan van de Ven <arjanvandeven@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-02-15 at 01:27 +0530, Srivatsa S. Bhat wrote:
> [Small note, it appears as if the last 2 of your replies to this
> thread
>  didn't reach LKML.]=20

because he used html mail, LKML drops those.. IIRC you can tell K-9 not
to use html cruft, but then I stopped trying to pretend you can email
using phones, its all too painful.
