Message-ID: <3BD9B30C.929F4747@midrivers.com>
Date: Fri, 26 Oct 2001 13:01:32 -0600
From: Mark Pilon <mpilon@midrivers.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: will the real ppc kernel please stand up
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I know we've been over this before, but I was following some
advice to get the latest development kernel via pengiunppc.org, via
rsync:

rsync -avz --delete source.mvista.com::<tree> <directory>,
where <tree> is one of:

                        linuxppc_2_4
                        linuxppc_2_4_devel

naively hoping to get something stable, I pulled linuxppc_2_4, configured
it for ppc4xx / walnut and attempted to build it.  no luck:
powerpc-linux-gcc -D__KERNEL__
-I/home/mpilon/ppc_tools/BUILDS/linuxppc_2_4/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char -msoft-float
-pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -mcpu=403    -c -o
ppc4xx_pic.o ppc4xx_pic.c
{standard input}: Assembler messages:
{standard input}:83: Error: unsupported relocation type
{standard input}:84: Error: unsupported relocation type
{standard input}:111: Error: unsupported relocation type
{standard input}:128: Error: unsupported relocation type
{standard input}:145: Error: unsupported relocation type
{standard input}:149: Error: unsupported relocation type
{standard input}:64: Error: unsupported relocation type
make[1]: *** [ppc4xx_pic.o] Error 1

does anyone know where & how to get a reasonably recent snapshot of
the development tree which builds?

"reasonably recent" could be a month or 2 old ... I'd rather have
something which builds and runs than the bleeding edge ...

Mark

--
Mark Pilon

Minolta-QMS
P.O. Box 37
Fallon, MT.  59326-0037

1-406-853-0433

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
