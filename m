Message-ID: <3FC4C1DD.3020209@imc-berlin.de>
Date: Wed, 26 Nov 2003 16:08:13 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Marius Groeger <mgroeger@sysgo.com>
Cc: Jaap-Jan Boor <jjboor@aimsys.nl>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Preemptive Kernel and MPC8xx ???
References: <3FC0A1D3.70706@imc-berlin.de> <B82FB2A3-1E4E-11D8-A8D4-003065E2BB06@aimsys.nl> <Pine.LNX.4.56.0311241732200.2581@mag.devdep.sysgo.de>
In-Reply-To: <Pine.LNX.4.56.0311241732200.2581@mag.devdep.sysgo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marius Groeger wrote:

> AFAIK, you can pretty much drop the low-latency patch in favor of
> using the lock-breaking patch. It is also available from Robert Love
> at the cited home page.

Rob Love wrote me:

 >>Is it correct that your lock-break does basicly the same as Andrew Morton's
 >>low-latency patches? Where is the big difference?
 >
 > Yes, basically the same thing.  Lock-break is a version of low-latency
 > that is "optimized" for use with the preemptive kernel.
 >
 > You might as well just use low-latency, as Andrew is keeping that more
 > up to date.

And that's what I noticed when looking and the download pages...

That leaves three options:

 > 	(a) Use only preempt-kernel
 > 	(b) Use only low-latency
 > 	(c) Use preempt-kernel + low-latency

Right?

--
Steven Scholz

imc Measurement & Control               imc Meﬂsysteme GmbH
Voltastr. 5                             Voltastr. 5
13355 Berlin                            13355 Berlin
Germany                                 Deutschland
fon: +49 30 467090-0                    Tel: 030 / 467090-0
fax: +49 30 4631576                     fax: 030 / 4631576


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
