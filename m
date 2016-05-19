Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9Y305wH3zDq80
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 00:14:04 +1000 (AEST)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Thu, 19 May 2016 08:14:01 -0600
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 1D29F19D804C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 08:13:40 -0600 (MDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4JEDvnJ31522938
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 14:13:57 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4JEDtgS027632
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 10:13:57 -0400
Date: Thu, 19 May 2016 07:14:01 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Josh Triplett <josh@joshtriplett.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 0/4] rcutorture: Several fixes to run selftest scripts on
 PPC
Message-ID: <20160519141401.GO3528@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1463629344-20471-1-git-send-email-boqun.feng@gmail.com>
 <20160519042516.GA19073@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160519042516.GA19073@x>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 18, 2016 at 09:25:17PM -0700, Josh Triplett wrote:
> On Thu, May 19, 2016 at 11:42:20AM +0800, Boqun Feng wrote:
> > I spend some time to make tools/testing/selftest/rcutorture run on PPC,
> > here are some documention and fixes made while I was trying.
> > 
> > The scripts are able to run and get results on PPC, however please
> > note there are some stalls even build errors that could be found
> > by the tests currently.
> > 
> > As I'm certainly not an expert of qemu or bash programming, there
> > may be something I am missing in those patches. So tests and comments
> > are welcome ;-)
> > 
> > Regards,
> > Boqun
> > 
> > Boqun Feng (4):
> >   rcutorture/doc: Add a new way to create initrd using dracut
> >   rcutorture: Use vmlinux as the fallback kernel image
> >   rcutorture: Make -soundhw a x86 specific option
> >   rcutorture: Don't specify the cpu type of QEMU on PPC
> 
> All four of these seem reasonable to me:
> Reviewed-by: Josh Triplett <josh@joshtriplett.org>

Thank you both!  I have queued all four for further review and for
testing.

> I responded to the -soundhw patch, trying to track down why that option
> was needed in the first place, and seeking a solution that doesn't
> require adding to the set of target-specific options.  But I don't think
> that investigation should block your fix.

Agreed, it should work better now than it did before!

							Thanx, Paul
