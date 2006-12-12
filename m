Return-Path: <andrea.galbusera@teamware.it>
Received: from smtp5.aruba.it (smtpd3.aruba.it [62.149.128.208])
	by ozlabs.org (Postfix) with SMTP id 7F86C67CEE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Dec 2006 02:25:29 +1100 (EST)
Subject: Which kernel for Lite5200 based target board?
From: Andrea Galbusera <andrea.galbusera@teamware.it>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Tue, 12 Dec 2006 16:18:48 +0100
Message-Id: <1165936728.32602.59.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I read a lot about this but I'm still confused. I have a Lite5200 based
target board and I'm experimenting with a few kernels but I can't figure
out which is the best to stay with.

Let me say something about my target system:
* It is based on the Lite5200 design
* It uses MPC5200B CPU (the one nowadays available for production)
* Need IDE to support DOM and/or Compact Flash devices (same design of
Lite5200)
* Need ethernet (same hardware design of Lite5200 apart from phy that is
AMD NetPhy AM79C874)
* We have a custom PCI device and a 2.6 kernel module to manage it
* Need some SPI and I2C basic support for system configuration at boot

I'm doing my tests with the following kernels:
* 2.6.16 from Denx git repository
* 2.6.16.11-rt18 from Freescale BSP (based on the ltib build tool)
* 2.6.11 from the same Freescale BSP (based on the ltib build tool)

I know Sylvain Munaut is/was also maintaining a kernel tree with working
support for IDE and Bestcomm. This tree seems not very active to me but
my git wisdom is very very poor and I may be wrong :-(

Unfortunately my tests tell me none of the listed kernels works out of
the box for the target: the former being not officially supported by
DENX for the Lite5200 target, the latter having a Lite5200/Lite5200B
configuration target.

I'm doing tests comparing kernels behavior on both the target board and
the Lite5200 EVB. Some problems seem related to differences between the
boards, some come up with both.

Please, consider this as a preliminary post. I'm looking for general
suggestion on the more convenient kernel to stay with. I know I will
still need some patching to make everything work fine, but I can't spend
too much time on "unpromising" solutions. If useful I can then post
details about the specific problems I have with IDE and ethernet in
particular.

Can you tell me where to find details about the status of the Lite5200
support in the kernels listed above? Or maybe suggest me another kernel
to go with?

Any help is appreciated.


-- 
Andrea Galbusera <andrea.galbusera@teamware.it>
