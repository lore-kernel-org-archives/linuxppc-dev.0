Return-Path: <mingo@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 39A62DDEF8
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Dec 2006 01:49:45 +1100 (EST)
Subject: Re: Mutex debug lock failure [was Re: Bad gcc-4.1.0 leads to
	Power4 crashes... and power5 too, actually
From: Ingo Molnar <mingo@redhat.com>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20061221010319.GE16860@austin.ibm.com>
References: <20061220004653.GL5506@austin.ibm.com>
	<1166579210.4963.15.camel@otta> <20061220211931.GB16860@austin.ibm.com>
	<1166650134.6673.9.camel@localhost.localdomain>
	<20061220230342.GC16860@austin.ibm.com>
	<1166656195.6673.23.camel@localhost.localdomain>
	<20061220234647.GD16860@austin.ibm.com>
	<20061221003658.GB3048@krispykreme>
	<20061221010319.GE16860@austin.ibm.com>
Content-Type: text/plain
Date: Thu, 21 Dec 2006 15:41:39 +0100
Message-Id: <1166712099.8869.16.camel@earth>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu, Anton Blanchard <anton@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-12-20 at 19:03 -0600, Linas Vepstas wrote:
> Same kernel runs fine on power5. Although it does have patches
> applied, those very same patches boot fine when applied to a slightly
> older kernel (2.6.19-rc4).  I haven't been messing with buids or 
> pci config space (at least not intentionaly).
> 
> I'll try again with an unpatched, unmodified kernel.

there have been a number of fixes to lockdep recently - could you try
the kernel/lockdep.c file from latest -mm, does that fail too?

one possibility would be a chain-hash collision.

	Ingo
