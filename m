Message-ID: <24913-74602@sneakemail.com>
Date: Thu, 10 Jun 2004 15:39:37 -0700
From: "Stephen Williams" <612dlag102@sneakemail.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: bk pull of linuxppc-2.4 doesn't compile
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


net/ipv4/tcp_input.c seems to have received from davem a change
that caused it to not compile. The error message is:

ppc_4xx-gcc -D__KERNEL__
-I/home/u/wing/steve/picturel/jse/3rdparty/bk/linuxppc-2.4/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -I/home/u/wing/steve/picturel/jse/3rdparty/bk/linuxppc-2.4/arch/ppc
-fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring
-Wa,-m405   -nostdinc -iwithprefix include -DKBUILD_BASENAME=tcp_input  -c -o tcp_input.o
tcp_input.c
tcp_input.c: In function `tcp_rcv_space_adjust':
tcp_input.c:479: structure has no member named `sk_rcvbuf'
tcp_input.c:480: structure has no member named `sk_rcvbuf'

It appears that some stuff is being incompletely imported from 2.6?

--
Steve Williams                "The woods are lovely, dark and deep.
steve at XXXXXXXXXX           But I have promises to keep,
http://www.XXXXXXXXXX         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
