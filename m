Return-Path: <SWarren@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 25 Mar 2005 09:19:59 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B005FDAFFC@hqemmail02.nvidia.com>
From: "Stephen Warren" <SWarren@nvidia.com>
To: "Caruso, Nick" <ncaruso@irobot.com>,
	<linuxppc-embedded@ozlabs.com>
Subject: RE: Question regarding Interrupt "delivery" to user mode process
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is certainly do-able.

Take a look at the Gelato project - they actually are able to do whole
user-mode device drivers for PCI. You can probably snag some of their
kernel->user-mode IRQ notification code for what you want.

http://www.gelato.unsw.edu.au/IA64wiki/UserLevelDrivers=20

--=20
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html
