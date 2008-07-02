Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CCF48DDE18
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 10:57:40 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m620vXTd016847
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Jul 2008 20:57:33 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m620uLBD064322
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Jul 2008 20:56:21 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m620uLjZ019769
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Jul 2008 20:56:21 -0400
Date: Tue, 1 Jul 2008 20:53:01 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: John Linn <john.linn@xilinx.com>
Subject: Re: [PATCH] powerpc: Xilinx: add dts file for ML507 board
Message-ID: <20080701205301.1acdf087@zod.rchland.ibm.com>
In-Reply-To: <20080701230301.E23A7198050@mail68-va3.bigfish.com>
References: <20080701230301.E23A7198050@mail68-va3.bigfish.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 1 Jul 2008 16:02:54 -0700
John Linn <john.linn@xilinx.com> wrote:

> This new file adds support for the ML507 board which
> has a Virtex 5 FXT FPGA with a 440.

I haven't looked this over thoroughly yet, but an immediate question
comes to mind.  Any way this can get converted to dts-v1 before it's
pulled in?  All of the in-tree DTS files should be dts-v1 now, so I'd
like to have new ones go in as that.

(Also CC'ing the proper list)

josh
