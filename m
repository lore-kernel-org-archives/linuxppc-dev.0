Message-Id: <199909152310.BAA15260@denx.local.net>
To: linuxppc-dev@lists.linuxppc.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: New booter 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 15 Sep 1999 14:37:35 -0800."
             <v04210102b405ce2cdefb@[192.168.0.1]>
Date: Thu, 16 Sep 1999 01:10:08 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <v04210102b405ce2cdefb@[192.168.0.1]> Ethan Benson
<erbenson@alaska.net> wrote:
> 
[about LILO]:
> it boots very cleanly on x86, booting linux instead of windows is 
> complete non issue there.
> 
> BIOS loads the bootblock from boot disk or if one does not exist it 
> looks for a partition marked bootable in the partition table and 
> loads the bootblock from that.  the BIOS knows NOTHING about ANY 
> filesystem not ext2 not FAT, NTFS, DOSfs, not HFS.  lilo works 
> wonderfully, and does not require its very own partition in a 
> specific filesystem format to work. *I* think this is a very clean 
> way to boot it allows the replacement of the filesystem without 
> anything more then a update to lilo at most.  not a whole new machine 

Furthermore, LILO provides with a lot of interesting  options  rarely
used  but  very  powerful  (and  *very* useful for embedded systems):
password protection,  selection  of  alternate  boot  arguments  with
automatic fallback if booting fails etc.

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Old programmers never die, they just branch to a new address.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
