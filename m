Date: Thu, 26 Jul 2001 20:19:43 +1200
From: Gwyn Judd <b.judd@xtra.co.nz>
To: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: no sound with 2.4.7
Message-ID: <20010726201943.A1195@thislove>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I got this with a kernel I compiled with myself and similar symptoms
with other kernels I downloaded from linuxppc.org.

[root@thislove sound]# /sbin/modprobe dmasound_pmac
/lib/modules/2.4.7/kernel/drivers/sound/dmasound/dmasound_pmac.o:
unresolved symbol nvram_read_byte
/lib/modules/2.4.7/kernel/drivers/sound/dmasound/dmasound_pmac.o: insmod
/lib/modules/2.4.7/kernel/drivers/sound/dmasound/dmasound_pmac.o failed
/lib/modules/2.4.7/kernel/drivers/sound/dmasound/dmasound_pmac.o: insmod
dmasound_pmac failed

--
Gwyn Judd (b.judd@xtra.co.nz)
Men love to wonder, and that is the seed of science.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
