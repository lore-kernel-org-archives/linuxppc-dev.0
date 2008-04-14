Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 89C57DE05D
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 01:47:14 +1000 (EST)
Message-ID: <48037C55.7060105@freescale.com>
Date: Mon, 14 Apr 2008 10:46:29 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] Driver for Freescale 8610 and 5121 DIU
References: <12053582234100-git-send-email-yorksun@freescale.com>	<12053582231281-git-send-email-yorksun@freescale.com>	<47D8572C.8090501@gmail.com>	<47FFDBFF.1030809@gmail.com>	<20080411221817.0b1eb414.akpm@linux-foundation.org>	<48035E93.6070300@freescale.com>
	<48035F98.1020404@gmail.com>	<48036001.10905@freescale.com>
	<4803620C.6020905@gmail.com>	<48036649.6000409@freescale.com>
	<4803690A.3080105@gmail.com> <48036F00.6080200@freescale.com>
	<48037BA4.6070201@gmail.com>
In-Reply-To: <48037BA4.6070201@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, York Sun <yorksun@freescale.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jiri Slaby wrote:

> Mainly because you can sleep inside locked mutex and because spinlock shouldn't
> be used for too many lines of code (busy waiting etc.). I think ldd3 will be
> more descriptive than me here :).

Ok, I'll look into it.

Andrew, do you want us to respin the patch, or would you be willing to let us
make the change in a follow-up patch?

-- 
Timur Tabi
Linux kernel developer at Freescale
