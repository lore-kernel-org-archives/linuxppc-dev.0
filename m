Date: Wed, 26 Apr 2000 15:12:03 +0200
From: Bernhard Reiter <bernhard@intevation.de>
To: Mario Scarpa <m.scarpa@mondonet.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard hard freeze
Message-ID: <20000426151203.K2544@cheops.usf.Uni-Osnabrueck.DE>
References: <20000424161311.23404.qmail@web1705.mail.yahoo.com>
	<20000424191708.C16557@cheops.usf.Uni-Osnabrueck.DE>
	<39058B20.7D29A470@mondonet.net>
	<20000425144459.E22219@cheops.usf.Uni-Osnabrueck.DE>
	<390594BF.97FD809E@mondonet.net>
	<20000426142256.J2544@cheops.usf.Uni-Osnabrueck.DE>
	<3906E33F.89D2E839@mondonet.net>
Mime-Version: 1.0
In-Reply-To: <3906E33F.89D2E839@mondonet.net>; from m.scarpa@mondonet.net on Wed, Apr 26, 2000 at 11:38:23AM -0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Apr 26, 2000 at 11:38:23AM -0100, Mario Scarpa wrote:
> > The first diagostic of the problem is, that it is a usb problem.
>
> I would say the _very first_ ;-)

Hey, I am glad I got that figured out so far.
It is a big step in tracking down the problem.  ;->

> I noticed another interesting thing: the freeze almost always
> happened whit heavy network activity. All the tries to reproduce
> the problem failed for now (as usual, when you dload something
> not useful ;)). Will keep on trying.

I can say for sure that I had no network activity, though I
I was plugged in the ethernet. (If I remember correctly I
had the freezes even when not being physically connected.)

The best way for me to reproduce the problem is to
try to compile the gnomehack-1.0.5.src.rpm a couple of times.
Usually it bombs in the second attempt. Or in the first one.

	Bernhard
--
Professional Service around Free Software                (intevation.net)
The FreeGIS Project				            (freegis.org)
Association for a Free Informational Infrastructure            (ffii.org)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
