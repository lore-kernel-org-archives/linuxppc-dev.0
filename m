Message-ID: <20021119190116.13369.qmail@web20104.mail.yahoo.com>
Date: Tue, 19 Nov 2002 11:01:16 -0800 (PST)
From: Owen Green <owenjinggreen@yahoo.com>
Subject: Re: Fast HDLC driver
To: Der Herr Hofrat <der.herr@mail.hofr.at>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <200211191615.gAJGFVw09351@hofr.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You can find it on:

http://www.qslinux.com/

I`ve posted the .c file in the list too...

Owen.

--- Der Herr Hofrat <der.herr@mail.hofr.at> wrote:
> >
> > Hi all,
> >
> > I`ve started working on a new project were a high
> > performace hdlc channel is needed (at least 4Mbps
> on
> > MPC8xx-50Mhz).
> > I found several drivers for hdlc, but some are not
> > very fast (copies memory,... ), most of them calls
> > netif_rx from inside interrupt_handler (I don`t
> think
> > this is the best place for doing that, watchdog
> may
> > expire if the interface gets very busy..).
> > The only driver I found that seems to be really
> fast
> > and doesnt do all this stuff in interrupt context
> is
> > for kernel-2.2 (QSLINUX).
>
> do you have a URL to that driver ??
>
> thx !
> hofrat


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
