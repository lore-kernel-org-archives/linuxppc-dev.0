From: "\"Jeffrey D. Kowing\" <Jeff Kowing" <jeffrey.d.kowing@jsc.nasa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14813.60363.648514.72914@igor.jsc.nasa.gov>
Date: Fri, 6 Oct 2000 10:12:11 -0500 (CDT)
To: Zhaobin Zhu <zzhu@emc.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Linux boot failed on Sandpoint under baudrate 38400
In-Reply-To: <39DCEA5A.2E9DDE3C@emc.com>
References: <39DCEA5A.2E9DDE3C@emc.com>
Reply-To: jeffrey.d.kowing@jsc.nasa.gov
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You can use a kernel option to override what I believe is the default
of 9600 when the kernel opens the serial port for use as the console.
I have "console=ttyS0,38400" in my #define CMDLINE in
arch/ppc/boot/misc.c.

Zhaobin Zhu writes:
 >
 > Hi,
 >
 > Anybody tried booting Hardhat linux on Sandpoint/603e/755/7400
 > under Baudrate 38400 ?
 >
 > On my sp7400, the boot is ok under 9600, but gives garbled message
 > after "Now booting the kernel" under 38400.
 >
 > I change baudrate in arch/ppc/boot/ns16550.c
 >
 > Does the kernel change the baudrate in other place ?
 >
 > Thanks,
 >
 > --
 >  Zhaobin Zhu
 >  zzhu@emc.com
 >
 >

--
Jeff Kowing
jeffrey.d.kowing1@jsc.nasa.gov

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
