Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.204])
	by ozlabs.org (Postfix) with ESMTP id 5360067D57
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Jul 2005 00:04:08 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i28so611339wra
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Jul 2005 07:04:07 -0700 (PDT)
Message-ID: <528646bc050723070419b8f914@mail.gmail.com>
Date: Sat, 23 Jul 2005 10:04:07 -0400
From: Grant Likely <glikely@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [PATCH 0/3] Support for SPI busses and devices
Reply-To: Grant Likely <glikely@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Request for Comment:

Here is a set of patches that adds SPI support to linux.  I'm looking
for feedback on these and I'd like to eventually get the SPI
infrastructure into mainline

There are three patches.  The first patch creates a new bus type
'spi'.  The second adds support for using a PSC on the MPC52xx as an
SPI bus master.  The third is a driver for an ks8995m managed switch
from Micrel.

Patch generated from 2.6.12

Cheers,
g.
