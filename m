Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8794E1A032F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 03:24:29 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0065114030F
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2015 03:24:28 +1100 (AEDT)
Date: Wed, 25 Nov 2015 17:16:17 +0100
From: Torsten Duwe <duwe@lst.de>
To: Ian Munsie <imunsie@au1.ibm.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Neuling <mikey@neuling.org>, Anton Blanchard <anton@au1.ibm.com>
Subject: Re: [PATCH] cxl: Fix build failure due to -Wunused-variable
 behaviour change
Message-ID: <20151125161616.GA30262@lst.de>
References: <1442296114-16796-1-git-send-email-imunsie@au.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442296114-16796-1-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 15, 2015 at 03:48:34PM +1000, Ian Munsie wrote:
> --- a/drivers/misc/cxl/Makefile
> +++ b/drivers/misc/cxl/Makefile
> @@ -1,4 +1,4 @@
> -ccflags-y := -Werror
> +ccflags-y := -Werror -Wno-unused-const-variable

JFYI, my gcc-4.3 does not like this switch.
What's the minimum compiler version to build this code?

	Torsten
