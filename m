Message-ID: <002101c23a8d$4d54d480$43ba459b@ntu.edu.sg>
From: "shaowei dai" <dshaowei@rfnetech.com>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <20020729040824.GA2351@zax> <20020729100009.A23843@flint.arm.linux.org.uk> <20020729144408.GA11206@opus.bloom.county> <00a801c239ea$191a9c20$43ba459b@ntu.edu.sg> <3D4AC468.83BCD667@opensource.se>
Subject: Re: symbol card with orinoco_cs on mpc823
Date: Sat, 3 Aug 2002 09:30:07 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear all:

Thanks for all the help. I've found out the problem.
It's indeed a low-level problem. m8xx-pcmcia can't reconginize the io size
of this kind of card.
So i just manully set it to correct one. Then it works fine.

Thanks the authors. The two drivers are so great!

regards

----- Original Message -----
From: "Magnus Damm" <damm@opensource.se>
To: "shaowei dai" <dshaowei@rfnetech.com>
Sent: Saturday, August 03, 2002 1:42 AM
Subject: Re: symbol card with orinoco_cs on mpc823


> Try disabling the busmonitor if it's enabled.
>
> / Magnus
>
> shaowei dai wrote:
> >
> > Hello,
> >
> > Has anybody tried orinodo_cs 0.11b or 0.12b with success on symbol
> > Spectrum24 High rate11M card on mpc platform?
> > I've tried 2.4.18-pre3 and 2.4.19-rc3 kernel with orinoco driver. It
works
> > fine with intersil card. But
> > when i try it on symbol card, it always crashes. After tracing down i
find
> > it is caused by hermes_init(). It seems the
> > call to hermes_write_regn(hw,INTEN,0)  cause the crash. The ksymoops
also
> > suggest this function. It is just an io write. What can be wrong? And
most
> > strange thing is why it doesn't cause any trouble in normal intersil
card.
> >
> > Any ideas is greatly appreciate!
> >
> > regards
> > David
> >
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
