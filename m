Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Networking problems, linuxppc2.4, RPX CLLF, Montavista
Date: Fri, 4 May 2001 09:54:57 +0200
Message-ID: <000a01c0d46f$83b7c0d0$0a01a8c0@Win1>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all

I have this strange network problem and I can not figure out whats wrong.

I running linuxppc2.4 from Cort's tree on a RPX CLLF(cpu PPC860T) and a file
system
from the Montavista CDK 1.2(with the latest updates). I NFS mount my root
fs, created a
local user(I can login on my local user). Ping works both ways(from RPX to
my Linux host
and vice versa).

But I can not telnet or ftp from my linux host to RPX, I get "connection
refused"(inetd is
running on RPX) and if I telnet(or ftp) from RPX to my Linux host it takes
1-2 minutes
until I get a login prompt.

BUT if I boot the 2.2.14 kernel that came with the Montavista CDK 1.2
everything works!

I have no idea what I am doing wrong. I have searched all www & mailing
lists I can think of
but I seem to alone with this problem.

Please help.

       Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
