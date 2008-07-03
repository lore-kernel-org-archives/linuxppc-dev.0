Return-Path: <glikely@secretlab.ca>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.178])
	by ozlabs.org (Postfix) with ESMTP id C11DBDE16D
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 01:26:47 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so473220pyg.27
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Jul 2008 08:26:46 -0700 (PDT)
Date: Thu, 3 Jul 2008 09:26:14 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Xilinx: add 440 platform support
Message-ID: <20080703152614.GC2284@secretlab.ca>
References: <20080701224829.EC51111E8013@mail35-sin.bigfish.com>
	<20080703091448.4e298ce8@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080703091448.4e298ce8@zod.rchland.ibm.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 03, 2008 at 09:14:48AM -0400, Josh Boyer wrote:
> On Tue, 1 Jul 2008 15:48:26 -0700 John Linn <john.linn@xilinx.com> wrote:
> > +config XILINX_VIRTEX440_GENERIC_BOARD
> > +	bool "Generic Xilinx Virtex 440 board"
> > +	depends on 44x
> > +	default n
> > +	select XILINX_VIRTEX_5_FXT
> 
> If this is for generic Virtex 440 board support, why is it selecting a
> specific Virtex 5 board?  Or am I confused as to what
> XILINX_VIRTEX_5_FXT is?

Virtex 5 FXT if the FPGA chip

Virtex440 is a Virtex 5 with a bitstream that enables the embedded 440
processor.

g.
