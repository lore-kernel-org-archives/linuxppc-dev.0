Message-ID: <3E2E30E9.5050305@tataelxsi.co.in>
Date: Wed, 22 Jan 2003 11:19:29 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: ppcboot for mpc8260ads board.
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I got my bdi2000, thanks to the cogent arguments supplied by WD.

Facing a problem.
1. Is it required to install ppcboot in an mpc8260ads board? If I make a
make bzImage , can the resultant image be directly loaded to flash and
start running it? the bdi2000 guys says that it is not possible. Is it so?
Does it mean that we have to port ppcboot and put it in out end product
for loading linux? we have only 8MB of flash.

2. I tried to coross compile ppcboot for mpc8260ads board.
make mpc8260ads_config does not work. In the readme, no such target is
supported. but in the  boards directory, there is a file for mpc8260ads
boards. I am confused and reading the makefile. But seems like a little
complex. if anybody can throw some light on compiling ppcboot for
mpc8260ads, it would be a great help.

Thanks
Om.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
