MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14802.16462.166588.375647@esb.bbn.com>
Date: Wed, 27 Sep 2000 14:45:34 -0400
From: R Shapiro <rshapiro@bbn.com>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: daenzerm@student.ethz.ch, linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
In-Reply-To: <Pine.LNX.4.10.10009272022070.27656-100000@opal.biophys.uni-duesseldorf.de>
References: <14801.4812.235660.20792@esb.bbn.com>
	<Pine.LNX.4.10.10009272022070.27656-100000@opal.biophys.uni-duesseldorf.de>
Reply-To: rshapiro@bbn.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz writes:
 > So here we have three fb devices in the kernel (you could check with
 > fbset that each is in fact accessible via /dev/fb[0-2]), and XFree unable
 > to cope.

The ati driver unable to cope.  The fbdev driver copes without
complaint.


 > You specify the PCI bus ID but not the corresponding framebuffer
 > device node

In the XF86Config?  That has both the bus id and the dev node:

        Option     "UseFBDev"
        Option  "fbdev" "/dev/fb0"
        Driver      "fbdev"
        BusID       "PCI:0:18:0"

Similarly for the second and third devices (/dev/fb1 & PCI:0:13:0,
/dev/fb2 & PCI:0:15:0, respectively).

Hmm, if change the driver to "ati", am I also supposed the change the
device node Option to "ati", ie 'Option "ati" "/dev/fb0"'?  I never
tried that.


--
rshapiro@bbn.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
