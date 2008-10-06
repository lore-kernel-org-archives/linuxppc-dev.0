Return-Path: <leon.woestenberg@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by ozlabs.org (Postfix) with ESMTP id 7EE84DDDEA
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2008 00:42:42 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c34so135247anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 06 Oct 2008 06:42:40 -0700 (PDT)
Message-ID: <c384c5ea0810060642l2bbc2a08y5725a28b6d45aa8d@mail.gmail.com>
Date: Mon, 6 Oct 2008 15:42:40 +0200
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: linuxppc-dev@ozlabs.org, "Jerry Huang" <Chang-Ming.Huangcm@freescale.com>,
	"Tony Li" <Tony.Li@freescale.com>, "Stuart Hughes" <seh@zee2.com>
Subject: MPC8315ERDB PCI Express support status?
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

Hello all,


can Freescale or any of the powerpc maintainers indicate to what
extend PCI Express support for the MPC8315E processor has been merged
to Linux mainline, or what is still needs review or attention?

I could find u-boot and Linux patches provided by Freescale in their
open-source patch pool:

http://www.bitshrine.org/gpp/
http://www.bitshrine.org/gpp/linux-fsl-2.6.24.3-MPC8315ERDB-pcie-INTx-support.patch

but I could not easily identify what has been merged upstream.


My first goal (and hardware on my desk) would be to test an Intel PCIe
PRO/1000 Ethernet adapter, as a start to add a custom PCIe FPGA
device.

Regards,
-- 
Leon
