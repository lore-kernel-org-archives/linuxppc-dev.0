Date: Tue, 2 Mar 1999 16:29:58 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: loopback <david.de.ridder@bitsmart.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel boot arguments over network
In-Reply-To: <Pine.SO4.4.05.9903021502290.13750-100000@hsins.uia.ac.be>
Message-ID: <Pine.HPP.3.96.990302162445.3871g-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 2 Mar 1999, David.DeRidder wrote:

>  Now I see. I wasn't aware the bootloader was waiting for input - I just
>  thought it was doing something. There is a timeout to this prompt, 
>  right ?

Yes. Actually this was (partly) copied from a previous early boot, the
biggest change being an attempt to improve keyboard code.

>  Pretty neat that it can take input from a serial keyboard in that stage
>  of the boot procedure. I thought it was just some kernel info, echoed
>  due to CONF_SERIAL_ECHO. But instead, it is prepboot, right ?

Indeed. 

> > No, this won't work. I don't even remember if it is passed to the loaded
> > program when you select the "Network PreP boot mode enable".
> 
>  It seems not. Does anybody out there know what this is for ? The PPC-Bug
>  manual is very uninformative on this matter.

I could never dig any information on this. And anyway, residual data are
absolutely necessary to get the interrupt routing through the OpenPIC in
the Raven.

> > Ok, waiting for you to test it.
> 
>  Tested it, and it still is stuck at 'Now booting...' Does the kernel
>  look for its root filesystem before giving any output ? If so, it
>  might be the case that the kernel doesn't find its root fs (but
>  I'd expect at least a message reporting that is the case). If not,
>  there must be another problem...

No, I would rather think that there is a problem with the universe. Plese
rerun the ENV command and answer 0 or N to all questions about the VMEPCI3
bridge. The default settings might interfere with the reallocation of
PCI resources (I'm working on making the Universe known to the PCI code
to avoid conflicts). 

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
