Date: Tue, 30 Mar 1999 17:16:50 -0500 (EST)
From: John Buswell <johnb@one.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.2.5 on an iMac
Message-ID: <Pine.LNX.3.96.990330171259.15352z-100000@shell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi.

i'm trying to compile a 2.2.5 kernel for my iMac running LinuxPPC pre-R5.
I did the following :

applied kbd-final-2.2.0 and uusbd-199901xxxx to linux-2.2.0
then patched up to 2.2.5 and eventually make vmlinux

Everything compiled fine but when I try to boot it (by putting vmlinux in
the same directory as bootx) it sits there at after it detects the ide
devices.

I guess I'm missing a patch or two :) can anyone help me out?

thanks


John Buswell
Systems Administrator
OneNet Communications, Inc.
(513) 618-1000 - johnb@one.net


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
