From: ramp@oddjob.uchicago.edu
Date: Mon, 14 Feb 2000 14:21:42 -0600 (CST)
To: Jack Howarth <howarth@bromo.med.uc.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: usb problems in 2.3.45pre2
In-Reply-To: <200002140142.RAA49857@bromo.med.uc.edu>
Message-ID: <Pine.LNX.4.10.10002141419580.6586-100000@xpol.uchicago.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I get the same problem. What other USB devices do you have? Make sure
that you have not chosen the "CONFIG USBSCSI" or some such. You could
try building it as a module.

- Ramprasad

On Sun, 13 Feb 2000, Jack Howarth wrote:

>
> Building the rsync'ed linux-pmac-devel tree tonight gave the following
> boot errors. This kernel was built taking all the config defaults
> except for DE4x5 which should be set as a default for G4s to have
> ethernet. The boot gives the following...
>
> usb_control/bulk_msg: timeout
> usb_ohci.c: unlink ORB timeout!
> usb.c: USB device not accepting new address (error=-110)
> INIT: version 2.77 booting
> usb.c: USB new device connect, assigned device number 2
> page fault in interrupt handler, addr=f2100000
>
> (more dump deleted)
>
> This occurs booting on a Sawtooth G4/450 with an external USB powered hub
> and using yaboot 0.5 to boot. Any ideas how to fix this?
>        Jack
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
