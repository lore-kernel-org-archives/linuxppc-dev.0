Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 12891DDE34
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 10:19:28 +1100 (EST)
Date: Thu, 14 Feb 2008 17:21:52 -0600
From: Olof Johansson <olof@lixom.net>
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH 0/4]: Respun LMB patches.
Message-ID: <20080214232152.GB15724@lixom.net>
References: <20080213.170938.34536425.davem@davemloft.net>
	<38133B3C-75A2-4465-9484-7BF8E7E85D1D@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <38133B3C-75A2-4465-9484-7BF8E7E85D1D@freescale.com>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org,
	David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 14, 2008 at 02:58:22PM -0600, Becky Bruce wrote:

> Thanks for picking up the patches from Kumar and myself and fitting  
> them into your series - this is much appreciated.  FYI, I applied the  
> entire patch series to my local tree and test-booted both mpc8641 and  
> mpc8568mds and both build and boot cleanly. I also built pasemi and  
> ebony, those build cleanly as well.

pasemi_defconfig boots happily on my boards here. I've kicked off my
"build all powerpc defconfigs" script while I leave the house for a
couple of hours, but as others have said, no problems are expected...


-Olof
