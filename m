Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DBB16DDE2A
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 01:21:27 +1100 (EST)
Message-Id: <AF5092BE-3384-44F8-A104-560DD4331726@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Zhang Wei <wei.zhang@freescale.com>
In-Reply-To: <120168907160-git-send-email-wei.zhang@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 3/6] Move include/asm-ppc/rio.h to
	include/asm-powerpc/rio.h
Date: Wed, 30 Jan 2008 08:20:48 -0600
References: <1201689053956-git-send-email-wei.zhang@freescale.com>
	<12016890621727-git-send-email-wei.zhang@freescale.com>
	<120168907160-git-send-email-wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 30, 2008, at 4:30 AM, Zhang Wei wrote:

> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> ---
> include/asm-powerpc/rio.h |   18 ++++++++++++++++++
> include/asm-ppc/rio.h     |   18 ------------------
> 2 files changed, 18 insertions(+), 18 deletions(-)
> create mode 100644 include/asm-powerpc/rio.h
> delete mode 100644 include/asm-ppc/rio.h

it seems with OF we can just git rid of this?

-k
