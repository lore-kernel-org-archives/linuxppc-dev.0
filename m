Message-Id: <4.3.2.7.2.20000725184148.0383a520@mail.munich.netsurf.de>
Date: Tue, 25 Jul 2000 18:46:19 +0200
To: SteffenH@hyperion-software.de
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: sound again [was: Re: xf4 bug report]
Cc: Iain Sandoe <iain@sandoe.co.uk>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <yam8241.2878.148063952@mail.lf-online.de>
References: <200007251558.QAA02148@hyperion.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 01:30 26.07.00, Steffen Haeuser wrote:

>Am 25-Jul-00 schrieb Iain Sandoe:
>
>Hi!
>
> >can you do a 'dmesg' and find any lines which have "dmasound" in them?
> >Or... are you using sound as modules?
> >I assume you are using Ben's binary (pre10-ben2)?
>
>I just checked the message. I was wrong about the DMA stuff... sorry...
>it reads
>
>modprobe: can't locate module sound
>rc.sysinit: Loading Sound module failed
>
>Sounds as if the module is missing... but I installed the modules
>exactly how I found them on the site... and the kernel and system.map
>also...

It may be missing, but most likely it is compiled directly into the kernel.
Ben does that usually.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
