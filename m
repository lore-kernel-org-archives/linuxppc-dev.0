Message-Id: <200210210834.KAA05195@ipnmail.in2p3.fr>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Xavier Grave <grave@ipno.in2p3.fr>
To: Ethan Benson <erbenson@alaska.net>
Subject: Re: install with Debian CD ok, but can't boot any kernel
Date: Mon, 21 Oct 2002 10:31:16 +0200
References: <200210181610.SAA19888@ipnmail.in2p3.fr> <3DB0D2E7.57F51578@koffie.nl> <20021019071551.GW27982@plato.local.lan>
In-Reply-To: <20021019071551.GW27982@plato.local.lan>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

If I do this everithings goes right !
> boot ultra2:2,\yaboot

> once in yaboot enter:
>
> ultra2:3,/vmlinux root=/dev/hda3 ro
ultra2:4,/vmlinux root=/dev/hda4 ro
> that assumes the bootstrap partition is 2 and root 3.
my bootstrap partition is 2 and root is 4 (the third one is swap)

Thanks !

xavier, a happy mac linux addict...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
