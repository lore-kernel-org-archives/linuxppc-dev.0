Message-ID: <008001c4545d$c6413370$2700000a@jmartin>
From: "jmartin" <jmartin@prodys.net>
To: "bharat" <bharat@coraltele.com>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <20040617085836.82148.qmail@web13602.mail.yahoo.com> <007301c4544e$1dc24630$2700000a@jmartin> <200406171555.51500.bharat@coraltele.com>
Subject: Re: NFS probelm in MPC8245
Date: Thu, 17 Jun 2004 13:25:20 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


just rigth. Sorry, i forget it. If nfs don't want to work yet, check you
have
loopback interface up, nfs communicate on machine accross loopback
interface.

this should be done with
ifconfig lo add 127.0.0.1 up

----- Original Message -----
From: "bharat" <bharat@coraltele.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Thursday, June 17, 2004 12:25 PM
Subject: Re: NFS probelm in MPC8245


>
> the gentleman is quite right abt starting nfs
> but also check portmap service should also work
> otherwise  you cannot start nfs
> bye
>
> On Thursday 17 Jun 2004 3:03 pm, jmartin wrote:
> > ----- Original Message -----
> > From: "m madhuker" <mythri_madhuker@yahoo.com>
> > To: <linuxppc-embedded@lists.linuxppc.org>
> > Sent: Thursday, June 17, 2004 10:58 AM
> > Subject: NFS probelm in MPC8245
> >
> > > Hello all,
> > >          Iam working with MPC8245 in Linux.but im new
> > > to this. Kernel was booted into board and we able to
> > > do ping,telnet,ftp to board. but, i could not able to
> > > mount NFS in board.
> >
> > you need nfs daemon running.
> >
> > add nfs daemon to sbin if you don't yet.
> > then execute /etc/init.d/nfs start or /etc/init.d/nfs restart
> >
> > nfs should appear now when ps axvf is executed.
> >
> > execute mount -t nfs [ip]:/resource localdir
> >
> > be sure [ip_remote_machine_which_do_mount]:/resource exists on file
> > /etc/exports on remote machine.
> >
> > i.e, if machine which is mounting resource have ip x.y.z.t
> > you will have an entry on /etc/export like this
> >
> > /resource    x.y.z.t(rw,no_root_squash)
> >
> > if you haven't got it, write it and then execute /etc/init.d/nfs restart
on
> > machine which export resource
> >
> > >Rfs also not mounting. i had tried
> > > as per the "Getting started timesys linux on Ampro
> > > Encore PP1" doc. and i search in google also, but
> > > progress...
> > > please can anybody help me....
> > >                                           Regards
> > >                                           Madhukar
> > >                                           Kosmic Tech.
> > >                                           Chennai, India.
> > >
> > >
> > >
> > > Yahoo! Mail - Helps protect you from nasty viruses.
> > > http://promotions.yahoo.com/new_mail
> >
> >
> >
> >
> >
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
