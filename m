Date: Mon, 1 Feb 1999 11:30:45 -0700 (MST)
From: Matt Porter <mmporter@home.com>
To: David De Ridder <david.de.ridder@bitsmart.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC on MVME 2306 board
In-Reply-To: <3.0.6.32.19990201104813.00804be0@hsins.uia.ac.be>
Message-ID: <Pine.LNX.3.96.990201112416.32358A-100000@liberty.chnd1.az.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 1 Feb 1999, David De Ridder wrote:

> Hi everyone,
> 
> at the lab we have an MVME 2306 board, and for the past 6 months I have
> been trying to run Linux on it.
> 
> As I understand from some messages in this list, several people have
> been able to run LinuxPPC on such boards.
> 
> We have an additional handicap : the board must be booted completely off
> our local net. We cannot use a SCSI drive, because the two PMC slots need
> to stay available for future lab applications.
> 
> I already have the BOOTP/TFTP configured right, so I can load a
> kernel into the board over our network. This works perfectly with
> 'dummy' kernels, they let the board crash, as expected.
> I also set up NFS, to provide a root filesystem when necessary.
> 
> Still, there are several problems, and therefore these questions :
> 
> 1) Does LinuxPPC run on such boards ? Does anyone run LinuxPPC on an
>    MVME230x(5/6/7/8) *without* a hard disk (and with NFS) ?

I nfsroot an MVME230x (among others) off a LinuxPPC blackhawk box for
testing and use those binaries without a problem...so the answer is yes.

> 2) Since we don't have a spare developer PPC machine, is it possible
>    to crosscompile the LinuxPPC kernel from the standard Linux sources
>    on an Intel based machine ? I tried it and had problems with an
>    unfound 'semaphore.h' file.

See my page on this at http://members.home.net/mmporter/linux.html
There are instructions for building cross tools plus .debs and .rpms.

> I am willing to put serious effort in this matter (and I already have),
> but is there a precompiled kernel around somewhere that I could
> download into the board to _prove_ it works ?
> (Such a kernel needs CONFIG_ECHO_SERIAL support.) I don't care if it
> is unable to find a root filesystem etc., I just would be glad to
> demonstrate that LinuxPPC _is_ a viable solution, and then I can look
> further into it.

I see Gabriel covered this in his response.

--
Matt Porter
mmporter@home.com
Unix is a Linux-like operating system.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
