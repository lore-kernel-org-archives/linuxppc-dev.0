Date: Tue, 22 Dec 1998 20:49:51 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: Johnnie Peters <jpeters@phx.mcd.mot.com>
cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Creating a serial install CD
In-Reply-To: <367FD398.A09DAA04@phx.mcd.mot.com>
Message-ID: <Pine.LNX.4.04.9812221825490.28200-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 22 Dec 1998, Johnnie Peters wrote:

> 
> I am trying to create a R4 install set that will install with a serial
> console.  I mounted the
> ramdisk, changed the link for the console, unmounted it and reziped it.
> I then built a new
> zImage.initrd and dd'ed it to a floppy.  I can successfully boot and use
> this to install from a
> serial port.
> 
> The next step is to modify the R4 CD to correctly set /dev/console and
> /etc/inittab.  I seem
> to have done the initscripts rpm correctly but the dev rpm fails to
> install and all I get is script
> failed.  On a system I currently have running I cd to the
> /usr/src/redhat/RPMS directory and
> do "rpm -ihv --force dev-2.5.4.1b.ppc.rpm" and it runs fine.  I have
> verified that it has
> installed the /etc/inittab that I have changed.

Did you run 'genhdlist' ? ( On Intel RH, it's in
misc/src/install/genhdlist ) I don't know where it is on Linuxppc R4.

Btw, what did you set /dev/console to? I'm going to try and set up a CD
based on Glibc-2.1 and recent kernels which have better support for the
MTX and MVME boards in a couple of weeks.

> I did a sum -r on this file and the file where I have the files from the
> CD.
> 
> What do I need to do to get the install to use the new file?  Is there a
> check sum file somewhere
> or something like that I need to change?  Getting this working will be a
> great benefit to
> be as I will no longer need to remove a disk from a VME system hook it
> to a Utah or
> Blackhawk where I have VGA monitors.
> 
> Thanks for any help
> 
> Johnnie

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
