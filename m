Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id 654E9683A1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Sep 2005 03:20:45 +1000 (EST)
Date: Fri, 23 Sep 2005 10:20:38 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Roland Dreier <rolandd@cisco.com>
Message-ID: <20050923102038.G21055@cox.net>
References: <2005922203.92drttvd27WS9dXk@cisco.com>
	<2005922203.UPGbNSgrHKasoXYq@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2005922203.UPGbNSgrHKasoXYq@cisco.com>;
	from rolandd@cisco.com on Thu, Sep 22, 2005 at 08:03:35PM -0700
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2/4] [PPC32] Add 440SPe support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Sep 22, 2005 at 08:03:35PM -0700, Roland Dreier wrote:
> Add support for the AMCC PowerPC 440SPe SoC.
> 
> Signed-off-by: Roland Dreier <rolandd@cisco.com>
> 
> ---
> 
>  arch/ppc/kernel/cputable.c          |   10 +++
>  arch/ppc/platforms/4xx/Kconfig      |    8 ++
>  arch/ppc/platforms/4xx/Makefile     |    1 
>  arch/ppc/platforms/4xx/amcc440spe.c |  134 +++++++++++++++++++++++++++++++++++
>  arch/ppc/platforms/4xx/amcc440spe.h |   64 +++++++++++++++++

Please change these new files to ppc440spe.*.  After the new EMAC
driver is merged, we are planning a Great Renaming(tm) to make the current
filenames be vendor neutral. i.e. ibm4*->ppc4*

-Matt
