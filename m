MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14799.14699.552209.136967@esb.bbn.com>
Date: Mon, 25 Sep 2000 07:39:23 -0400
From: R Shapiro <rshapiro@bbn.com>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 with rage II/rage pro -- multi-headed display!
In-Reply-To: <Pine.LNX.4.10.10009251101410.28773-100000@opal.biophys.uni-duesseldorf.de>
References: <14798.23332.833379.615321@esb.bbn.com>
	<Pine.LNX.4.10.10009251101410.28773-100000@opal.biophys.uni-duesseldorf.de>
Reply-To: rshapiro@bbn.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz writes:
 > [ati driver on rev. a Rage II beige G3 hoses linux]
 > Does the X server complain about PCI resource conflicts when run as X
 > --probeonly?

I'll run this test as soon as the Rage II machine is available again.



 > Anything about PCI problems in the server log?

The only server log I have right now is for the X I left running
yesterday with the fbdev driver.  There are a couple of PCI warnings
in this one but no errors (no surprise, since everything is working
well with fbdev):

(**) (null)(2): claimed PCI slot 0:15:0
(II) FBDev(2): using /dev/fb2
(WW) ****INVALID IO ALLOCATION**** b: 0x400 e: 0x4ff correcting
(II) window:
        [0] -1  0x00000000 - 0x0000ffff (0x10000) IXB
(II) resSize:
(II) window fixed:
        [0] -1  0x00000000 - 0x0000ffff (0x10000) IXB
(WW) ****INVALID IO ALLOCATION**** b: 0x400 e: 0x4ff correcting


I didn't save any logs from the ati tests that hung linux.  I'll try
to generate one next time the machine is available for crashing :)



 > BTW: Can you use yaboot for booting?

I don't know, can I use yaboot on a rev. a beige G3?  I think the
answer is 'no' but I'm not sure.  I don't think I can use quik either,
since the linux installation is on an ide drive (the rev. b G3 uses
quik but it has scsi drives only, no ide).  Maybe miBoot would work,
I've never tried to use that one before.

Are there known X-related problems using BootX?



 > > 4. On the rev. b beige G3 w/Mach64 Rage Pro, the ati driver seems to
 > > be working.  The XF probe still gets the wrong amount of vram, and it
 > > still throws away the mode I constructed via fbset -x.  But it finds
 >
 > Perhaps the video RAM detection typo which should be gone now ...

Fwiw I'm using the ati driver I built from sources rsync'd on
Saturday.

--
rshapiro@bbn.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
