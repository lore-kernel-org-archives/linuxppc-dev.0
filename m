Message-ID: <367FD398.A09DAA04@phx.mcd.mot.com>
Date: Tue, 22 Dec 1998 10:15:05 -0700
From: Johnnie Peters <jpeters@phx.mcd.mot.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Creating a serial install CD
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am trying to create a R4 install set that will install with a serial
console.  I mounted the
ramdisk, changed the link for the console, unmounted it and reziped it.
I then built a new
zImage.initrd and dd'ed it to a floppy.  I can successfully boot and use
this to install from a
serial port.

The next step is to modify the R4 CD to correctly set /dev/console and
/etc/inittab.  I seem
to have done the initscripts rpm correctly but the dev rpm fails to
install and all I get is script
failed.  On a system I currently have running I cd to the
/usr/src/redhat/RPMS directory and
do "rpm -ihv --force dev-2.5.4.1b.ppc.rpm" and it runs fine.  I have
verified that it has
installed the /etc/inittab that I have changed.

I did a sum -r on this file and the file where I have the files from the
CD.

What do I need to do to get the install to use the new file?  Is there a
check sum file somewhere
or something like that I need to change?  Getting this working will be a
great benefit to
be as I will no longer need to remove a disk from a VME system hook it
to a Utah or
Blackhawk where I have VGA monitors.

Thanks for any help

Johnnie




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
