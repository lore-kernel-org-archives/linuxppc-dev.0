Subject: Re: Context Switch in Real Time  Linux Vs VxWorks (or any other
	RTOS)
From: Gary Thomas <gary@mlbassoc.com>
To: okorpil@fh-landshut.de
Cc: arun@ossi.co.in,
	linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <40F77AA3.8030703@fh-landshut.de>
References: <000001c46af2$642f7c40$e100a8c0@arunprasad>
	 <40F77AA3.8030703@fh-landshut.de>
Content-Type: text/plain
Message-Id: <1089990598.22193.6417.camel@hermes>
Mime-Version: 1.0
Date: Fri, 16 Jul 2004 09:09:58 -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2004-07-16 at 00:50, Oliver Korpilla wrote:
> Arun Prasad Velu wrote:
> >
> >I am in the process of analyzing the feasibility of migrating an
> >existing VxWorks system (MPC860 target) to Linux (RTOS).
> >
> >I'd like to compare the features of Linux and VxWorks with respect to
> >the Real Time capabilities. I am little concerned about Linux's Context
> >Switching.
> >
> >I'd like to get your opinion on this. Even if I want to move to Linux,
> >I'll have to convince my management. So, any pointers on comparison of
> >Linux Vs VxWorks with respect to Real Time capabilities would be highly
> >appreciated.
>
> I hardly guess context switching will be your main problem, because the
> stock Linux kernel does not support hard realtime!
>
> You either have to use RTAI (free kernel modification that requires
> drivers to be rewritten for realtime), RTLinux (nearly the same,
> non-free, patented) or modified Linux kernels from TimeSys or MontaVista
> (who both add real-time capabilities in a more stock-Linux-compliant way).
>
> Depending on your target, eCos (a free embedded operating system with a
> focus on minimal code) may be the better choice for you, especially if
> your platform is already supported.

Thanks for the plug :-)  [n.b. I am one of the main eCos developers]
FYI, look to http://sources.redhat.com/ecos for details.

>
> Be warned: Not all PowerPC processors are supported in eCos (last time I
> checked 74xx and 7xx were missing).

Ah, but they are simple to add (and have been, but not necessarily
public) as they are effectively PPC60x processors with some differences.

--
Gary Thomas <gary@mlbassoc.com>
MLB Associates


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
