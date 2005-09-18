Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17197.63153.78371.490616@cargo.ozlabs.ibm.com>
Date: Mon, 19 Sep 2005 09:22:25 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1126631205.11056.15.camel@cashmere.sps.mot.com>
References: <1126631205.11056.15.camel@cashmere.sps.mot.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: Merge Question on asm-ppc*/rwsem.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger writes:

> Which begs the question, what is the "else smp_wmb();" clause
> really doing for us in the ppc32 case, and can we either
> get rid of it, or is it safe to add to the ppc64 case?

I think the difference is that the atomic ops that return a value also
have include a barrier on ppc64, but don't on ppc32 (although they
probably should).  IOW I think the merged case should follow ppc64
here.

Paul.
