Date: Thu, 14 Jan 1999 23:37:22 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Alexander Gustav Deucher <agd5f@unix.mail.virginia.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Porting to Nubus PowerMacs
In-Reply-To: <199901141524.KAA11190@node7.unix.Virginia.EDU>
Message-ID: <Pine.HPP.3.96.990114232923.2338Q-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 14 Jan 1999, Alexander Gustav Deucher wrote:

> 
> While we are on the subject of porting, How hard would it be to
> get linux ppc to boot on machines with NT firmware?  Does
> anyone know why this firmware is so problematic? Is there
> anywhere one could find documentation on it, etc.

This firmware might even try to boot the image in little endian mode,
handling the setting of the processor is rather simple, but resetting the
host bridge to big endian operation might be very complex and HW
dependant. 

Could you try the zImage and the preploader on my ftp site:

	ftp://vcorr1.iram.es/pub/zImage-2.2.0-pre5
	ftp://vcorr1.iram.es/pub/preploader.tgz

(preploader is an experimental early boot code which will take your
/usr/src/vmlinux and build a zImage ready to boot from 0x41 partition). It
could be hacked to spit out a lot of info about what the state of the
machine is when the loaded image gets control.

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
