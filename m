Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 352621A05F9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 05:29:13 +1000 (AEST)
Date: Thu, 17 Sep 2015 09:01:16 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <scottwood@freescale.com>, Thomas Gleixner <tglx@linutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [BUG] Revert 0b05e2d671c4 'powerpc/32: cacheable_memcpy becomes
 memcpy'
Message-ID: <20150917140111.GB2613@gate.crashing.org>
References: <alpine.DEB.2.11.1509161816310.3951@nanos>
 <1442420984.2909.179.camel@freescale.com>
 <alpine.DEB.2.11.1509162159110.3951@nanos>
 <20150916215435.48bee4d3@grimm.local.home>
 <1442458212.8456.2.camel@ellerman.id.au>
 <20150917031854.GA31437@gate.crashing.org>
 <063D6719AE5E284EB5DD2968C1650D6D1CB98ADF@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CB98ADF@AcuExch.aculab.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 17, 2015 at 09:47:39AM +0000, David Laight wrote:
> > It also says "tftp", which is intriguing if nothing else :-)
> 
> Much more likely than the above instruction.
> If the address it wass read from is in the dump, look at the entire string.

And tell us what network drivers you use, what firmware, what bootloader.
Try changing either of those (if feasible), see if the problem goes away.


Segher
