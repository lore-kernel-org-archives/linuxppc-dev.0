From: ghannon@cspi.com
To: David Gardiner <daveg@sonartech.com.au>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <85256E45.0059D734.00@pine.cspi.com>
Date: Wed, 25 Feb 2004 11:30:50 -0500
Subject: Re: ppcbug booting
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David,
     I've tried to do something similar, although I did not go to the level
of replacing ppcbug with uboot.   As you've already learned, ppcbug
can't see the IDE compact flash card.  I've got reassurance from Motorola
that it never will.  (PROMIS controller will not be supported according to
our
supplier.)

     I've made a kernel and romfs that can see the drive, but that kernel
must reside in the onboard flash.   (Set up ppcbug to rom boot vs autoboot)
The tricky part is whenever you need to change your kernel, you are going
to have to do it in ppcbug.  In other words, you can't build your kernel on
this machine and just reboot into the new kernel.

     If you get uboot running and find it can see the hard drive directly,
I would like to copy that approach.

Hope that helps,

Gary Hannon






David Gardiner <daveg@sonartech.com.au> on 02/24/2004 06:24:54 PM

To:   linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
cc:    (bcc: Gary Hannon/CSP)
Subject:  ppcbug booting





Hi All,

I'm currently running Linux system (linuxppc_2_4 from monta vista,
thanks to all those who have worked on it) that comprises of a motorolla
mvme5100 that has a promise ide pmc with a compact flash and was hoping
to get the compact flash to hold the entire OS+kernel ... At the moment
the system can be booted via nfs / prep boot (if running with a scsi
disk) and bugboot. But what I was hoping to do was boot of a kernel on
the compact flash. My assumption is that using u-boot to do this would
be a heavy handed approach (please point out if I'm wrong) and I haven't
seen anything in my googling. Has anyone ever tried anything like this?
if not can I please get some pointers on the best way to go about this.

Thanks
dg


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
