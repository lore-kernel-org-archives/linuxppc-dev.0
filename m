Date: Thu, 17 Dec 1998 09:46:30 -0600 (CST)
From: nathan ingersoll <ningerso@d.umn.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org, paulus@cs.anu.edu.au
Subject: Re: BootX, ramdisk and root device
In-Reply-To: <19981215143756.003692@mail.mipsys.com>
Message-ID: <Pine.SO4.4.02.9812170944030.9640-100000@ub.d.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>From my experience, using the "No Video" option cancels out any video
arguments passed to the kernel. In fact, when I first started using BootX
I was passing "video=atyfb" then I decided to try the No Video option. I
didn't remove the video argument, but the screen came up like it was
suppoed to with the option checked. Using XF68 also says that the video
driver is OFfb.

Hope this helps,

Nathan


On Tue, 15 Dec 1998, Benjamin Herrenschmidt wrote:

> 
> Hi All !
> 
> A couple of questions for which I would like feed-back before changing BootX:
> 
> I've seen users having troubles because they both checked the "Use RAM
> Disk" box and wrote some incorrect infos in the /dev/xxx edit field of BootX.
> 
> I was wondering: Is there any case where a user may want to have both
> "Use RamDisk" and a specified root device ? Should I ignore the content
> of the root device field when ram disk is used ? (It still possible to
> force it by typing the parameter manually in the kernel args anyway).
> 
> Similar issue: should I lookup and remove any "video=xxxx" option from
> the kenrnel args prior to booting the kernel when "no video driver" is
> checked or is this harmless ?
> 
> -- 
>            E-Mail: <mailto:bh40@calva.net>
> BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>
> 
> 
> 
> 
> 

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
