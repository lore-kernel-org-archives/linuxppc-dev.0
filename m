Message-ID: <3AEA9EF3.C2B1B76B@denise.shiny.it>
Date: Sat, 28 Apr 2001 12:44:03 +0200
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
Cc: Michel Lanners <mlan@cpu.lu>, rcook@ntlug.org,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 9.1 Gbyte SCSI Drive
References: <Pine.LNX.4.21L.0104261458530.1089-100000@naproxen.weh.andrew.cmu.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hollis R Blanchard wrote:
>
> On Thu, 26 Apr 2001, Michel Lanners wrote:
> >
> > Anyway, the point was make sure you erase the PC partition map
> > _completely_, with something like this:
> >
> > dd if=/dev/null of=/dev/sd<drive> bs=512 count=10
> >
> > This should scratch the first few blocks on disk, some of which are not
> > touched by Mac-style partition maps, and make it possible to do a
> > _clean_ Mac partition map.
>
> As long as you don't try to make it with pdisk, which claims all disks
> without an existing valid Apple partition map are 512.0 GB.


Uh?

version 0.7a3 (18 February 1998)

[root@Jay linux]# /sbin/pdisk -i
Top level command (? for help): e /dev/sdb
Edit /dev/sdb -
Command (? for help): i
map already exists
do you want to reinit? [n/y]: y
A physical block is 512 bytes: 2048
A logical block is 512 bytes: 2048
size of 'device' is 555555 blocks (2048 byte blocks): 123456
new size of 'device' is 123456 blocks (2048 byte blocks)
Command (? for help):


Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
