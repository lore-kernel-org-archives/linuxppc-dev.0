Message-Id: <200112041857.NAA05795@missioncriticallinux.com>
From: mod+linuxppc-dev@MissionCriticalLinux.com
To: linuxppc-dev@lists.linuxppc.org
Subject: GEVB serial.c botch in current sources
Date: Tue, 04 Dec 2001 13:57:57 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The build breaks thus when config'd for Galileo EVB:

gcc -D__KERNEL__ -I/usr/src/linuxppc2.4.17pre1.20011203/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring    -c -o serial.o serial.c
In file included from /usr/src/linuxppc2.4.17pre1.20011203/include/asm/serial.h:15,
                 from serial.c:183:
/usr/src/linuxppc2.4.17pre1.20011203/include/asm/platforms/ev64260_serial.h:20: ../../arch/ppc/platforms/ev64260.h: No such file or directory


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
