Date: Fri, 19 Dec 2003 03:22:18 -0600
To: linuxppc-dev@lists.linuxppc.org
Subject: aic7xxx revisited...
Message-ID: <20031219092217.GA20303@uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: alecwood@cs.uchicago.edu (Alec Wood)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm attempting to compile a stock 2.4.23 on my PowerMac G4/667, and
appear to be hitting the same bug that Ethan Weinstein reported a while
back.  Have there been any insights into the source of the problem?

I haven't been able to get any good diagnostic information yet (other
than the SRR1=149030 bit), and Ben's advice on getting xmon to print to
the screen doesn't appear to be germaine to the newer kernel.

I actually first hit the problem whilst installing YDL 3.0.1 -- the
installer crashed at every boot until I pulled the SCSI card out
(Adaptec AHA-7850 (rev 3)).

I've also found that the same crash occurs with both the new and old
aic7xxx drivers, and also as a compiled-in driver or at insmod time. My
old 2.4.18 works great (new aic7xxx), but I'd like to get up-to-date...

Any thoughts?
-Alec

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
