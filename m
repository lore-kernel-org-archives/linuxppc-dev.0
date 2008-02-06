Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 73496DE34C
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 05:06:51 +1100 (EST)
Message-ID: <47A9F734.9050005@am.sony.com>
Date: Wed, 06 Feb 2008 10:06:44 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3] [POWERPC] bootwrapper: build multiple cuImages
References: <20080206164656.10079.15210.stgit@trillian.secretlab.ca>
In-Reply-To: <20080206164656.10079.15210.stgit@trillian.secretlab.ca>
Content-Type: text/plain; charset=UTF-8
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, paulus@samba.org,
	scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> diff --git a/arch/powerpc/boot/cuboot-hpc2.c b/arch/powerpc/boot/cuboot-mpc7448hpc2.c
> similarity index 100%
> rename from arch/powerpc/boot/cuboot-hpc2.c
> rename to arch/powerpc/boot/cuboot-mpc7448hpc2.c


This is not a proper patch.

No rule to make target `arch/powerpc/boot/cuboot-mpc7448hpc2.c
