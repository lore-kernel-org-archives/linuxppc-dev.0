Return-Path: <paubert@iram.es>
Received: from villa.puc.rediris.es (villa.puc.rediris.es [130.206.18.7])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6BC511400A8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 May 2014 08:31:13 +1000 (EST)
Date: Fri, 9 May 2014 23:50:05 +0200
From: Gabriel Paubert <paubert@iram.es>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: irq work racing with timer interrupt can result
 in timer interrupt hang
Message-ID: <20140509215005.GA28239@visitor2.iram.es>
References: <20140509174712.55fe72d0@kryten>
 <20140509134113.GP8754@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140509134113.GP8754@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 09, 2014 at 06:41:13AM -0700, Paul E. McKenney wrote:
> On Fri, May 09, 2014 at 05:47:12PM +1000, Anton Blanchard wrote:
> > I am seeing an issue where a CPU running perf eventually hangs.
> > Traces show timer interrupts happening every 4 seconds even
> > when a userspace task is running on the CPU.
> 
> Is this by chance every 4.2 seconds?  The reason I ask is that
> Paul Clarke and I are seeing an interrupt every 4.2 seconds when
> he runs NO_HZ_FULL, and are trying to get rid of it.  ;-)

Hmmm, it's close to 2^32 nanoseconds, isnt't it suspiscious?

	Gabriel
