Message-ID: <3B36F1B3.BFC12A3B@student.ethz.ch>
Date: Mon, 25 Jun 2001 10:09:23 +0200
From: Luc Knoepfli <luck@student.ethz.ch>
MIME-Version: 1.0
To: LinuxDev <linuxppc-dev@lists.linuxppc.org>
Subject: G4 upgrade cards and oldworld mac's, BootX
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


So I have now my G4 upgrade card. And it works well in a G3 233.
To use the secondary cache, I had to get the l2cr value in MacOS
(powerlogix tools) and then write it into the BootX settings.
If I start now with BootX (1.2.2) in debug mode (option-key), I get a
'supports l2cr setting: 0' and it takes the value from the settings file
(otherwise I couldn't get the cache working!).

First question:
Is it in some way unsure to add the ppc7400 to the l2cr supported
processors, in the source code of BootX?

Second question.
Under MacOS the AltiVec unit has to be enabled by software (INIT), is
this done by the kernel under Linux?
If not, are there tools to do this?

Thanks in advance,
Luc


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
