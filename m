Message-ID: <585D9BAABBE7D211A2B00000F8050AAF759A09@thebrain.drs.ca>
From: "Karaaslan, Utku" <UKaraasl@drs.ca>
To: LinuxPPC Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: PpcBoot running but not the linux kernel?
Date: Tue, 7 Nov 2000 16:26:21 -0500 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I have ported the ppcboot to our custom board and everything runs correctly
except
the linux kernel :). Basically, it fails to start (no output, just hangs)
and upon checking
with the BDM debugger (Lauterbach) I found out that it was failing right
after the mmu
initialization (in head.S). The IMMR location given in the kernel matches
with the location
set in ppcboot. Would you know what changes I need to make in the Linux
kernel to get
it *starting* on our board? Or, is this a misconfiguration problem with the
ppcboot?

Many thanks in advance.

Utku

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
