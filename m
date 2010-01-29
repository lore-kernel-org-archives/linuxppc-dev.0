Return-Path: <johnny.hacking@gmail.com>
Received: from mail-pw0-f43.google.com (mail-pw0-f43.google.com
	[209.85.160.43]) by ozlabs.org (Postfix) with ESMTP id 2CF54B7D12
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Jan 2010 17:29:05 +1100 (EST)
Received: by pwj11 with SMTP id 11so1168216pwj.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 28 Jan 2010 22:29:04 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 29 Jan 2010 14:29:04 +0800
Message-ID: <cb9ecdfa1001282229n21a11aa9sf15ebf279990862a@mail.gmail.com>
Subject: Freescale MPC8313 TSEC SGMII problem.
From: Johnny Hung <johnny.hacking@gmail.com>
To: linux-embedded@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

I have a Freescale MPC8313 customized board and want to confiugre
TSEC1 to SGMII. Would you please help me for this question,

1). Is it possible for MPC8313 TSEC1 connect to Ethernet Switch by
SGMII (without phy), like below diagram.

[MPC8313 TSEC1]  <====SGMII====> [Ethernet Switch]

2). If yes in 1), how to configure it in MPC8313, as I know it can set
TSEC1 to SGMII in LTIB uboot setting. How about in Linux Kernel driver
? Is it need extra setting or patch?

BRs, H. Johnny
