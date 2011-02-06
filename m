Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0B170B7109
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Feb 2011 10:51:54 +1100 (EST)
Subject: Re: [PATCH 1/2] video, sm501: add OF binding to support SM501
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Heiko Schocher <hs@denx.de>
In-Reply-To: <1291451028-22532-1-git-send-email-hs@denx.de>
References: <1291451028-22532-1-git-send-email-hs@denx.de>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Feb 2011 10:45:20 +1100
Message-ID: <1297035920.14982.16.camel@pasglop>
Mime-Version: 1.0
Cc: linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-12-04 at 09:23 +0100, Heiko Schocher wrote:
> - add binding to OF, compatible name "smi,sm501"
> 
> - add read/write functions for using this driver
>   also on powerpc plattforms

 .../...

Who plans to merge that patch series ? I'm happy for whoever is doing
that to take the powerpc patch at the end (that adds the entry to
the .dts file) with my

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Cheers,
Ben.
