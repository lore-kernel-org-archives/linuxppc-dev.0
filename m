Return-Path: <alan.casey5@mail.dcu.ie>
Received: from hawk.dcu.ie (mail.dcu.ie [136.206.1.5])
	by ozlabs.org (Postfix) with ESMTP id C7FDCDE141
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Jul 2008 06:13:50 +1000 (EST)
Date: Wed, 9 Jul 2008 21:13:42 +0100
Message-ID: <4874ECF50000031D@hawk.dcu.ie>
From: "Alan Casey" <alan.casey5@mail.dcu.ie>
Subject: PPC Linux start address on XUPV2P board
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Reply-To: alan.casey5@mail.dcu.ie
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

  I am running the Linux 2.6.24 kernel from the git.xilinx.com source
  tree.
  
  I am just wondering what is the start address that is used for
  the Linux kernel in RAM/SDRAM on the Xilinx XUPV2P board and
  where is this defined in the Linux kernel sources?
  
  Also does the PPC Linux kernel support true 64-bit write/read access
  to peripherals on the XUPV2P board or similar boards?

  Any info. appreciated,
  Regards,
  Alan.
