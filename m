Message-ID: <40EDC59E.9020403@rossvideo.com>
Date: Thu, 08 Jul 2004 18:07:26 -0400
From: Ralph Siemsen <rsiemsen@rossvideo.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: ibm_ocp ethernet OPB clocks
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In pretty much all versions of the kernel (I checked 2.4.x, 2.6.7), one
finds in drivers/net/ibm_ocp/ibm_ocp_emac.h:

#define EMAC_M1_OPB_CLK_66              0x00000010      /* 66Mhz */
#define EMAC_M1_OPB_CLK_83              0x00000008      /* 83hz */

I believe these bitfield values are reversed... at least according to
the 440GX usermanual, page 879.  Bug/typo?  Is the usermanual wrong?  Or
perhaps other 4xx series processors have different definitions?

The definitions for 100MHz and >100MHz appear to be correct though.

Is there a current maintainer for this driver?

-Ralph


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
