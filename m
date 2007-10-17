Return-Path: <linuxppc-embedded@ml.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AA2E0DDEC4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Oct 2007 05:26:55 +1000 (EST)
Received: id: bigeasy by Chamillionaire.breakpoint.cc with local
	(easymta 1.00 BETA 1) id 1IiEXb-0001P7-5R
	for linuxppc-embedded@ozlabs.org; Wed, 17 Oct 2007 21:26:51 +0200
Date: Wed, 17 Oct 2007 21:26:51 +0200
From: Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc>
To: linuxppc-embedded@ozlabs.org
Subject: loading NOR flash from DT
Message-ID: <20071017192651.GA5192@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I have here a MPC8544 DS board with NOR flash on it and Kumar's git
tree. I'm trying to detect this flash with the physmap_of module. I
added a nor_flash block (I used sequoia.dts as an example) into my
device tree on the same level as soc8544 or memory (or between them).
After modprobing physmap_of nothing happend. Then I tried to make a tree
with plb -> opb -> ebc and finally nor_flash but still nothing changed.

Is there a user space dependency or did I just edit my device tree the
wrong way? Any hints are welcome :)

Sebastian
