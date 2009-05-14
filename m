Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 33FAFDE00C
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 22:59:33 +1000 (EST)
Message-Id: <1F461318-8C17-4C70-92CD-D6E04E8C19C9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: SDHCI_QUIRK_INVERTED_WRITE_PROTECT and compatiable
Date: Thu, 14 May 2009 07:57:25 -0500
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Sandeep Gopalpet <sandeep.kumar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton,

I'm guessing the following commit is to deal with some FSL ref board  
specific issue:

commit c5075a1089e808d8f471ce21b02810cc98ab2692
Author: Anton Vorontsov <avorontsov@ru.mvista.com>
Date:   Tue Mar 17 00:13:54 2009 +0300

     sdhci: Add support for hosts reporting inverted write-protect state

     This patch adds SDHCI_QUIRK_INVERTED_WRITE_PROTECT quirk. When
     specified, the sdhci driver will invert WP state.

     p.s. Actually, the quirk is more board-specific than
          controller-specific.

--

If so I don't think we should unconditionally be setting this flag  
based on the compatible.  Was this just on the MPC837x RDB boards?   
Also on the MDS?

- k
