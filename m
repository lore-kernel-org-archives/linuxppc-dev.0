From: xiaogeng_jin@agilent.com
Message-ID: <9153F74610B7D311B83900902771C871124D93FA@axcs07.cos.agilent.com>
To: ElTopo@myrealbox.com, linuxppc-embedded@lists.linuxppc.org
Subject: RE: ppc linux kernel 2.4.4 for ppc440/EBony using ELDK 2.0.2? 
Date: Thu, 3 Apr 2003 18:41:18 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Search EBony and ELDK in this mail list. THis topic has been discussed for several times. A short answer is as follows.

#kbuild_2_4_nostdinc	:= -nostdinc -iwithprefix include
kbuild_2_4_nostdinc	:= -nostdinc $(shell $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')

- Shawn.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
