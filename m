Date: Tue, 2 Mar 1999 14:45:18 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: loopback <david.de.ridder@bitsmart.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel boot arguments over network
In-Reply-To: <Pine.SO4.4.05.9903021429260.12290-100000@hsins.uia.ac.be>
Message-ID: <Pine.HPP.3.96.990302143829.3871e-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 

On Tue, 2 Mar 1999, David.DeRidder wrote:

>  Do you mean adding it to the NBO command ? When I boot the kernel with
>  NBO, it loads over the network (BOOTP and TFTP work perfectly fine),
>  but does not ask for any arguments. It does show the arguments it knows
>  (because they are set in the kernel image), i.e. "console=ttyS0").

No, the console=ttyS0 is actually a prompt which asks you for possible
additional parameters, you have to type the additional root=/dev/nfs. This
is a trick in my current bootloader (which should disappear soon) that
sets "console=ttyS0" as a default command line when it can't find a
keyboard. You may append there additional kernel options. 

>  That part (done by PPC-Bug) works perfectly fine. nfsaddrs should be
>  a kernel option, no ? Anyway, I also pass it on with some BOOTP
>  parameter (root directory or so).

No, it is not a kernel option. AFAIR, you could build a kernel with
default root set to NFS but network configuration parameters have to be
set either by bootp or by the nfsaddrs (now ip) kernel options. 

>  What is prepboot ?

The early part of the boot for PreP machines that I've written.

>  Well, I tried using the "Argument File Name" setting (NIOT in PPC-Bug),
>  but it resulted in no improvement.

No, this won't work. I don't even remember if it is passed to the loaded
program when you select the "Network PreP boot mode enable".

>  I will download it and test it. No doubt I will get back with the
>  results real soon.

Ok, waiting for you to test it.

	Gabriel



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
