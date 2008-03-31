Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id D6D2EDDE1D
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 19:44:12 +1000 (EST)
Message-ID: <47F0B26A.10801@grandegger.com>
Date: Mon, 31 Mar 2008 11:44:10 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Using FEC on a MPC5200 with default PHY configuration
References: <47F0ACC7.9080709@grandegger.com>
In-Reply-To: <47F0ACC7.9080709@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Grandegger wrote:
> Hello,
> 
> is it possible to use the FEC on a MPC5200 with the default hardware PHY
> configuration. I mean running the link with a default speed without
> handling or even touching the PHY like U-Boot does. I removed the PHY
> entries from the DTS file and disabled CONFIG_FEC_MPC52xx_MDIO but it
> did not work.

To be more precise, I want to support a 3-Port managed switch with PHY
from Micrel using the direct switch link.

TIA.

Wolfgang.
