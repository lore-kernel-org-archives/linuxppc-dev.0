Date: Tue, 20 Jan 2004 14:49:17 +0100
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Etsushi Kato <ekato@ees.hokudai.ac.jp>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: local_irq_enable() problem...
Message-ID: <20040120134917.GA7665@iliana>
References: <4824AFEC-4B0A-11D8-A780-00039394E428@ees.hokudai.ac.jp> <Pine.GSO.4.58.0401201102450.18625@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <Pine.GSO.4.58.0401201102450.18625@waterleaf.sonytel.be>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 20, 2004 at 11:03:41AM +0100, Geert Uytterhoeven wrote:
>
> On Tue, 20 Jan 2004, Etsushi Kato wrote:
> > I just started porting Linux 2.6 for nubus powermac.  I've applied most
> > of 2.4 nubus patch to 2.6.1-rc2, and kernel compiles fine now.  But in
> > the early booting of kernel, it hangs while doing local_irq_enable()
> > just after profile_init() in start_kernel() of init/main.c.
> >
> > How can I debug kernel in this situation?  printk() is working, and
> > boot messages are shown with serial connection until "Console: colour
> > dummy device 80x25".
>
> Did you pass `console=ttyS0'?

Is it not console=ttyS01 ?

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
