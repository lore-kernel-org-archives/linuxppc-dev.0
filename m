Date: Tue, 4 Dec 2001 12:17:00 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: mod+linuxppc-dev@MissionCriticalLinux.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: GEVB serial.c botch in current sources
Message-ID: <20011204191700.GT17651@cpe-24-221-152-185.az.sprintbbd.net>
References: <200112041857.NAA05795@missioncriticallinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200112041857.NAA05795@missioncriticallinux.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Dec 04, 2001 at 01:57:57PM -0500, mod+linuxppc-dev@MissionCriticalLinux.com wrote:
>
> The build breaks thus when config'd for Galileo EVB:
>
> gcc -D__KERNEL__ -I/usr/src/linuxppc2.4.17pre1.20011203/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring    -c -o serial.o serial.c
> In file included from /usr/src/linuxppc2.4.17pre1.20011203/include/asm/serial.h:15,
>                  from serial.c:183:
> /usr/src/linuxppc2.4.17pre1.20011203/include/asm/platforms/ev64260_serial.h:20: ../../arch/ppc/platforms/ev64260.h: No such file or directory

Arg.  This is why relative includes are bad.  I just fixed this.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
