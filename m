Date: Wed, 10 Mar 1999 15:26:21 +0100
From: Hubert Figuiere <hub@point-barre.fr>
To: LinuxPPC Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Sound drops
Message-ID: <19990310152621.H896@giordino.point-barre.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I don't like to work in silence, so I usually play back a 
bunch of mp3 with xaudio under Linux PPC from my PowerBook.

The problem is that I get a lot of sound drops like if the machine
were "mono-tasking". I have never had this with PC hardware under Linux.

It appears that those drops occurs when doing intensive graphics like
a Netscape redrawing or a huge text scroll within an xterm. This happens
with Xpmac or XFB_Dev.

Kernel is 2.2.1 home compiled (with or without my patches), and machine 
is PowerBook 3400c with 80 MB of RAM.

My question is: Is it a known bug of the sound drivers or is it a 
hardware limitation ?

Hub
-- 
World Wide Wait: the real meaning for WWW.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
