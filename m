Date: Sat, 23 Oct 1999 18:52:50 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Ethan Benson <erbenson@alaska.net>
cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: bypassing MacOS using Open Firmware on Apple pmac G3
In-Reply-To: <v04210112b436ae4d5107@[192.168.0.1]>
Message-ID: <Pine.LNX.3.96LJ1.1b7.991023184807.9846A-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 22 Oct 1999, Ethan Benson wrote:

[...]
> using HFS is not an option IMO because it must be created on macos, 
> unless someone wants to write a mkfs.hfs, didn't think so.  no thanks 
> I'll stick with a DOS partition that I can take care of in a total 
> Free environment rather then keeping macos around just to maintain 
> the bootloader.  (which is just as bad as using Bootx

You can use hformat from hfsutils to creat a HFS partition.  It works just
fine.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
