Date: Fri, 22 Jan 1999 08:38:28 -0700 (MST)
From: Matt Porter <mmporter@home.com>
To: Pink X <PinkX@earthlink.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Embedded ppc project
In-Reply-To: <199901220857.AAA10924@avocet.prod.itd.earthlink.net>
Message-ID: <Pine.LNX.3.96.990122083549.17313C-100000@liberty.chnd1.az.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 22 Jan 1999, Pink X wrote:

> Can someone give me  a brief overview of how the boot process works for 
> linuxppc on non-mac, non-open firmware hardware?
> 
> For instance, we're looking at a custom processor board for a project... 
> basically it will have a CPU, a DiskOnChip of about 24MB, RAM and a 
> drive.   Will it be hugely difficult to get linuxppc to boot out of the 
> DoC (with a kernal and compress root ramdisk in the DiskOnChip)  Does the 
> kernel make assumptions about there being certain types of hardware or a 
> open firmware roms being there?  Will it be hugely difficult for (very 
> experienced programmers who have worked on unix but not linux 
> specifically) to get the kernal hacked to our hardware formfactor (not 
> counting any I/O work, just booting in this environment.)
> 
> Any advice appreciated!  We may go with the RPCLite board, but we kinda 
> need a 603e level of power.  (So any 603e @200+MHz embedded boards would 
> be great to hear about, we've not found any yet.)

The Mot. 8240 has a 603 core at 100Mhz max which is at least closer to
what you want than the slow 860's...they probably will show up on MBX type
boards from Mot. soon.

--
Matt Porter
mmporter@home.com
Unix is a Linux-like operating system.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
