Message-ID: <3DB422C2.D0139C67@esteem.com>
Date: Mon, 21 Oct 2002 08:52:34 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: Patrick Mahoney <pmahoney@8d.com>
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx - power save modes - PIT
References: <20021010183502.GA843@segfault.usine.8d.com> <3DA5F5EC.2844DE06@esteem.com> <20021010230042.GA8690@segfault.usine.8d.com> <3DA62C69.A5BD884F@esteem.com> <20021021133451.GA16540@segfault.usine.8d.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Patrick Mahoney wrote:
>
> Hi Conn,
>
> I apologize for sticking to the topic... Getting to doze low mode is
> very important to our project...
>
> You say you got the ppc version of the 2.4.19 kernel from
> ftp.kernel.org... This can't be, since the latest available ppc patch
> is for the 2.4.18 kernel...
>
> So what kernel version/provider did you use your patch on?
>
> Once again, thanks a lot...
>
> Pat Mahoney
>
> > > >       I have played with some of the power saving modes on our custom
> > > > 850 board and have had no problems. I have toyed with the Doze High and
> > > > Doze Low modes in the idle loop. Attached is a hacked up idle loop for
> > > > kernel 2.4.19 that works for me.
>
> [...]
>
> > I forgot to mention my kernel source tree was directly from kernel.org

I got my kernel from ftp.kernel.org . I belive the patches to 2.4.18 were
submitted and included into 2.4.19 from ftp.kernel.org . I don't think there
has been an official patch released for 2.4.19 as of yet.

good luck,

	Conn
--

*****************************************************************
  If you live at home long enough, your parents will move out.
 (Warning they may try to sell their house out from under you.)
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
