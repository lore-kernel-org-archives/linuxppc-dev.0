Date: Wed, 26 May 1999 10:58:54 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: ioctl 0x7667 in Xpmac
Message-ID: <Pine.LNX.4.10.9905261056360.7373-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Can the people responsible for Xpmac please change the error message

| Fatal server error
| ioctl 0x7667 failed: invalid argument.

into

| Fatal server error
| ioctl 0x7667 failed: invalid argument (do you have a PowerMac?).

or something like that.

Many people install LinuxPPC on APUS (the second most popular Linux/PPC
platform these days), and Xpmac is obviously not meant for non-PowerMacs.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
