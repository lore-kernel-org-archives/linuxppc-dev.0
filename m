Date: Fri, 16 Jul 1999 15:51:50 -0400
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: research for a new booting mechanism
Message-ID: <19990716155150.A12541@drow.res.cmu.edu>
References: <862567B0.0065DE1F.00@crnotes.collins.rockwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <862567B0.0065DE1F.00@crnotes.collins.rockwell.com>; from James S Lande on Fri, Jul 16, 1999 at 01:28:01PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jul 16, 1999 at 01:28:01PM -0500, James S Lande wrote:
> Plan:
> 
> What if a person set bit 6 of the bbVersion field of the bootblock of a
> dummy HFS partition and then at the end of the boot-block, put in the
> /boot/first.b code?
> My first attempt was to just dd the first.b to the first block of the dummy
>  HFS partition.  Then I used System Disk from Darwin to boot off of this
> disk.  Much to my surprise
> quik actually kicked in and I was at the boot prompt.  But I couldn't boot
> linux because it couldn't find the second.b chunk or the root filesystem.
> I couldn't readily find the quik source at work, and don't have the source
> RPM so, I stopped for now, mainly because I am going on a computer-less
> vacation.
> I thought I could look at/modify the source to read blocks from the disk/
> or add hfs support/ to find/write the quik.conf file.
> I also decided to post this to the dev list to see if anyone else had ever
> tried something like this, so that I wouldn't be wasting my time if it had
> been tried and found unsuccessful.

The question, it seems to me, is what sort of state the OS is in when
this happens.  Is Open Firmware still mapped in, or does the Apple ROM
unmap it?  It should be possible to use this in either case, although
if it is unmapped, it would be more like running BootX (whose source I
have not yet actually looked at).

Ben, thoughts?

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
