Message-ID: <37D36242.9A70B7F2@cable.a2000.nl>
Date: Mon, 06 Sep 1999 08:42:10 +0200
From: Otto Moerbeek <otto@cable.a2000.nl>
MIME-Version: 1.0
To: Linux PPC Developer List <linuxppc-dev@lists.linuxppc.org>,
        Linux PowerMac List <linux-pmac@samba.anu.edu.au>
Subject: 2.2.12 and USB on a B&W G3
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I recently tried to compile the 2.2.12 tree, and it boots fine on my B&W
G3 (rev2, no scsi) IF I disable the USB driver. If I enable the USB
driver a kernel panic occurs, with a stack trace that leads to one of
the USB interrupt handlers.

It looks like some USB work that Paul Mackerras did is not included in
the 2.2.12 tree. Is someone (Paul?) working on merging these patches
into 2.2.12?

If not, I can give it a try...

Is there an "offfical" opinion if vanilla 2.2.12 should work on B&W
G3's? Where should I be looking to find this info?

Regards, Otto

-- 
Otto Moerbeek
otto@cable.a2000.nl

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
