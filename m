Message-Id: <3.0.6.32.19990201104813.00804be0@hsins.uia.ac.be>
Date: Mon, 01 Feb 1999 10:48:13 +0100
To: linuxppc-dev@lists.linuxppc.org
From: David De Ridder <david.de.ridder@bitsmart.com>
Subject: LinuxPPC on MVME 2306 board
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi everyone,

at the lab we have an MVME 2306 board, and for the past 6 months I have
been trying to run Linux on it.

As I understand from some messages in this list, several people have
been able to run LinuxPPC on such boards.

We have an additional handicap : the board must be booted completely off
our local net. We cannot use a SCSI drive, because the two PMC slots need
to stay available for future lab applications.

I already have the BOOTP/TFTP configured right, so I can load a
kernel into the board over our network. This works perfectly with
'dummy' kernels, they let the board crash, as expected.
I also set up NFS, to provide a root filesystem when necessary.

Still, there are several problems, and therefore these questions :

1) Does LinuxPPC run on such boards ? Does anyone run LinuxPPC on an
   MVME230x(5/6/7/8) *without* a hard disk (and with NFS) ?
2) Since we don't have a spare developer PPC machine, is it possible
   to crosscompile the LinuxPPC kernel from the standard Linux sources
   on an Intel based machine ? I tried it and had problems with an
   unfound 'semaphore.h' file.

I am willing to put serious effort in this matter (and I already have),
but is there a precompiled kernel around somewhere that I could
download into the board to _prove_ it works ?
(Such a kernel needs CONFIG_ECHO_SERIAL support.) I don't care if it
is unable to find a root filesystem etc., I just would be glad to
demonstrate that LinuxPPC _is_ a viable solution, and then I can look
further into it.

If you can provide suggestions, comments or pointers, please respond.

Thanks in advance,

David De Ridder - University of Antwerp (Belgium)

+-----------------------------------------------------------------+
  David 'Septimus' De Ridder       <david.de.ridder@bitsmart.com> 

"It would not have been 60 attacks in 50 years, 
 but one each minute, and nothing would stop them."
 - ITV 'Shark Attack' Special

+-----------------------------------------------------------------+
  


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
