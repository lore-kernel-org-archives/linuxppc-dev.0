Date: Wed, 30 Jun 2004 09:13:18 +1000
From: Anton Blanchard <anton@samba.org>
To: Rajarshi Das <rajarshi@in.ibm.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: equivalent of touch_nmi_watchdog
Message-ID: <20040629231318.GI7523@krispykreme>
References: <1088509774.22425.54.camel@darya>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1088509774.22425.54.camel@darya>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> I am running some code which needs interrupts to be disabled for a
> reasonable amount of time. A "touch_nmi_watchdog" call is done before
> this code gets called on i386 platform. How do I do it on ppc64 ? I am
> using a power 3 machine (type 7044-170) (uniprocessor) and a 2.6.6
> kernel.

Check out arch/ppc64/xmon/xmon.c: disable_surveillance() in a recent 2.6
kernel. It might be worth moving that function into rtas.c if you want
to use it as well.

Anton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
