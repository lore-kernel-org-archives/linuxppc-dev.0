From: "Stephan Linke" <Stephan.Linke@epygi.de>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: running 8xx without UART 
Date: Fri, 13 Jun 2003 08:52:00 +0200
Message-ID: <FCEAKDJJAPHPLJFINDAJIEIBDCAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <FCEAKDJJAPHPLJFINDAJCEHLDCAA.Stephan.Linke@epygi.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

there appeares to be a microcode patch for MPC862 that allowes relocating SMC, SPI and I2C Parameter RAM. This should help getting
SMC1 running while SCC3 is doing Ethernet.

Thanks, Stephan

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Stephan
> Linke
> Sent: Donnerstag, 12. Juni 2003 13:43
> To: wd@denx.de
> Cc: Linuxppc-Embedded
> Subject: RE: running 8xx without UART
>
>
>
> Hi,
>
> > -----Original Message-----
> > From: wd@denx.de [mailto:wd@denx.de]
> > Sent: Donnerstag, 12. Juni 2003 13:22
> > To: Stephan Linke
> > Subject: Re: running 8xx without UART
> >
> >
> > In message <FCEAKDJJAPHPLJFINDAJMEHJDCAA.Stephan.Linke@epygi.de> you wrote:
> > > Sorry, I accidentialy replied to the wrong mail...
> >
> > Kein Problem :-)
> >
> > > this problem is actualy no kernel bug. It is a limitation of the 862 family that you can't use SMC1 while you use
> SCC3 as ATM or
> > > ethernet. It's not so well documented. Thant's why we run into that trap. The special problem on 852 is that there are
> > ony 2 SCC's
> > > and 1 SMC. :-)
> > ...
> > > > > We are experiencing problems with SCC3 running ethernet and SMC1 as console interface on a 852.
> >
> > SCC3 = Ethernet or SCC3 = ATM?
> >
> >
> We are using SCC3 as ethernet (Actualy there is no ATM on MPC852. But I guess that doesn't make a difference). :-)
>
> Stephan
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
