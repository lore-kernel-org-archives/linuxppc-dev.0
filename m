Date: Fri, 20 Apr 2001 15:29:32 -0400 (EDT)
From: Conrad H Ziesler <cziesler@umich.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: ibook sleep, NMI edge vs level trigger. 
Message-ID: <Pine.SOL.4.10.10104201522100.26944-100000@galaxian.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


i dunno if this is news to anyone, but apparently
(the source comment says "copied from OS9 code")
the NMI is masked and switched from edge to level triggered before
sleeping and unmasked and returned to edge triggered after wake.

is the low level sleep handler doing this correctly ?

refer to:
xnu-4-2/iokit/Drivers/platform/drvAppleNMI/AppleNMI.cpp

--conrad


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
