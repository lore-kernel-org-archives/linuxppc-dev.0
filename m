Message-ID: <38BCE4EF.85135592@inu.se>
Date: Wed, 01 Mar 2000 10:37:51 +0100
From: Björn Lundberg <bjorn.lundberg@inu.se>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Performance 2.2.13 and USB work
References: <20000229054521.6C2385064E@brixi.research.canon.com.au>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We've been using 2.2.5 and wanted to move up to 2.2.13

So, we made a diff on all changes we've done on Malek's 2.2.5 and
applied that to 2.2.13.
We then ran a test on it and found 2.2.13 was 3 times slower than 2.2.5!

We haven't analyzed what made the difference (or in fact what changes
we've introduced to 2.2.13 with the patch, other than the reported
conflicts).

Is there anyone that experienced the same fenomena?
What might be the reason for this?

USB,
We've been working on an USB host controller interface for the MPC850
and now it works with the ACM driver. It doesn't support URB for now.

Cheers
 Bjorn
--
Björn Lundberg, Coach R&D
Honeywell INUcontrol / H&BC, SW10
Tel: +46 (0)33 23 23 85  Fax: +46 (0)33 23 23 10
bjorn.lundberg@inu.se    www.inu.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
