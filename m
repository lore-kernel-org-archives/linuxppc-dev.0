Message-ID: <3FC30F17.1070904@imc-berlin.de>
Date: Tue, 25 Nov 2003 09:13:11 +0100
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


Hi,

> On Mon, 24 Nov 2003, Jaap-Jan Boor wrote:
>
>>Yes I do on 2.4.20 and 2.4.22 from kernel.org. So far all seems
>>to work but didn't do any measurements on it.
>>(I both use the preempt and low-latency patches)
Have you writting your own device drivers?
How did you make them preemptable?

Marius Groeger wrote:
> AFAIK, you can pretty much drop the low-latency patch in favor of
> using the lock-breaking patch. It is also available from Robert Love
> at the cited home page.
How about homemade device drivers when using the lock-breaking patch?

Thanks!

--
Steven Scholz

imc Measurement & Control               imc Meﬂsysteme GmbH
Voltastr. 5                             Voltastr. 5
13355 Berlin                            13355 Berlin
Germany                                 Deutschland
fon: +49 30 467090-0                    Tel: 030 / 467090-0
fax: +49 30 4631576                     fax: 030 / 4631576


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
