Date: Fri, 5 Feb 1999 14:59:44 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: David De Ridder <david.de.ridder@bitsmart.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC on MVME 2306 board
In-Reply-To: <3.0.6.32.19990201104813.00804be0@hsins.uia.ac.be>
Message-ID: <Pine.HPP.3.96.990205145755.21099E-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




	Hi David,

I've just put a fiel with a kernel which boots with root on NFS on my
machine (MVME2601), it is at:

        ftp://vcorr1.iram.es/pub/linux-2.2/zImage.nfsroot-2.2.1

at the prompt on the serial line, you have to type:

Linux/PPC load: console=ttyS0 root=/dev/nfs

actually you only have to type the last parameter since console=ttyS0 is
automagically added when no graphics board is found.
  
        Gabriel.
P.S: of course you've to setup a bootp server and an NFS server. We can
discuss further privately about init scripts ans so on...



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
