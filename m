Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 87095DE118
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 00:50:45 +1000 (EST)
Date: Sat, 7 Jul 2007 10:01:47 -0500
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 1/2] [ide] mmio ide support
Message-ID: <20070707150147.GA2202@lixom.net>
References: <20070707094852.9473.21013.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070707094852.9473.21013.stgit@localhost.localdomain>
From: olof@lixom.net (Olof Johansson)
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jul 07, 2007 at 01:48:52PM +0400, Vitaly Bordug wrote:
> 
> This adds support for MMIO IDE device like CompactFlash 
> in TrueIDE mode.

Doesn't this duplicate most of pata_platform, but as the
no-longer-preferred legacy IDE device? Did you try using
pata_platform instead?


-Olof
