Date: Fri, 22 Jan 1999 10:41:17 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: Pink X <PinkX@earthlink.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Embedded ppc project
In-Reply-To: <199901220857.AAA10924@avocet.prod.itd.earthlink.net>
Message-ID: <Pine.LNX.4.04.9901221036500.12144-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 22 Jan 1999, Pink X wrote:

> 
> 
> Can someone give me  a brief overview of how the boot process works for 
> linuxppc on non-mac, non-open firmware hardware?

Most things with Motorola's PPCBug work pretty well.. The firmware loads a
boot loader, which then needs to uncompress the gziped kernel into low
memory.
 
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

Have you looked at Motorola's MTX/MVME boards? You can get all the way up
to a dual 604e/300. Or are they too big (physically)?

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
