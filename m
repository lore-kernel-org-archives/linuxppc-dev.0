Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-ID: <3BCB06A7.7A6C0D9F@mvista.com>
Date: Mon, 15 Oct 2001 11:54:15 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Ed.Swarthout@motorola.com
Cc: paulus@samba.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: interesting line in process.c
References: <15304.11248.720092.645241@cargo.ozlabs.ibm.com> <3BCAF4D2.D41EE8C4@mvista.com> <200110151547.f9FFltD24916@pacific.somerset.sps.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Edward Swarthout wrote:

> I would suggest ppc do the same thing and define a single debug array
> in thread_struct which contains the processor specific debug registers
> needed to support gdb's use of hardware breakpoints.

So, gdb has knowledge of hardware breakpoints and knows how to use
them across the different processors?  I would ask we consider using
a standard breakpoint interface to the kernel and allow the kernel
to implement the breakpoints as it desires.  It seems having this
knowledge and synchronizing the necessary information across the
interface could be challenging.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
