Message-Id: <v04003a00b627c64303c3@[24.70.162.12]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 2 Nov 2000 20:16:20 -0600
To: Linux/PPC Dev <linuxppc-dev@lists.linuxppc.org>
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Promise ATA{66,100} PCI cards work
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Just as a note for anyone interested, with 2.2.17 + pci patches + ide
patches, both my 9600/200mp and my friend's 7600/120 can talk to the
Promise ATA66 and ATA100 boards.

Bad things happen if I try to do things like 'hdparm -Xnn /dev/hde' or 'cat
/proc/ide/pdc202xx' but I don't tend to do that very often so it doesn't
bother me. Everything else seems to work peachy-keen.

Of course, IDE still sucks, but if you can't get enough of those cheap
drives... ;)


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
