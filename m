Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id AD92ADDE48
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 10:55:36 +1000 (EST)
Date: Sun, 6 May 2007 19:57:23 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 4/6] Device tree aware EMAC driver
Message-ID: <20070507005723.GA4453@lixom.net>
References: <20070504055455.GA25922@localhost.localdomain>
	<20070507003019.GB16165@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070507003019.GB16165@localhost.localdomain>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 07, 2007 at 10:30:19AM +1000, David Gibson wrote:
> This is BenH's rewritten, device tree aware driver for the IBM/AMCC
> EMAC, ethernet MAC controller ASIC found on various 4xx CPUs and also
> the Axon bridge.  Tweaked to build on current kernels.

Shouldn't benh have a signoff line on it as well in that case?

Is it ibm_emac or ibm_newemac? All file headers say ibm_emac, and there's
still Kconfig references to ibm_emac.

(Is this just posted FYI? If not, it should really go to netdev/jgarzik
instead, right?)


-Olof
