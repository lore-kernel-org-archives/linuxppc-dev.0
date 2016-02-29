Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 73B841A0035
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 22:05:24 +1100 (AEDT)
In-Reply-To: <56CC3CDD.8040006@linux.vnet.ibm.com>
To: xinhui <xinhui@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [V2] arch/powerpc: use BUILD_BUG_ON_MSG() when detect unfit
 {cmp}xchg size
Message-Id: <20160229110524.59951140662@ozlabs.org>
Date: Mon, 29 Feb 2016 22:05:24 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-23-02 at 11:05:01 UTC, xinhui wrote:
> From: pan xinhui <xinhui.pan@linux.vnet.ibm.com>
> 
> __xchg_called_with_bad_pointer() can't tell us what codes use {cmp}xchg
> in incorrect way.  And no error will be reported until the link stage.
> To fix such a kind of issues easily, we use BUILD_BUG_ON_MSG() here.
> 
> Signed-off-by: pan xinhui <xinhui.pan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/10d8b1480e6966ba03cd3afad3

cheers
