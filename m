In-Reply-To: <199909171607.SAA07046@juliet.astrophysik.uni-kiel.de>
Date: Sat, 18 Sep 1999 14:58:32 +0200
To: Derek Homeier <homeier@astrophysik.uni-kiel.de>,
        linuxppc-dev@lists.linuxppc.org, j.pearson@ge.ucl.ac.uk
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: New booter
Message-Id: <19990918145832.004481@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Sep 17, 1999, Derek Homeier <supas100@astrophysik.uni-kiel.de> wrote:

>I think the latest mkhybrid <ftp://ftp.ge.ucl.ac.uk/pub/mkhfs/> has
provisions
>
>for installing a boot driver, but it's highly experimental yet. You'd still
>need the driver itself, also.

The problem with mkhybrid approach is that it will rip only one driver
from the CD. A typical bootable CD now contains both a "patch driver", a
patch partition, and the real driver chained behind those.

I'll look into fixing this once I have finished the hard core booting
stuff. I beleive I'll end up putting a home-made driver in place of the
pieces above. This driver will either look for a keystroke or display a
boot selection dialog and eventually enter the kernel. In the meantime,
if someone wants to know how this "chained driver" mecanism is done, you
can mail me privately.

The only potential problem is that since we lack the Apple patches, the
SCSI and IDE managers in ROM may not be very reliable to load the kernel
(especially the MESH driver which is one of the first thing patched).

Unfortunately, I don't have a CD-RW so I'll have to burn some CDs before
having a working solution. (I'm considering adding a SCSI CD emulation to
MOL).


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
