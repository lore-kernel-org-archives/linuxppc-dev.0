Date: Mon, 21 Oct 2002 00:42:33 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: install with Debian CD ok, but can't boot any kernel
Message-ID: <20021021084233.GD31739@plato.local.lan>
References: <200210181610.SAA19888@ipnmail.in2p3.fr> <3DB0D2E7.57F51578@koffie.nl> <20021019071551.GW27982@plato.local.lan> <200210210834.KAA05195@ipnmail.in2p3.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200210210834.KAA05195@ipnmail.in2p3.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Oct 21, 2002 at 10:31:16AM +0200, Xavier Grave wrote:
> Hi !
>
> If I do this everithings goes right !
> > boot ultra2:2,\yaboot
>
> > once in yaboot enter:
> >
> > ultra2:3,/vmlinux root=/dev/hda3 ro
> ultra2:4,/vmlinux root=/dev/hda4 ro
> > that assumes the bootstrap partition is 2 and root 3.
> my bootstrap partition is 2 and root is 4 (the third one is swap)
>
> Thanks !

no problem.  see you don't need macos to fix a goobered yaboot.conf.

> xavier, a happy mac linux addict...

until i get ofpath fixed you can add:

ofboot=ultra2:
device=ultra2:

to /etc/yaboot.conf, after ofpath is fixed you can remove the ofboot=
line.  rerun ybin and things will work fine without manual fsckery.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
