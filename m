Message-Id: <v04003a00b29e0319bdf3@[205.161.35.44]>
In-Reply-To: 
 <Pine.LNX.4.03.9812141143100.17418-100000@mercator.cs.kuleuven.ac.be>
References: <19981214105418.022383@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 16 Dec 1998 19:49:27 -0500
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        linuxppc-dev@lists.linuxppc.org
From: Douglas Godfrey <dvdoug@tiac.net>
Subject: Re: Restructure of arch/ppc/kernel and include/asm-ppc
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Power MachTen implements a Unix Filesystem on top of the Mac HFS filesystem.
There are restrictions on path length, file/filder names and non alphanumeric
characters allowed in Unix files to allow mapping unix files to Mac OS files.
The main restrictions are 32byte name length limit and the mapping of the
":" <--> "/" and problems with files that start with "." (Norton Utilities
will remove the "." thereby breaking the Unix file system).

Linux could then co-exist with the Mac OS with the Linux Scheduler and Memory
Management system taking over forom the Mac OS (each Mac OS task becomes a
Linux task with protected memmory). This is how MachTen for the 68k worked.

At 5:43 AM -0500 12/14/98, Geert Uytterhoeven wrote: [Re: Restructure of
arch/ppc/kernel and include/asm-ppc]
>On Mon, 14 Dec 1998, Benjamin Herrenschmidt wrote:
>> Another thing that Paul and I are trying to define and implement: A way
>> to completely boot from a disk image on the HFS volume (and eventually
>> use this image as the read/write root volume). This would allow
>> installations of Linux on top of macos without reformatting &
>> repartitioning the hard disk.
>
>Thus a generalization of umsdosfs, the UNIX-like fs on top os msdosfs? I think
>something like that already exists, read about it on linux-kernel some time
>ago.
>
>Greetings,
>
>						Geert

Thanx...
  Doug


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
