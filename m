Return-Path: <mqy@263.net.cn>
Received: from smtp.263.net (263.net.cn [211.150.96.21])
	by ozlabs.org (Postfix) with ESMTP id B7001686A2
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Nov 2005 02:56:09 +1100 (EST)
From: "KylongMu" <mqy@263.net.cn>
To: <wd@denx.de>
Date: Sun, 6 Nov 2005 23:55:48 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20051102164644.6D167353A2C@atlas.denx.de>
Message-Id: <20051106155605.60A3EC73@smtp.263.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: Today's 2.6.14 can't finish build with yosemite-defconfig 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Denk
	After cg-update today's kernel repository, I test with these steps:
Make yosemite-defconfig
Make uImage

But the build stops with some errors, last cg-update (5 days ago) is ok.

Cordially,

Kylong Mu
