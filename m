Mime-Version: 1.0 (Apple Message framework v609)
In-Reply-To: <00c801c3d6d6$a9f818a0$7138e30a@ibm18437>
References: <00c801c3d6d6$a9f818a0$7138e30a@ibm18437>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <57FDFB0E-42F9-11D8-BA9D-000393911DE2@sara.nl>
From: Remco Post <r.post@sara.nl>
Subject: Re: Linux on IBM 9076 nodes
Date: Sat, 10 Jan 2004 00:12:49 +0100
To: "<linuxppc-dev@lists.linuxppc.org> <linuxppc-dev@lists.linuxppc.org>" <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Jan 9, 2004, at 18:33, Bill Noffsinger wrote:

>
> Our lab has recently acquired a 48-node IBM SP configuration based on
> 4-way "Winterhawk-II" Power3-2 wide nodes with 8 GB memory. I see on
> the
> Linuxppc site (boxes) that Linux is known to work on 9076-SP nodes
> (ours). How difficult is the port? IBM does not support Linux on the
> 9076 but does on the newer Power4 pSeries units.
>

I guess that, since these boxes are basically just rack-mounted chrp,
rs6k's, getting linux to run is easy. Getting the os on there may
require some creativity, since sp nodes don't come with a removable
media, so you'll have to net-boot&install, but iirc, these boxes
basically do tftp, but I guess you still need a working
control-workstation to be able to set the netboot. (I have never had
the oppertunity to play with an sp-node at this level)

as long as you don't need the sp switch (if you have one) all hardware
is supported, ge, fe and even the scsi are quite common hardware, just
with an IBM sticker&price-tag ;-)

(I wish I had a few spare wh-II's to play with :)

> Bill Noffsinger
> bnoffsi@ufl.edu
>
>
>
>
--
Met vriendelijke groeten,

Remco Post

SARA - Reken- en Netwerkdiensten                      http://www.sara.nl
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167

"I really didn't foresee the Internet. But then, neither did the
computer industry. Not that that tells us very much of course - the
computer industry didn't even foresee that the century was going
to end."                                       -- Douglas Adams


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
