Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6897DB7C14
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Dec 2009 14:12:04 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: Workaround MPC8572/MPC8536 GPIO 1 errata.
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1250056659-420-1-git-send-email-felix@embedded-sol.com>
Date: Thu, 10 Dec 2009 21:11:31 -0600
Message-Id: <42E7943D-60C8-4E59-A08A-8AC0C0ED3CB8@kernel.crashing.org>
References: <> <1250056659-420-1-git-send-email-felix@embedded-sol.com>
To: Felix Radensky <felix@embedded-sol.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 12, 2009, at 12:57 AM, Felix Radensky wrote:

> On MPC8572 and MPC8536 the status of GPIO pins configured
> as output cannot be determined by reading GPDAT register.
> Workaround by reading the status of input pins from GPDAT
> and the status of output pins from a shadow register.
> 
> Signed-off-by: Felix Radensky <felix@embedded-sol.com>
> ---
> arch/powerpc/sysdev/mpc8xxx_gpio.c |   21 ++++++++++++++++++++-
> 1 files changed, 20 insertions(+), 1 deletions(-)

applied to next

- k
