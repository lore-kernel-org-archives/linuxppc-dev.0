Message-ID: <20011101211901.28548.qmail@dag.newtech.fi>
To: linuxppc-dev@lists.linuxppc.org
Subject: sym53c8xx broke in Bk kernel ?
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Date: Thu, 01 Nov 2001 23:19:01 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

just get the latest (well 2-day old) Bk devel tree
up and running on my SBS VG4 board here and
am having problems with the sym53c8xx driver.

The system just hangs if I use mmaped I/Oand generates
timeout errors if using non-mmapped I/O.

Reverting to the driver that worked on my previous port
(2.4.2-ac11) made everything work again, so I don't think there
is anything wrong with my setups etc.

Anyway wanted to ask, if anyone else have had problems here.

I will submit the port later on, when I have investigated this
problem a bit more and cleaned up the files here.

BTW. Is anyone using the MPC107 ? It is very strange that
I have to change the Openpic struct in a couple of places to
get it working on my board.... That shouldn't happen 8-o

Thanks to the guys cleaning up the PPC tree, it has been getting
increasingly easier to get things going... Perhaps the most still
needed change would be to move away the xxxx_setup.c and
xxxx_pci.c files from the generic kernel-files ??

BRGDS

--
Dag Nygren                               email: dag@newtech.fi
Oy Espoon NewTech Ab                     phone: +358 9 8024910
Träsktorpet 3                              fax: +358 9 8024916
02360 ESBO                              Mobile: +358 400 426312
FINLAND


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
