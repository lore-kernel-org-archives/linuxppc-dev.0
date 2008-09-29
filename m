Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4803DDE17C
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 00:26:10 +1000 (EST)
Message-Id: <7C1F8BC3-F4C0-4276-BEA3-ECCA2F7D1EFC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20080929123515.26226.91402.stgit@ubuntu8041.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: Correct USB support for GE Fanuc SBC610
Date: Mon, 29 Sep 2008 09:25:59 -0500
References: <20080929123515.26226.91402.stgit@ubuntu8041.localdomain>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 29, 2008, at 7:35 AM, Martyn Welch wrote:

> Support for the SBC610 VPX Single Board Computer from GE Fanuc  
> (PowerPC
> MPC8641D).
>
> Fixup to correctly reconfigure USB, provided by an NEC uPD720101,  
> after
> device is reset. This requires a set of chip specific registers in the
> devices configuration space to be correctly written, enabling all  
> ports
> and switching the device to use an external 48-MHz Oscillator.
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>
> arch/powerpc/platforms/86xx/gef_sbc610.c |   17 +++++++++++++++++
> 1 files changed, 17 insertions(+), 0 deletions(-)

applied

- k
