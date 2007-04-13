Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CE7ECDDE1F
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Apr 2007 03:53:07 +1000 (EST)
Date: Fri, 13 Apr 2007 12:52:57 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/4 v2] powerpc: document max-speed and interface-type
	properties
Message-Id: <20070413125257.77b9f16e.kim.phillips@freescale.com>
In-Reply-To: <C04B1BEB-02F9-441A-9039-CE0E01E1F4B4@kernel.crashing.org>
References: <20070413012542.343eb848.kim.phillips@freescale.com>
	<B273DC06-E4DF-4FF5-88E8-2E6C634C98DA@kernel.crashing.org>
	<20070413123639.6485797b.kim.phillips@freescale.com>
	<C04B1BEB-02F9-441A-9039-CE0E01E1F4B4@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 13 Apr 2007 12:42:31 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> can we call this something like rgmii-internal-delay or something a  
> bit more descriptive than -id (which makes one think identifier).

it's RGMII specification nomenclature; p. 5 of the rgmii spec specifically states "Devices which implement internal delay shall be referred to as RGMII-ID."

Kim
