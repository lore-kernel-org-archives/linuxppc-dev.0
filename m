Return-Path: <bunk@stusta.de>
Received: from mailhub.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with ESMTP id 7F519DDDCA
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jul 2007 01:27:30 +1000 (EST)
Date: Sat, 28 Jul 2007 17:27:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [2.6 patch] arch/powerpc/Kconfig: fix the EMBEDDED6xx dependencies
Message-ID: <20070728152704.GA30976@stusta.de>
References: <20061201115410.GV11084@stusta.de>
	<17779.37050.4039.942954@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <17779.37050.4039.942954@cargo.ozlabs.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 04, 2006 at 02:06:34PM +1100, Paul Mackerras wrote:
> Adrian Bunk writes:
> 
> > This patch changes the EMBEDDED6xx dependencies to the equivalent 
> > dependency that seems to have been intended.
> 
> Nack - CONFIG_EMBEDDED6xx is going away entirely, soon.

Still there - and still with this strange dependency.

> Paul.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
