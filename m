Date: Sun, 13 Aug 2000 11:06:34 -0500
Subject: atyfb problems?
From: Josh Kindler <josh@antihype.com>
To: <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B5BC31B9.2C74%josh@antihype.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hmm... I jsut got the latest (as of last night) rsync of Ben's kernel. When
I compiled it, I got the following error. Previous kernels compiled fine, is
this a known issue or am I just stupid?

atyfb.c:641: redefinition of `reset_GTC_3D_engine'
atyfb.c:631: `reset_GTC_3D_engine' previously defined here
{standard input}: Assembler messages:
{standard input}:525: Fatal error: Symbol reset_GTC_3D_engine already
defined.
atyfb.c: In function `atyfb_set_cmap':
atyfb.c:2318: Internal compiler error:
atyfb.c:2318: output pipe has been closed
cpp: output pipe has been closed
make[3]: *** [atyfb.o] Error 1
make[3]: Leaving directory `/usr/src/linux-pmac-benh/drivers/video'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-pmac-benh/drivers/video'
make[1]: *** [_subdir_video] Error 2
make[1]: Leaving directory `/usr/src/linux-pmac-benh/drivers'
make: *** [_dir_drivers] Error 2

Also I have an (AFAIK) unresolved airport problem:
I can compile it fine, but then when I insmod it i get:

airport.o: unresolved symbol isa_io_base


What is this all about?
--
Josh Kindler || antihype.com
ICQ#25956850 || AIM: joeschmo6
Linux users do it in the open.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
