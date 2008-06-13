Return-Path: <Leonid@a-k-a.net>
Received: from mis011.exch011.intermedia.net (mis011.exch011.intermedia.net
	[64.78.21.10]) by ozlabs.org (Postfix) with ESMTP id 61097DE108
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Jun 2008 03:19:34 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Device tree for powerpc boards.
Date: Fri, 13 Jun 2008 10:07:28 -0700
Message-ID: <406A31B117F2734987636D6CCC93EE3C03A7042C@ehost011-3.exch011.intermedia.net>
From: "Leonid" <Leonid@a-k-a.net>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi:

I am using u-boot (1.3.0.rc3) and Linux (2.6.23) on Frescale MPC8544DS
board. This is my first exposure to the powerpc architecture (used to be
ppc in old days), so I have been reading all available manuals I could
find on the subject.=20

I think I do understand the picture but need some minor clarifications.

1) Is the usage of device tree absolutely mandatory for powerpc boards
or just recommended and by combining appropriate defines in u-boot and
linux it can be avoided?=20

2) I understood that I can add my proprietary drivers without creating
nodes for them in the tree, is it correct?

3) In order to compile DT blob from DT source, DT compiler (dtc) is
required. I have installed one on my ubuntu machine and successfully
compiled source, creating a blob. Is this the only way to go? Perhaps
there is some target in Linux or u-boot Makefiles which does this job?=20

Thanks,

Leonid.
