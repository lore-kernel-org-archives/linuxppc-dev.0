Message-ID: <396A1649.88DAEA31@pop.agri.ch>
Date: Mon, 10 Jul 2000 20:30:39 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.0-test3
References: <3969E6B8.D0AE0169@pop.agri.ch> <20000710160513.21541@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> >In the sccstool I read in prom.c Calc BAT..... this may cause trouble if
> >the framebuffer is really badly aligned.......
> >TODO: Check 601 case...
> >
> >How can I help?
>
> Well, you can check disabling that (and the call that sets up this BAT in
> head.S) but don't forget, if you do that, to also declare
> bootx_text_mapped to 0 before leaving prom.c

I did so, in head.S I if'ed 0 the setup_disp_bat part. In prom.c I
commented out the prepare_disp_BAT(two times) and I set
bootx_text_mapped in these sections to zero. I also put out mesh.
Now the machine comes up again.
But on shutting down I get a terrible nfsd panic with lots of crash
code. (dump available)

So far my experiences......

Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
