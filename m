Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18251.59930.30260.145217@cargo.ozlabs.ibm.com>
Date: Tue, 27 Nov 2007 20:57:46 +1100
From: Paul Mackerras <paulus@samba.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: time accounting problem (powerpc only?)
In-Reply-To: <1196094193.4149.287.camel@johannes.berg>
References: <1195814816.4149.94.camel@johannes.berg>
	<1196094193.4149.287.camel@johannes.berg>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg writes:

> Contrary to what I claimed later in the thread, my 64-bit powerpc box
> (quad-core G5) doesn't suffer from this problem.
> 
> Does anybody have any idea? I don't even know how to debug it further.

I see it on my G4 powerbook.  However, a compute-bound task runs just
as fast (i.e. completes in the same elapsed time) as on older kernels,
so it does look like it is just an accounting problem.  If the CPU was
really spending more than half its time servicing hardware interrupts,
the task should take more than twice as long to complete.

Paul.
