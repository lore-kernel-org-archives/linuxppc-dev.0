Date: Thu, 26 Jul 2001 09:42:45 +0100
Subject: Re: no sound with 2.4.7
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Gwyn Judd <b.judd@xtra.co.nz>,
	LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Cc: jcarr@mail.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010726084227.6A5FEDB9DD@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Gwyn,

> I got this with a kernel I compiled with myself and similar symptoms
> with other kernels I downloaded from linuxppc.org.
>
> [root@thislove sound]# /sbin/modprobe dmasound_pmac
> /lib/modules/2.4.7/kernel/drivers/sound/dmasound/dmasound_pmac.o:
> unresolved symbol nvram_read_byte
> /lib/modules/2.4.7/kernel/drivers/sound/dmasound/dmasound_pmac.o: insmod
> /lib/modules/2.4.7/kernel/drivers/sound/dmasound/dmasound_pmac.o failed
> /lib/modules/2.4.7/kernel/drivers/sound/dmasound/dmasound_pmac.o: insmod
> dmasound_pmac failed

the current BK tree version has a call to this function which is (IIUC)
obsolete ...

I'll talk to Ben about getting more of the new stuff pushed (I think he's
away at the moment).

---

In the mean time - could you try either Ben H's rsync tree

penguinppc.org::linux-2.4-benh

or apply my latest patches:

ftp://ftp.penguinppc.org/users/iain/kernel/2_4_x/2.4.7p8-dmasound/dmas-2.4.7
p8.diff.bz2

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
