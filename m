Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0B882DE069
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 00:56:05 +1000 (EST)
Date: Sat, 7 Jul 2007 10:07:08 -0500
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 2/2] [POWERPC] mmio ide support for mpc8349-itx target
Message-ID: <20070707150708.GA5387@lixom.net>
References: <20070707094852.9473.21013.stgit@localhost.localdomain>
	<20070707094900.9473.48577.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070707094900.9473.48577.stgit@localhost.localdomain>
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

On Sat, Jul 07, 2007 at 01:49:00PM +0400, Vitaly Bordug wrote:
> 
> This updates relevant platform code
> (freescale mpc8349itx target) to make the CompactFlash
> work in TrueIDE mode.

Shouldn't you be writing a PCMCIA driver instead for the CF, so it
handles other devices as well? Then you get storage "for free", as
well as hotplug, etc.

It's not hard:

http://patchwork.ozlabs.org/linuxppc/patch?person=124&id=12044


-Olof
