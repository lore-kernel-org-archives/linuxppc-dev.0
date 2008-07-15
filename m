Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2790DDE650
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 23:21:16 +1000 (EST)
Message-Id: <22D876EA-54D6-4FF1-BA42-DD1F4FD3C2E2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080708173632.GA7140@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 1/2] powerpc/83xx: fix ULPI setup for MPC8315 processors
Date: Tue, 15 Jul 2008 08:21:12 -0500
References: <20080708173632.GA7140@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 8, 2008, at 12:36 PM, Anton Vorontsov wrote:

> We must not use MPC831X_SICR[HL]_* definitions for the MPC8315  
> processors,
> because SICR USB bits locations are not compatible with MPC8313.
>
> This patch fixes ULPI workability on MPC8315E-RDB boards.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/platforms/83xx/mpc83xx.h |    4 ++++
> arch/powerpc/platforms/83xx/usb.c     |   24 +++++++++++++++---------
> 2 files changed, 19 insertions(+), 9 deletions(-)

applied.

- k
