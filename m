Date: Tue, 6 Jul 2004 16:16:52 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: make menuconfig error in latest "bk pull"
Message-ID: <Pine.LNX.4.60.0407061615230.21433@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   i'm probably way behind the curve here, but:

$ make ARCH=ppc menuconfig
scripts/kconfig/mconf arch/ppc/Kconfig
drivers/net/Kconfig:201: can't open file "drivers/net/ibm_ocp/Kconfig"
make[1]: *** [menuconfig] Error 1
make: *** [menuconfig] Error 2
$

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
