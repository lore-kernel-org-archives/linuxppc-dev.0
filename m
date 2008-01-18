Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 60909DE059
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 03:31:50 +1100 (EST)
Date: Fri, 18 Jan 2008 09:31:21 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: Olaf Hering <olaf@aepfle.de>
Message-ID: <20080118163121.GA7720@farnsworth.org>
References: <20080118093805.GA28004@aepfle.de>
MIME-Version: 1.0
In-Reply-To: <20080118093805.GA28004@aepfle.de>
Subject: Re: [PATCH] add modalias info to mv643xx_eth.ko
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 18, 2008 at 10:38:05AM +0100, Olaf Hering wrote:
> mv643xx_eth has an platform modalias file in sysfs.
> But the module itself has no alias: line. Autoloading fails
> without the alias info in the module.
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>

Acked-by: Dale Farnsworth <dale@farnsworth.org>
