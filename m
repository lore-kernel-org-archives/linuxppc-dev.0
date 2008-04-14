Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 01F08DE164
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 23:40:35 +1000 (EST)
Message-ID: <48035E93.6070300@freescale.com>
Date: Mon, 14 Apr 2008 08:39:31 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] Driver for Freescale 8610 and 5121 DIU
References: <12053582234100-git-send-email-yorksun@freescale.com>	<12053582231281-git-send-email-yorksun@freescale.com>	<47D8572C.8090501@gmail.com>	<47FFDBFF.1030809@gmail.com>
	<20080411221817.0b1eb414.akpm@linux-foundation.org>
In-Reply-To: <20080411221817.0b1eb414.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@gmail.com>, York Sun <yorksun@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton wrote:

> Thanks.  I've made a note that this patch has outstanding issues.  Usually
> this means that I'll defer merging it until they have been addressed:
> either by fixing them or by successfully arguing against the objections.  

Sorry, I must have gotten out of sync.  What are the outstanding issues?  I was
under the impression that the latest patch (v5) resolved everything.  In fact,
the last email from you (dated 4/1) said that you picked it up, minus the defconfig.

-- 
Timur Tabi
Linux kernel developer at Freescale
