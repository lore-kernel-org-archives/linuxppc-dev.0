Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <3BE2C1DB.8B975906@labs.mot.com>
Date: Fri, 02 Nov 2001 09:55:07 -0600
From: "Joshua Horvath" <Josh_Horvath-AJH051@email.mot.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Abatron BDI2000
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In my lab, we are currently using EST VisionICE boxes to develop custom
PowerPC 8xx based boards.  I recently got a BDI2000 evaluation unit and am
trying to decide if it makes sense to purchase a few of these units and dump
the EST boxes.

>From playing around with the Abatron unit, it seems the two biggest advantages
are

1) MMU support
2) Can be used with a Linux based development pc

Since we haven't had a problem bringing the kernel up on our boards, 1) isn't
(currently) a big deal.  What we really need is to be able to debug loadable
modules, which from what I've gathered is only possible with kgdb.  Is this
assumption correct?

We can flash our boards, download code, etc. and as I said, we've got the
kernel running successfully.  So other than point 2) above, is there anything
else I've missed that would provide a compelling reason to purchase these
units?


Thanks,
-Josh

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
