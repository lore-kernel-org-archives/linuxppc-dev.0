Message-ID: <3AF659BF.275A6A51@relog.ch>
Date: Mon, 07 May 2001 10:15:59 +0200
From: Michel =?iso-8859-1?Q?D=E4nzer?= <daenzer@relog.ch>
Reply-To: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: "Jason E. Stewart" <jason@openinformatics.com>
Cc: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Success! (was Re: External Monitor under Pismo)
References: <20010404092143.EFE4C2F01B@apollo.valhalla.net>
		<3ACB537B.99B851B9@netfall.com>
		<87hf0433qs.fsf@amadeus.openinformatics.com>
		<3ACB6167.3B2E0242@iiic.ethz.ch>
		<878zlg31mw.fsf@amadeus.openinformatics.com>
		<3ACB9611.C95D16A2@iiic.ethz.ch>
		<87ae5w1ce3.fsf@amadeus.openinformatics.com>
		<3ACB9EB3.2661FFCE@iiic.ethz.ch>
		<87u242zz7y.fsf@amadeus.openinformatics.com>
		<3ACCFFBB.58CC75D2@iiic.ethz.ch>
		<87itjmf7lf.fsf_-_@amadeus.openinformatics.com>
		<3AEDEF2D.4B823134@iiic.ethz.ch>
		<87wv7x984o.fsf@amadeus.openinformatics.com>
		<3AF1D91F.7030801@iiic.ethz.ch>
		<87hez1pjm1.fsf@amadeus.openinformatics.com>
		<3AF29AF6.9AC80F3E@iiic.ethz.ch>
		<87hez1hw97.fsf@amadeus.openinformatics.com>
		<3AF35975.30456155@iiic.ethz.ch>
		<87wv7wjfu4.fsf@amadeus.openinformatics.com>
		<3AF43F7E.E3F2C682@iiic.ethz.ch>
		<87oft7cxc5.fsf@amadeus.openinformatics.com>
		<3AF5527F.ED85C413@iiic.ethz.ch> <87d79mi1mv.fsf@amadeus.openinformatics.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Jason E. Stewart" wrote:
>
> "Michel Dänzer" <michdaen@iiic.ethz.ch> writes:
>
> > > Still fails. Log attached.
> >
> > It tries to initialize int10 which can't work for us yet. Try Option
> > "NoInt10" (hasn't worked for me yet) or move away libint10.a .
>
> I moved libint10.a to libint10.a.bak and it still fails. log attached.

Hmm, haven't seen that.

What happens with Option "UseFBDev"?

Sorry this is such a PITA, maybe we should take this off-list...


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
