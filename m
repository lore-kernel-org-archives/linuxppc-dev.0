Message-ID: <37D8C4AC.D23FB178@cable.a2000.nl>
Date: Fri, 10 Sep 1999 10:43:24 +0200
From: Otto Moerbeek <otto@cable.a2000.nl>
MIME-Version: 1.0
To: Linux PowerMac List <linux-pmac@samba.anu.edu.au>,
        Linux PPC Developer List <linuxppc-dev@lists.linuxppc.org>
CC: rshaw@inficad.com
Subject: Re: 2.2.12 and rev2 B&W G3: up and running!
References: <37D5FB79.58CC83B5@cable.a2000.nl>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hmmm,

I just rsynced Paul's stable tree again and now my machine freezes after
displaying the Booting... message (just before the color logo is
displayed.

Luckily I had a tree from a few days back lying around. If I use that
version everything seems to work, expect sound. I had to disable the
sound daemon to make it run without problems.

Anyone having a idea what code is changed the last days?

Wouldn't it be a good idea to include some EXTRA_VERSION in the stable
tree's Makefile, to make it more easy to distinguish different versions?

Gr, Otto


Otto Moerbeek wrote:
> 
> Hi,
> 
> I have been able to compile and run 2.2.12 using Paul Mackerras
> linux-pmac-stable source tree. I am running it on a B&W G3, rev2, no
> SCSI. Some comments:
> 
> - I had to use hda=noautotune as a kernel arg. Otherwise a DMA timeout
> occurs when doing the partition check.
> - I had to apply my USB-ISO keyboard patch (available at
> <http://people.a2000.nl/omoerbe/>) to get all the keys on my keyboard
> working.
> 
> Now doing a linux-pmac-devel rsync, to see what's there...
> 
> TX Paul, for doing a great job!
> 
> Gr,
> Otto
> 
> --
> Otto Moerbeek
> otto@cable.a2000.nl

-- 
Otto Moerbeek
otto@cable.a2000.nl

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
