Message-ID: <39D35F88.BAE0B8AB@mvista.com>
Date: Thu, 28 Sep 2000 11:11:04 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Dave Pegler <dwp@cambridgebroadband.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mbxroot.min.tgz and mbxroot.full.tgz
References: <14803.23469.74630.600419@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dave Pegler wrote:
>
> Can anyone tell me where I can get the minimal and complete root file
> systems from. I've tried from :


Those are fortunately note available any longer and are quite dated...
It is now quite easy to use the MontaVista RPMs from the CDK to create
a root file system to meet your needs.  Just install all of the RPMs
for your processor of choice if you want a "complete" file system, and
selectively install them to create something that meets your minimal
requirement.  There are also some scripts floating around that will
build a ramdisk (initrd) from a NFS root diskless partition.  Visit
the MontaVista web site (www.mvista.com) to find these things.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
