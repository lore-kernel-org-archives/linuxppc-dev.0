Message-Id: <367FC8D2.3DFEFBC0@newbridge.com>
Date: Tue, 22 Dec 1998 15:29:06 -0100
From: christophe Jauffret <cjauffre@newbridge.com>
Reply-To: jauffr_c@epita.fr
MIME-Version: 1.0
To: linuxppc dev list <linuxppc-dev@lists.linuxppc.org>
Subject: pci bridge problem 
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



i have a ZNYX 348 ethernet card who is a Dec pci bridge and two or four
dev 21140 digital chips

they function very well on MacOS
but on LinuxPPC
the system don't see the two ethernet card but only the DEC bridge
are there some special option to check in the kernel

other problem from kernel 2.1.129 i can't load module

i have modutils 121
egcs 1.0b

some idea are welcome ?
-- 
(°>     Jauffret Christophe 
//\     jauffr_c@epita.fr
v_/_    Powered by Clux ;-)

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
