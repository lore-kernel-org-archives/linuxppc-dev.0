Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17724.31710.434195.320003@cargo.ozlabs.ibm.com>
Date: Mon, 23 Oct 2006 18:22:54 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Liu Dave-r63238" <DaveLiu@freescale.com>
Subject: Re: [PATCH] Fix the UCC rx tx clock of QE
In-Reply-To: <995B09A8299C2C44B59866F6391D26351C2E54@zch01exm21.fsl.freescale.net>
References: <995B09A8299C2C44B59866F6391D26351C2E54@zch01exm21.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Liu Dave-r63238 writes:

> CLK16 of CMXUCR3 and CMXUCR4 registers are missed in
> ucc_set_qe_mux_rxtx().
> This patch adds the CLK16 to the function. MPC8323EMDS board ethernet
> interface
> with RMII is use the CLK16 as the rx and tx clock.

The patch doesn't apply because your mailer has wrecked the
whitespace...

Paul.
