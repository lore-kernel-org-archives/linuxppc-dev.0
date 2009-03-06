Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.251])
	by ozlabs.org (Postfix) with ESMTP id ED09BDDED7
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Mar 2009 05:08:21 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 33so1111273agc.0
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Mar 2009 10:08:19 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 6 Mar 2009 11:08:18 -0700
Message-ID: <fa686aa40903061008u707b0988s32f04d757d3feb16@mail.gmail.com>
Subject: Please pull mpc52xx-next
From: Grant Likely <grant.likely@secretlab.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hey Ben,

Here are some more for -next.

The following changes since commit 652e8f8d579d61745094e36b4ff085026a332e73:
  Benjamin Herrenschmidt (1):
        Merge commit 'jwb/next' into next

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx next

Grant Likely (2):
      powerpc/5200: Add 'simple-bus' to the of_platform probe list.
      powerpc/4xx: update ml507 .dts file to release reference design

Grzegorz Bernacki (2):
      powerpc/5200: Add digsy-mtc support to mpc5200_defconfig
      powerpc/5200: On the digsy-mtc, configure PSC4 and PSC5 as UARTs

 arch/powerpc/boot/dts/digsy_mtc.dts          |   12 ++--
 arch/powerpc/boot/dts/virtex440-ml507.dts    |  124 +++++++++++++++++++++++---
 arch/powerpc/configs/mpc5200_defconfig       |   71 +++++++++++++--
 arch/powerpc/platforms/52xx/mpc52xx_common.c |    3 +-
 4 files changed, 184 insertions(+), 26 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
