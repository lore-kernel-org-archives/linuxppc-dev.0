Message-ID: <3ACB9EB3.2661FFCE@iiic.ethz.ch>
Date: Thu, 05 Apr 2001 00:22:43 +0200
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: "Jason E. Stewart" <jason@openinformatics.com>
Cc: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: External Monitor under Pismo
References: <20010404092143.EFE4C2F01B@apollo.valhalla.net> <3ACB537B.99B851B9@netfall.com> <87hf0433qs.fsf@amadeus.openinformatics.com> <3ACB6167.3B2E0242@iiic.ethz.ch> <878zlg31mw.fsf@amadeus.openinformatics.com> <3ACB9611.C95D16A2@iiic.ethz.ch> <87ae5w1ce3.fsf@amadeus.openinformatics.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Jason E. Stewart" wrote:

> > > Should I just use apt-get to grab the server source, or do I need Ani
> > > Joshi's tree especially?
> >
> > Both should be more or less equivalent. The best would of course be to get
> > it from CVS.
>
> Fine by me. What repository should I use,
>    anoncvs@anoncvs.xfree86.org:/cvs

Yes. Note that the current trunk doesn't contain CRTOnly anymore in "favour"
of a "UseBIOSDisplay" option (very portable ;). I suggest getting the
xf-4_0_2-branch .


> or is there a PPC specific tree I need?

There's only Ani's tree I know of, but the r128 driver is rather well
integrated in the official XFree86 so you shouldn't need it. And I personally
prefer submitting stuff upstream directly.


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
