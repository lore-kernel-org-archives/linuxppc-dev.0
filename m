Message-ID: <399CBAE0.7EFDF429@embeddededge.com>
Date: Fri, 18 Aug 2000 00:26:08 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Pravin Pathak <pkpathak@dnrc.bell-labs.com>
CC: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: What is embedded linux ?
References: <399B0FCD.A6E0A6BE@dnrc.bell-labs.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pravin Pathak wrote:
>
> Hi All !
> I have a silly question. How does embedded linux works without disk
> support ?

Don't confuse disk with file system......

> I mean from where it loads shell and other application task images
> without any file system
> support ?

Don't confuse disk with file system.....

> .... For VxWOrks/pSOS have a single object file. How about Embedded
> Linux ?

There are both a number of possible file systems (the structure of the
persistent data) and possible storage devices (the place where the
data is actually stored).

You can use the standard Linux ext2 file system on a ramdisk or in
flash, one of the flash file systems that will update flash sectors
and potentially compress the data, or even a file system on a
compact flash (or PCMCIA) device.

You can compress a ram disk as part of a flash image, and have it
automatically uncompressed and loaded into ram when the system boots.

There are many options and your choice depends upon your requirements.

> I am confused on this matter. Or it always need some kind of file
> support like NFS to boot ?

The NFS is used as a root file system because it is convenient for
development and also consistent across most platforms because everyone
supports Ethernet.  It isn't required, but is certainly the fastest
development path.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
