Message-ID: <3904CAD9.17C1AA93@pandora.be>
Date: Mon, 24 Apr 2000 18:29:46 -0400
From: Daniel Gonzalez <daniel.gonzalez@pandora.be>
MIME-Version: 1.0
To: "Dunlap, Randy" <randy.dunlap@intel.com>
CC: Matthew Dharm <mdharm-usb@one-eyed-alien.net>,
        linuxppc-dev@lists.linuxppc.org, linux-usb@suse.com
Subject: Re: [linux-usb] Close to a solution. Please help !
References: <D5E932F578EBD111AC3F00A0C96B1E6F0545CA67@orsmsx31.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Randy,

Strange enough my /etc/conf.modules is empty. No wonder that the modules
are not automatically loaded ( I have to do it by hand )Any idea of what
should
I do to recreate that file ?

BTW, no sd_mod module present in my system ...


"Dunlap, Randy" wrote:

> Hi Daniel,
>
> I don't see anything that is obviously wrong in the
> linux/.config file.
>
> The recent advice from Joseph Fannin looks good.
> Have you tried it?  (except change:
>   alias char-major-8 sd_mod
> to
>   alias block-major-8 sd_mod
> )
>
> Give us a list of modules that are loaded when you connect
> the Zip drive.
>
> Switching to the main linux tree is likely just to give
> you/us a different set of problems, but I'm just guessing
> that based on Brad Hards's comments.
>
> For USB source file comparisons, all of my 2.3.99-pre6-5
> unzipped .c files are dated between Mar. 10 and Apr. 21, 2000.
> None from the Jan.-Feb. timeframe as you listed.
> There have been beaucoups changes in this time, especially
> to the usb-storage driver.
>
> ~Randy
>
> > -----Original Message-----
> > From: Daniel Gonzalez [mailto:daniel.gonzalez@pandora.be]
> > Sent: Monday, April 24, 2000 2:54 PM
> > To: Dunlap, Randy
> > Cc: Matthew Dharm; Sheldon Easterbrook;
> > linuxppc-dev@lists.linuxppc.org;
> > linux-usb@suse.com
> > Subject: Re: [linux-usb] Close to a solution. Please help !
> >
> > > > Well. The sources I have are taken from linuxcare (I
> > think that is Paul's tree,
> > > > isn't?). I am using the devel tree, since I heard that
> > was performing better for the USB subsystem.
> > >
> > >
> > > I'm still confused about what version of the kernel code this is.
> > >
> > > The Linux boot message says 2.3.99-pre6, but the USB code is clearly
> > > MUCH earlier than that.
> > > Could you explain a little of how you came by this code?
> > > I don't want the complete history, just enough to help us
> > > understand what you are trying to use here.
> > >
> >
> > I am using a development tree targeted for the PowerPC
> > community. I suppose this code
> > is periodically merged with the main linux tree, but I do not
> > know how they put together
> > the sources. Maybe I should use the main linux tree ?
> >
> > The usb sources are:
> >
> > [root@dhcp-213-224-12-204 usb]# grep \$Id /usr/src/linux/drivers/usb/*
> > 2>/dev/nul
> > /usr/src/linux/drivers/usb/dabusb.c: *  $Id: dabusb.c,v 1.45
> > 2000/01/31
> > 10:23:44 fliegl Exp $
> > /usr/src/linux/drivers/usb/devices.c: * $Id: devices.c,v 1.5
> > 2000/01/11
> > 13:58:21 tom Exp $
> > /usr/src/linux/drivers/usb/devio.c: *  $Id: devio.c,v 1.7
> > 2000/02/01 17:28:48
> > fliegl Exp $
> > /usr/src/linux/drivers/usb/drivers.c: * $Id: drivers.c,v 1.3
> > 2000/01/11
> > 13:58:24 tom Exp $
> > /usr/src/linux/drivers/usb/inode.c: *  $Id: inode.c,v 1.3
> > 2000/01/11 13:58:25
> > tom Exp $
> > /usr/src/linux/drivers/usb/plusb.c: *  $Id: plusb.c,v 1.18
> > 2000/02/14 10:38:58
> > fliegl Exp $
> > /usr/src/linux/drivers/usb/usb-uhci.c: * $Id: usb-uhci.c,v
> > 1.228 2000/04/02
> > 19:55:51 acher Exp $
> > /usr/src/linux/drivers/usb/usb-uhci.h:   $Id: usb-uhci.h,v
> > 1.54 2000/04/02
> > 19:55:53 acher Exp $
> > /usr/src/linux/drivers/usb/usb.c: * $Id: usb.c,v 1.53
> > 2000/01/14 16:19:09 acher
> > Exp $

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
