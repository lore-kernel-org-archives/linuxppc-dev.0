Message-ID: <000d01c32ad8$490fca60$6706a8c0@SPLENDOR>
From: "Rupesh S" <rupeshs@myw.ltindia.com>
To: "linuxppc-embedded" <linuxppc-dev@lists.linuxppc.org>
References: <Law14-OE57bZ2ntWEqp00015e5b@hotmail.com> <200305202151.02291.ppc339@vtnet.ca>
Subject: Ethernet support for FADS board (MPC823)
Date: Wed, 4 Jun 2003 13:31:32 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
I work with a FADS823 board. I use u-boot as my bootloader,I downloaded the
ppc kernel from Montavista using rsync. I compiled my kernel with minimal
configurations .It boots and works well on board.
Now that I am trying to add more features like Ethernet support etc etc..
I understand that in our board (FADS823) the Ethernet is on SCC2.When I
configure my kernel for the same in CPM iOptions, it gives me the following
error,

/***************************************************************************
****************************************************************************
**/
make[2]: Entering directory
`/home/rupesh/PPC-Installs/RSYNC/Montavista/linux/arch/ppc/8xx_io'
ppc-linux-gcc -D__KERNEL__ -I/home/rupesh/PPC-Installs/RSYNC/Montavista/linu
x/include -I/usr/lib/gcc-lib/ppc-linux/2.95.4/include/ -Wall -Wstrict-protot
ypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointe
r -I/home/rupesh/PPC-Installs/RSYNC/Montavista/linux/arch/ppc -fsigned-char
-msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -mcpu=8
60   -nostdinc -iwithprefix include -DKBUILD_BASENAME=enet  -c -o enet.o
enet.c
enet.c:699: #error Exactly ONE pair of PA_ENET_[RT]XD, PB_ENET_[RT]XD must
be defined
enet.c:904: #error Configuration Error: define exactly ONE of PB_ENET_TENA,
PC_ENET_TENA
enet.c: In function `scc_enet_init':
enet.c:713: `PC_ENET_CLSN' undeclared (first use in this function)
enet.c:713: (Each undeclared identifier is reported only once
enet.c:713: for each function it appears in.)
enet.c:713: `PC_ENET_RENA' undeclared (first use in this function)
enet.c:719: `PA_ENET_TCLK' undeclared (first use in this function)
enet.c:719: `PA_ENET_RCLK' undeclared (first use in this function)
enet.c:725: `SICR_ENET_MASK' undeclared (first use in this function)
enet.c:726: `SICR_ENET_CLKRT' undeclared (first use in this function)
enet.c:929: `PB_ENET_TENA' undeclared (first use in this function)
make[2]: *** [enet.o] Error 1
make[2]: Leaving directory
`/home/rupesh/PPC-Installs/RSYNC/Montavista/linux/arch/ppc/8xx_io'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory
`/home/rupesh/PPC-Installs/RSYNC/Montavista/linux/arch/ppc/8xx_io'
make: *** [_dir_arch/ppc/8xx_io] Error 2

/***************************************************************************
****************************************************************************
**/

When I see the comproc.h file, these Macros aen't defined for FADS Board..
What do I do?
Any clues ?

Rupesh

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
