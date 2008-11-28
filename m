Return-Path: <leon.woestenberg@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id 82062DDDDB
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2008 23:51:00 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so300844qwb.15
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2008 04:50:58 -0800 (PST)
Message-ID: <c384c5ea0811280450t3e199da6s1fcdf903f63f9622@mail.gmail.com>
Date: Fri, 28 Nov 2008 13:50:58 +0100
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: u-boot@lists.denx.de, "Linux PPC" <linuxppc-dev@ozlabs.org>
Subject: ppc4xx: u-boot sees PCIe endpoint, linux does not.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

AMCC PPC460EX canyonlands board with an FPGA PCIe end point:

u-boot sees the end point, but Linux does not:

U-Boot 1.3.3-00249-ga524e11 (Jun 30 2008 - 16:05:51)
CPU:   AMCC PowerPC 460EX Rev. A at 800 MHz (PLB=200, OPB=100, EBC=100 MHz)
<...>
Board: Canyonlands - AMCC PPC460EX Evaluation Board, 2*PCIe, Rev. 16
<...>
PCIE1: successfully set as root-complex
        02  00  2071  2071  00ff  00


Now, if I re-program the end-point FPGA during the u-boot boot
time-out, Linux will recognize the end-point.

Any takers on what I should start looking for?

Regards,
-- 
Leon
