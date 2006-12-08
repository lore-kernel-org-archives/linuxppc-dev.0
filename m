Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B0E8567B6D
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 09:53:11 +1100 (EST)
Subject: Re: [patch] powerpc: add scanning of ebc bus to of_platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Krafft <krafft@de.ibm.com>
In-Reply-To: <20061208114113.2191e446@localhost>
References: <20061208114113.2191e446@localhost>
Content-Type: text/plain
Date: Sat, 09 Dec 2006 09:53:01 +1100
Message-Id: <1165618381.1103.89.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-12-08 at 11:41 +0100, Christian Krafft wrote:
> Subject: powerpc: add scanning of ebc bus to of_platform
> 
> This patch add scanning of ebc bus to of_platform, which is needed
> to recognize devices located on that bus.
> 
> Signed-off-by: Christian Krafft <krafft@de.ibm.com>

I'd like other people opinions here... But I'm tempted to remove the
"default" list of bus types here and have it always be passed by the
platform... just in case.

If you guys prefer to keep it that way, then fine, patch is

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Ben.
