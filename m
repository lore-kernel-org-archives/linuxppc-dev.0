Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by ozlabs.org (Postfix) with ESMTP id A589E679F0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 06:38:22 +1000 (EST)
Date: Mon, 9 May 2005 13:38:09 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Pantelis Antoniou <panto@intracom.gr>
Message-ID: <20050509133808.A16776@cox.net>
References: <427F4D3F.1010802@intracom.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <427F4D3F.1010802@intracom.gr>;
	from panto@intracom.gr on Mon, May 09, 2005 at 02:45:03PM +0300
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH  03/04] Freescale Ethernet combined driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, May 09, 2005 at 02:45:03PM +0300, Pantelis Antoniou wrote:
> Hi
> 
> The following patch is a combined FCC/FEC ethernet driver
> for the Freescale line of PowerQUICCs.
> 
> FECs on 8xx and FCCs on 82xx are supported.
> 
> This part of the patch contains the mac drivers
> for FEC & FCC.

As mentioned on IRC, this needs to be scrubbed of all iopa() usage
in favor of standard DMA API calls.

-Matt
