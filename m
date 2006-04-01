Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17454.15223.929530.985654@cargo.ozlabs.ibm.com>
Date: Sat, 1 Apr 2006 19:36:07 +1100
From: Paul Mackerras <paulus@samba.org>
To: Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [PATCH 2/2] Base pSeries PCIe support
In-Reply-To: <20060331161330.3c723103.moilanen@austin.ibm.com>
References: <20060331160203.f2bf8b53.moilanen@austin.ibm.com>
	<20060331161330.3c723103.moilanen@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jake Moilanen writes:

> The NR_IRQS got bumped up to 1024, as vectors can go much higher.
> Unfortunately, this number was arbitrarily picked as there is no claim
> at what the max number really is by either the firmware team, or the
> PAPR+.

What matters is the number of different vectors, not the actual value
of the vectors, because we remap interrupt numbers that the firmware
gives us to logical Linux irq numbers between 0 and NR_IRQS-1.  We had
to do that when the POWER5 systems came out, because the interrupt
numbers there occupy 24 bits.

Paul.
