Return-Path: <marcelo@kvack.org>
Received: from kanga.kvack.org (kanga.kvack.org [66.96.29.28])
	by ozlabs.org (Postfix) with ESMTP id C2BCBDDE04
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Sep 2007 23:14:36 +1000 (EST)
Date: Mon, 24 Sep 2007 08:43:20 -0400
From: Marcelo Tosatti <marcelo@kvack.org>
To: Jochen Friedrich <jochen@scram.de>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH0/4] Various bug fixes
Message-ID: <20070924124320.GA5648@dmt>
References: <46F6C9B0.8020200@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46F6C9B0.8020200@scram.de>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Paul, please apply.

On Sun, Sep 23, 2007 at 10:16:48PM +0200, Jochen Friedrich wrote:
> Here is a series fixing some bugs for 8xx powerpc CPUs.
> 
> 1. [POWERPC] Fix copy'n'paste typo in commproc.c
> 2. [PPC] Fix cpm_dpram_addr returning phys mem instead of virt mem
> 3. [PPC] Compile fix for 8xx CPM Ehernet driver
> 4. [POWERPC] Fix cpm_uart driver
> 
> This series can be pulled from git://git.bocc.de/dbox2.git ppc-fixes
> 
> Thanks,
> Jochen
