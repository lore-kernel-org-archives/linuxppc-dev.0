Message-ID: <081f01c013db$364aa100$1952df8d@SOYANG>
From: "Hyun-Joon Cha" <tachyon@postech.ac.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: cpm_enet_down and MAC address change.
Date: Fri, 1 Sep 2000 15:09:39 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="EUC-KR"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello.

In shell, I can't do down ethernet interface.
======================================
# ifconfig eth0 down
dev_close: bug eth0 still running

I checked ethernet driver and found that there are empty code for it.

At cpm_enet_close of arch/ppc/8xx_io/enet.c
===========================================
static int
cpm_enet_close(struct device *dev)
{
        /* Don't know what to do yet.
        */

        return 0;
}

So, I can't down ethernet interface on Linux for MPC850 and can't change MAC addr at runtime also.

Then how can I make it possible? or do someone make module for ethernet and serial driver for MPC?

Maybe it's a good idea to modularize it and make a configuration header file for parallel IO pins to SCCs and SMCs to port Linux easy.

If anybody know it or have a idea please answer.

Thanks in advance.
Have a nice day.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
