MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Resolved: Console not appearing with iBook and 2.4.8-pre8
Date: Wed, 15 Aug 2001 08:06:09 +0200
Message-ID: <2C5637A6A7CE844EA3C0A94565479F520B470F@dest-as20-002.int.bauer-partner.com>
From: "Halfmann, Klaus" <Klaus.Halfmann@bauer-partner.com>
To: <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


benh@kernel.crashing.org wrote at Freitag, 10. August 2001 21:44
> >
> >This morning I build a fresh kernel from the bk-repository
> >on my (old) iBook. I did a
> >
> >	make oldconfig depend vmlinux modules modules_install
> >
> >When booting the last message is the "prom_init" message
> >in the yaboot screen. After that no console appears.
> > ...
>
> Make sure you enable the new atyfb in the config.
> ...

Yep, choosing the second of the two (new) aty submodes
made it work again, thanks.

Klaus Halfmann, http://www.penguinppc.org/~hasi

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
