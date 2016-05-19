Return-Path: <josh@joshtriplett.org>
Received: from slow1-d.mail.gandi.net (slow1-d.mail.gandi.net [217.70.178.86])
 by lists.ozlabs.org (Postfix) with ESMTP id 3r9J4X3VDlzDqHc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 14:29:32 +1000 (AEST)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 by slow1-d.mail.gandi.net (Postfix) with ESMTP id 21BCF48601F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 06:25:32 +0200 (CEST)
Date: Wed, 18 May 2016 21:25:17 -0700
From: Josh Triplett <josh@joshtriplett.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 0/4] rcutorture: Several fixes to run selftest scripts on
 PPC
Message-ID: <20160519042516.GA19073@x>
References: <1463629344-20471-1-git-send-email-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1463629344-20471-1-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 19, 2016 at 11:42:20AM +0800, Boqun Feng wrote:
> I spend some time to make tools/testing/selftest/rcutorture run on PPC,
> here are some documention and fixes made while I was trying.
> 
> The scripts are able to run and get results on PPC, however please
> note there are some stalls even build errors that could be found
> by the tests currently.
> 
> As I'm certainly not an expert of qemu or bash programming, there
> may be something I am missing in those patches. So tests and comments
> are welcome ;-)
> 
> Regards,
> Boqun
> 
> Boqun Feng (4):
>   rcutorture/doc: Add a new way to create initrd using dracut
>   rcutorture: Use vmlinux as the fallback kernel image
>   rcutorture: Make -soundhw a x86 specific option
>   rcutorture: Don't specify the cpu type of QEMU on PPC

All four of these seem reasonable to me:
Reviewed-by: Josh Triplett <josh@joshtriplett.org>

I responded to the -soundhw patch, trying to track down why that option
was needed in the first place, and seeking a solution that doesn't
require adding to the set of target-specific options.  But I don't think
that investigation should block your fix.
