Subject: Re: Preemptive Kernel and MPC8xx ???
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Marius Groeger <mgroeger@sysgo.com>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <3FC4C1DD.3020209@imc-berlin.de>
References: <3FC0A1D3.70706@imc-berlin.de>
	 <B82FB2A3-1E4E-11D8-A8D4-003065E2BB06@aimsys.nl>
	 <Pine.LNX.4.56.0311241732200.2581@mag.devdep.sysgo.de>
	 <3FC4C1DD.3020209@imc-berlin.de>
Content-Type: text/plain
Message-Id: <1069863786.1263.6.camel@linpc003.aimsys.nl>
Mime-Version: 1.0
Date: Wed, 26 Nov 2003 17:23:06 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2003-11-26 at 16:08, Steven Scholz wrote:
> Marius Groeger wrote:
>
> > AFAIK, you can pretty much drop the low-latency patch in favor of
> > using the lock-breaking patch. It is also available from Robert Love
> > at the cited home page.
>
> Rob Love wrote me:
>
>  >>Is it correct that your lock-break does basicly the same as Andrew Morton's
>  >>low-latency patches? Where is the big difference?
>  >
>  > Yes, basically the same thing.  Lock-break is a version of low-latency
>  > that is "optimized" for use with the preemptive kernel.
>  >
>  > You might as well just use low-latency, as Andrew is keeping that more
>  > up to date.
>
> And that's what I noticed when looking and the download pages...
>
> That leaves three options:
>
>  > 	(a) Use only preempt-kernel
>  > 	(b) Use only low-latency
>  > 	(c) Use preempt-kernel + low-latency
>
> Right?

Yes, I use (c)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
