Date: Fri, 5 Mar 1999 19:46:45 +0100
From: Hubert Figuiere <hub@point-barre.fr>
To: Christian Jaeger <cj@plusline.de>
Cc: LinuxPPC Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ADB Reset
Message-ID: <19990305194645.B2068@giordino.point-barre.fr>
References: <199903051347.OAA08717@mail.plusline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199903051347.OAA08717@mail.plusline.de>; from Christian Jaeger on Fri, Mar 05, 1999 at 02:47:57PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


According to Christian Jaeger <cj@plusline.de>:
> While you are at it:
> Consider a reinit for SCSI,

Look at the SCSI-Programming HOWTO. It explain how to 
force a new SCSI device to be recognized.

> ext. Screen, Network as well since that's
> changing with locations.

For network, everything can be done with shell script

> Maybe even hot-swapping the disk/cdrom/zip-drive in
> expansion bay.loading the appropriate modules on the fly.
> ;)

kerneld will do this. Just fill the modules.conf in.


Hotswapping CD and floppy on my PB 3400 works like a charm
(thanks to the people that made it).


Hub
-- 
World Wide Wait: the real meaning for WWW.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
