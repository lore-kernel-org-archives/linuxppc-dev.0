Message-ID: <38C436C3.36BC4448@pop.agri.ch>
Date: Mon, 06 Mar 2000 23:52:51 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Dev-Linux <linuxppc-dev@lists.linuxppc.org>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        Paul Mackerras <paulus@linuxcare.com>
Subject: Re: serial module in 2.3.x?
References: <38C3BE97.3DE053C9@pop.agri.ch> <38C42E7D.B537A3F0@pop.agri.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Additional follow up,
I enabled the xmon without video driver enabled:

It works but, I can't see the output, only the line breaks. Means, if I
type 't' for bt I get some line breaks but no screen output.
This is done under 2.3.50-pre2, which is the same, more or less as
2.3.49 from bk.
The behaviour of not showing me the xmon output I saw under 2.3.48 lc,
bk and stock.

Andreas Tobler wrote:
>
> Some follow up,
>
> I hang in the procedure autoconfig from serial.c, I get out the msg.
> 'Testing ttysx'.
> this happens on a wallstreet & on a pm7200.
> It takes a lot of time to find out where, since each freeze needs about
> 10' to reboot (fsck)
>
> Thanks for any hint!!
>
> Andreas Tobler wrote:
> >
> > Hi,
> > has anybody seen the same? I'd like to include the serial.o module into
> > recent kernels (2.3.x). No luck, I always get a machine check. I'm not
> > sure where it is.
> > This happens up to 2.3.50-pre2. I suppose it has to do with the
> > SHARE_IRQ etc.
> > Any ideas?
>
> Andreas

--
| Andreas Tobler
| CH-8004 Zuerich
| E-Mail:   a.tobler@schweiz.ch
-----------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
