Date: Fri, 15 Jan 1999 03:03:24 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: Gabriel Paubert <paubert@iram.es>
cc: Alexander Gustav Deucher <agd5f@unix.mail.virginia.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Porting to Nubus PowerMacs
In-Reply-To: <Pine.HPP.3.96.990114232923.2338Q-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.4.04.9901150301480.632-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 14 Jan 1999, Gabriel Paubert wrote:
> On Thu, 14 Jan 1999, Alexander Gustav Deucher wrote:
> 
> > 
> > While we are on the subject of porting, How hard would it be to
> > get linux ppc to boot on machines with NT firmware?  Does
> > anyone know why this firmware is so problematic? Is there
> > anywhere one could find documentation on it, etc.

Is this Open Firmware or some derivative of PPCbug?? I though NT required
Open Firmware (which would mean the preploader wouldn't work too well)

> 
> This firmware might even try to boot the image in little endian mode,
> handling the setting of the processor is rather simple, but resetting the
> host bridge to big endian operation might be very complex and HW
> dependant. 
> 
> Could you try the zImage and the preploader on my ftp site:
> 
> 	ftp://vcorr1.iram.es/pub/zImage-2.2.0-pre5
> 	ftp://vcorr1.iram.es/pub/preploader.tgz
> 
> (preploader is an experimental early boot code which will take your
> /usr/src/vmlinux and build a zImage ready to boot from 0x41 partition). It
> could be hacked to spit out a lot of info about what the state of the
> machine is when the loaded image gets control.
> 
> 	Gabriel.
> 
> 
> 

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
