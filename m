Return-Path: <rs@carriercomm.com>
Received: from ccomm-ex1.ccomm.com (unknown [207.158.3.3])
	by ozlabs.org (Postfix) with ESMTP id C6273DDF1A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Sep 2008 02:49:53 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: gdbserver not working with pthreads
Date: Thu, 18 Sep 2008 09:37:45 -0700
Message-ID: <EE63F03D9E04774997AEBCD21FC77F25317D3B@ccomm-ex1.ccomm.com>
From: "Sugathan, Rupesh" <rs@carriercomm.com>
To: "Matteo Fortini" <m.fortini@selcomgroup.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> When debugging with gdbserver/gdb the debugger loses control=20
> of the threads. I did set the sysroot variable right, and I=20
> don't get the ld not found error message.
>  Basically, I cannot step into pthread_create, without losing=20
> control, with the software not running and gdb going timeout.=20
> Sometimes the gdbserver shell prints out "ptrace(): pid not=20
> found", or I get E01 reply on the gdb-cross. Putting=20
> breakpoints into threads works sometimes.
> My ultimate goal would be to make it work with Eclipse, but=20
> it's a long way from having it working with such a system.

Try to change the way GDB handle some of the signals, I don't recall
which signal in this respect though. You can do this using the 'handle'
command.
