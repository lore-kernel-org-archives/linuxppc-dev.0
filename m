Message-ID: <37D5FB79.58CC83B5@cable.a2000.nl>
Date: Wed, 08 Sep 1999 08:00:25 +0200
From: Otto Moerbeek <otto@cable.a2000.nl>
MIME-Version: 1.0
To: Linux PowerMac List <linux-pmac@samba.anu.edu.au>,
        Linux PPC Developer List <linuxppc-dev@lists.linuxppc.org>
CC: rshaw@inficad.com
Subject: 2.2.12 and rev2 B&W G3: up and running!
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have been able to compile and run 2.2.12 using Paul Mackerras
linux-pmac-stable source tree. I am running it on a B&W G3, rev2, no
SCSI. Some comments:

- I had to use hda=noautotune as a kernel arg. Otherwise a DMA timeout
occurs when doing the partition check.
- I had to apply my USB-ISO keyboard patch (available at
<http://people.a2000.nl/omoerbe/>) to get all the keys on my keyboard
working.

Now doing a linux-pmac-devel rsync, to see what's there...

TX Paul, for doing a great job!

Gr, 
Otto

-- 
Otto Moerbeek
otto@cable.a2000.nl

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
