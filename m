Message-ID: <007301c4544e$1dc24630$2700000a@jmartin>
From: "jmartin" <jmartin@prodys.net>
To: "m madhuker" <mythri_madhuker@yahoo.com>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <20040617085836.82148.qmail@web13602.mail.yahoo.com>
Subject: Re: NFS probelm in MPC8245
Date: Thu, 17 Jun 2004 11:33:15 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


----- Original Message -----
From: "m madhuker" <mythri_madhuker@yahoo.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Thursday, June 17, 2004 10:58 AM
Subject: NFS probelm in MPC8245


>
> Hello all,
>          Iam working with MPC8245 in Linux.but im new
> to this. Kernel was booted into board and we able to
> do ping,telnet,ftp to board. but, i could not able to
> mount NFS in board.
you need nfs daemon running.

add nfs daemon to sbin if you don't yet.
then execute /etc/init.d/nfs start or /etc/init.d/nfs restart

nfs should appear now when ps axvf is executed.

execute mount -t nfs [ip]:/resource localdir

be sure [ip_remote_machine_which_do_mount]:/resource exists on file
/etc/exports on remote machine.

i.e, if machine which is mounting resource have ip x.y.z.t
you will have an entry on /etc/export like this

/resource    x.y.z.t(rw,no_root_squash)

if you haven't got it, write it and then execute /etc/init.d/nfs restart on
machine which export resource


>Rfs also not mounting. i had tried
> as per the "Getting started timesys linux on Ampro
> Encore PP1" doc. and i search in google also, but
> progress...
> please can anybody help me....
>                                           Regards
>                                           Madhukar
>                                           Kosmic Tech.
>                                           Chennai, India.
>
>
>
> Yahoo! Mail - Helps protect you from nasty viruses.
> http://promotions.yahoo.com/new_mail
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
