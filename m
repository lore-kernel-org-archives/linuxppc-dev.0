Return-Path: <jivkojj@uni-kassel.de>
From: Zhivko Yordanov <jivkojj@uni-kassel.de>
To: Roderick Colenbrander <thunderbird2k@gmail.com>, Linuxppc-dev@ozlabs.org
Subject: Re: Looking for good supported South bridge for mpc6841d
Date: Thu, 16 Apr 2009 11:20:01 +0200
References: <200904151323.52505.jivkojj@uni-kassel.de>
	<c8485d470904150517p2ed7f27dn9cfd589eb6b7a0a6@mail.gmail.com>
In-Reply-To: <c8485d470904150517p2ed7f27dn9cfd589eb6b7a0a6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200904161120.01319.jivkojj@uni-kassel.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 15 April 2009 14:17:47 you wrote:
> On Wed, Apr 15, 2009 at 1:23 PM, Zhivko Yordanov <jivkojj@uni-kassel.de>=
=20
wrote:
> > Hello,
> >
> > I'm on designing of a new embedded board, based on mpc6841d and South
> > Bridge ULi M1575. As =D0=B0 reference design, I use Freescale HPCN boar=
d.
> > However after consult with chip's distributor, it became clear that the
> > M1575 is already discounted. Now I'm in looking of an another solution.
> > Can somebody recommend me an alternative, good supported from u-boot and
> > have SATA, USB, Audio on it? The chip must be connected with mpc6841d
> > over PCI-Express.
> >
> > Best regarsds,
> >
> > Yordanov
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
> I think the only alternatives you have are chips from Via and perhaps
> Sis. It looks like Via has some nice south bridges which do what you
> want, see:
> http://www.via.com.tw/en/products/chipsets/south-bridges.jsp
>
> Roderick

Thank you for the anser!

Unfortunately VIA and SIS uses own connection bus between North and Sout=20
bridges - V-map and MuTiol.
I found AMD's SB600 and SB7x0 bridges, that seems to connect through=20
PCI-Express. Are they from u-boot spupported?

Best regards
