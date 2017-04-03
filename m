Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxSbz3yz8zDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Apr 2017 20:13:19 +1000 (AEST)
In-Reply-To: <1461689378-10978-1-git-send-email-yang.shi@windriver.com>
To: yshi <yang.shi@windriver.com>, <alistair@popple.id.au>,
 <mporter@kernel.crashing.org>, <benh@kernel.crashing.org>, <paulus@samba.org>,
 <linuxppc-dev@lists.ozlabs.org>, <yang.shi@windriver.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: powerpc/4xx: make sam440ep_setup_rtc init
Message-Id: <3vxSbz0Gymz9s81@ozlabs.org>
Date: Mon,  3 Apr 2017 20:13:18 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-04-26 at 16:49:38 UTC, yshi wrote:
> sam440ep_setup_rtc is just called by machine_device_initcall, and it calls
> i2c_register_board_info which is init too, so the lack of __init may cause
> mismatch warning when linking kernel.
> 
> Signed-off-by: Yang Shi <yang.shi@windriver.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/adec9a2e7ca3b4193818f9a7b39563

cheers
