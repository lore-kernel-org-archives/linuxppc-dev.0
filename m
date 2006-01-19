Return-Path: <grant@secretlab.ca>
Received: from localhost.secretlab.ca (S0106001346b91f0f.cg.shawcable.net
	[68.147.210.21]) by ozlabs.org (Postfix) with ESMTP id 880BF681B8
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Jan 2006 19:11:37 +1100 (EST)
Date: Thu, 19 Jan 2006 01:11:34 -0700
From: "Grant C. Likely" <grant.likely@secretlab.ca>
To: linuxppc-embedded@ozlabs.org, akonovalov@ru.mvista.com,
	peter.ryser@xilinx.com
Subject: [PATCH 0/9] Xilinx Virtex ML300 & ML403 platform bus support
Message-ID: <20060119081134.GA24867@weasley-twins.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

New set of virtex support patches.  Major change here is that the
changes have reverted to using the EDK generated "Linux redefines"
instead of custom #define value.
