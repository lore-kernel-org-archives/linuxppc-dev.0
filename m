Message-Id: <199903051347.OAA08717@mail.plusline.de>
Date: Fri, 05 Mar 1999 14:47:57 +0100
Subject: Re: ADB Reset
From: "Christian Jaeger" <cj@plusline.de>
To: Hubert Figuiere <hub@point-barre.fr>,
        LinuxPPC Dev List <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> 
> Can anybody tell me how to reset the ADB bus. Just because when I
> snooze the PowerBook, the mouse become really slow....
>
> How can I ask to redect all the ADB peripherals. I want to be able
> to plug and unplug my kensington mouse.
>
> The goal is to make a small set of utilities for this :-)
>
> Hub
While you are at it:
Consider a reinit for SCSI, ext. Screen, Network as well since that's
changing with locations. Maybe even hot-swapping the disk/cdrom/zip-drive in
expansion bay.loading the appropriate modules on the fly.
;)


--
Chris Jaeger
Germany

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
