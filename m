Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <000c01c2cc25$2ee65b20$5e207aa1@fish>
From: "Jason Park" <jason@amadeus.kist.re.kr>
To: "LINUX MAILING LIST" <linuxppc-embedded@lists.linuxppc.org>
Subject: Still having problems trying to get it to boot: PPCBOOT, MPC8260
Date: Tue, 4 Feb 2003 17:12:08 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Unfortunately, I'm still having some problems, and any info or light as to
which direction to go would be helpful (bear with me, I'm still an undergrad
student learning about all this stuff)

so here is what I have done so far
1)successfully installed ELDK from the DENX website on Red Hat 8.0 with
ppc_8260-gcc cross compiler working fine.

2)unpacked the source for PPCBOOT, my board is specifically the ep8260.
since it has a HRW set to boot from location 0xfff0000 in flash, i change
the appropriate starting location in the config.mk file for PPCBOOT then I

make distclean
make ep8260_config
make all

i get three ppcboot files
ppcboot (573516)
ppcboot.bin(181136)
ppcboot.srec(543460)
.. put them in the /tftpboot directory.

3)burn them into location 0xfff00000 with my trusty bdi.  it burns
correctly. (i can see that it has in fact written to that location with md
0xfff00000)

4)at prompt, i type in "reset", then "go" and it throws me into debug mode.
(or "go 0xfff00000")

i think i have followed the README from PPCBOOT correctly, as well as other
documentation given.  Is there a configuration or something im missing?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
