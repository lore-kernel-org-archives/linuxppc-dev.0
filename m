Subject: Re: Preemptive Kernel and MPC8xx ???
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <3FC1BAC8.6030305@imc-berlin.de>
References: <3FC0A1D3.70706@imc-berlin.de>
	 <B82FB2A3-1E4E-11D8-A8D4-003065E2BB06@aimsys.nl>
	 <3FC1BAC8.6030305@imc-berlin.de>
Content-Type: text/plain
Message-Id: <1069667203.31339.146.camel@linpc003.aimsys.nl>
Mime-Version: 1.0
Date: Mon, 24 Nov 2003 10:46:43 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2003-11-24 at 09:01, Steven Scholz wrote:
> Hi,
>
> >> is somebody actually using the preemptive kernel patches ...
> >>
> > Yes I do on 2.4.20 and 2.4.22 from kernel.org. So far all seems
> > to work but didn't do any measurements on it.
> So you're using vanilla 2.4.22 on your MPC8xx board!?

yes, am I stupid?

Currently I use smc uart, scc ethernet and a modified
cpm_spi driver (from the great Denx) with interrupt handling,
my 850 board boots ok from nfsroot

>
> > (I both use the preempt and low-latency patches)
> Sound interessting.
> Could you please give me a link to find the mentioned "low-latency patches".

it comes from Andrew Morton's page
http://www.zip.com.au/~akpm/linux/schedlat.html

I you have to enable this by hand in arch/ppc/config.in (look at
arch/i386/config.in) with

bool 'Low latency scheduling' CONFIG_LOLAT
dep_bool 'Control low latency with sysctl' CONFIG_LOLAT_SYSCTL
$CONFIG_LOLAT

>
> Thanks,
>
> Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
