Message-ID: <36D4F2D5.B5472697@wanadoo.fr>
Date: Thu, 25 Feb 1999 07:51:01 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Mayan Moudgill <mayan@watson.ibm.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: ramdisks, anyone?
References: <9902242039.AA29018@mayan.watson.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mayan Moudgill wrote:
> 
> I am trying to build a small initrd, with a linuxrc that does something.
> Does somebody have such a ramdisk.image available?
> Or even some suggestions on what to do?
> 
> I started off by trying to make bash my /linuxrc. Bash
> required ld.so.1, which required libc.so.2, etc....
> 
> This occupied more the 4MB. At that point the /dev/ram on the
> machine I was building the ramdisk started giving problems -
> If I built a bigger /dev/ram, after umount, dd would only
> read the first 4MB.  is there something magical about 4M for ramdisks?

Yes. If you want more than 4M, let's say 8M, you have to boot with a
kernel argument ramdisk_size=8192. If you have kernel sources installed,
you can read about this in /usr/src/linux/Documentation/ramdisk.txt.

--
Martin

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
