Date: Thu, 9 Nov 2000 23:13:31 -0700 (MST)
From: Derrik Pates <dpates@andromeda.dsdk12.net>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: AWACS sound support with 2.4.0-test10 from linuxcare.com
Message-ID: <Pine.LNX.4.30.0011092241110.17067-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The AWACS support does noto work - if built in, it'll pick up an IRQ, and
play about a half-second of sound if you try to use mpg123 with it. If I
try to load it as a module, the init fails, then less thank 30 seconds
after, it dies to a boot monitor. Is there a fix for this anywhere? I'l
like to be able to use sound with this machine.

(This is on a Blue and white G3/250 tower.)

Derrik Pates      | Sysadmin, Douglas School|    _   #linuxOS on EFnet
dpates@dsdk12.net |  District (dsdk12.net)  |   | |   and now OPN too!
   Student @ South Dakota School of Mines   | __| |___ _ _ _   ___ _ _   ____
       & Technology (www.sdsmt.edu)         |/ _  / -_) ' \ '\/ _ \ ' \ (____)
UNIX: Because you want to USE your computer.|\___,\___|_||_||_\___/_||_|


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
