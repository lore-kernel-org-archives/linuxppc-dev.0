Subject: Re: Preemptive Kernel and MPC8xx ???
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Marius Groeger <mgroeger@sysgo.com>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <3FC30F17.1070904@imc-berlin.de>
References: <3FC0A1D3.70706@imc-berlin.de>
	 <B82FB2A3-1E4E-11D8-A8D4-003065E2BB06@aimsys.nl>
	 <Pine.LNX.4.56.0311241732200.2581@mag.devdep.sysgo.de>
	 <3FC30F17.1070904@imc-berlin.de>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1069863564.1263.1.camel@linpc003.aimsys.nl>
Mime-Version: 1.0
Date: Wed, 26 Nov 2003 17:19:24 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2003-11-25 at 09:13, Steven Scholz wrote:
> Hi,
>
> > On Mon, 24 Nov 2003, Jaap-Jan Boor wrote:
> >
> >>Yes I do on 2.4.20 and 2.4.22 from kernel.org. So far all seems
> >>to work but didn't do any measurements on it.
> >>(I both use the preempt and low-latency patches)
> Have you writting your own device drivers?
> How did you make them preemptable?

I didn't... I still assume the kernel will lock
e.g. the same SIU irq

>
> Marius Groeger wrote:
> > AFAIK, you can pretty much drop the low-latency patch in favor of
> > using the lock-breaking patch. It is also available from Robert Love
> > at the cited home page.
> How about homemade device drivers when using the lock-breaking patch?
>
> Thanks!
>
> --
> Steven Scholz
>
> imc Measurement & Control               imc Meßsysteme GmbH
> Voltastr. 5                             Voltastr. 5
> 13355 Berlin                            13355 Berlin
> Germany                                 Deutschland
> fon: +49 30 467090-0                    Tel: 030 / 467090-0
> fax: +49 30 4631576                     fax: 030 / 4631576
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
