Message-ID: <3AD717A1.57872288@mvista.com>
Date: Fri, 13 Apr 2001 11:13:37 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Masahide Tomita <tomita@itl.nyc.co.jp>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Which rootfilesystem should I use on booting MBX860?
References: <a04320401b6fc63ce0068@[192.168.10.144]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Masahide Tomita wrote:

> Building the kernel and booting it on MBX was successful, but I'm so
> confused about usage of initrd and so on.

I still believe the easiest thing to do is build up a small NFS
root file system for testing.  When it has what you want, just
copy it to a ramdisk.

> I'm using ramdisk.image from MontaVista,

I don't believe there is a ramdisk image provided in any MontaVista
kit, so I don't know where this came from.  There certainly isn't
anything provided for an 8xx.


> Options, which I can think of now, are:

At least you have options and can make trade offs :-).

> ...... I also don't know how to recompile tools to
> run them without libraries.

If you are using the complete set of tools, libraries and applications
from Hard Hat Linux, you don't need to recompile anything.

>   2. mount command doesn't work.

Yes, it does.  Use the one for the 8xx and use the proper libraries.

> And Ether is not up. Command ifconfig doesn't work either.

Huh?  Yes, it does.  There is a problem in the driver that it
doesn't shut down properly, but you can always bring it up and
reconfigure it.

One of the advantages of using everything from Hard Hat Linux is
the tools, libraries, and applications are all built and tested
to work together for a specific target.  Don't be mixing, matching,
and copying stuff around or you will just end up with a mess.  Install
what you need from the RPMs.

	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
