Date: Mon, 1 Feb 1999 14:13:55 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: David De Ridder <david.de.ridder@bitsmart.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC on MVME 2306 board
In-Reply-To: <3.0.6.32.19990201104813.00804be0@hsins.uia.ac.be>
Message-ID: <Pine.HPP.3.96.990201140400.16636D-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Mon, 1 Feb 1999, David De Ridder wrote:

> 
> Hi everyone,
> 
> at the lab we have an MVME 2306 board, and for the past 6 months I have
> been trying to run Linux on it.

I have several 26xx running Linux/PPC, of course the 26xx has a SCSI
interface and a hard disk for development.

> 
> As I understand from some messages in this list, several people have
> been able to run LinuxPPC on such boards.

At least simliar ones, I don't remember exactly what the 230x has. But as
long as it has a DEC21x4x Ethernet, there should not be any problem...

> We have an additional handicap : the board must be booted completely off
> our local net. We cannot use a SCSI drive, because the two PMC slots need
> to stay available for future lab applications.

I originally booted my 2601 with root on NFS (no HD), with kernels cross
compiled from a PC. 

> I already have the BOOTP/TFTP configured right, so I can load a
> kernel into the board over our network. This works perfectly with
> 'dummy' kernels, they let the board crash, as expected.
> I also set up NFS, to provide a root filesystem when necessary.
> 
> Still, there are several problems, and therefore these questions :
> 
> 1) Does LinuxPPC run on such boards ? Does anyone run LinuxPPC on an
>    MVME230x(5/6/7/8) *without* a hard disk (and with NFS) ?

Yes, at least it did a few months ago. And I plan to do it again befire
putting my MVME2600 in production (they won't have a disk in this case).

> 2) Since we don't have a spare developer PPC machine, is it possible
>    to crosscompile the LinuxPPC kernel from the standard Linux sources
>    on an Intel based machine ? I tried it and had problems with an
>    unfound 'semaphore.h' file.
> 

Yes, you'll need a rather recent egcs version. 

> I am willing to put serious effort in this matter (and I already have),
> but is there a precompiled kernel around somewhere that I could
> download into the board to _prove_ it works ?
> (Such a kernel needs CONFIG_ECHO_SERIAL support.) I don't care if it
> is unable to find a root filesystem etc., I just would be glad to
> demonstrate that LinuxPPC _is_ a viable solution, and then I can look
> further into it.
> 
> If you can provide suggestions, comments or pointers, please respond.

I have put an untested zImage on my ftp server (I want to test it soon):

ftp://vcorr1.iram.es/pub/linux-2.2/zImage.nfsroot-2.2.0

I'm working on other improvements right now (and I've got a Universe
driver close to working, DMA is still missing). 

	Regards,
	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
