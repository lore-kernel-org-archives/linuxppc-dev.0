Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CA031DF081
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 09:21:24 +1000 (EST)
Message-Id: <0971B3DF-03D9-46F9-8F58-97E2F87B0E7A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <c3840b6d7622db88a748213c806c6cfe4bf404ef.1208296521.git.paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 2/3] powerpc: Add device tree source for Wind River
	SBC8641D
Date: Tue, 15 Apr 2008 18:21:20 -0500
References: <1208299292-21937-1-git-send-email-paul.gortmaker@windriver.com>
	<96011ba20ab9319aa866c12e2ff91ad579d26aed.1208296521.git.paul.gortmaker@windriver.com>
	<c3840b6d7622db88a748213c806c6cfe4bf404ef.1208296521.git.paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 15, 2008, at 5:41 PM, Paul Gortmaker wrote:
> This adds in the device tree source for the SBC8641D, based
> largely on the mpc8641_hpcn.dts.  The biggest differences are
> the lack of a complex IRQ mapping (since no Uli/i8259 cascade)
> and the different layout of devices on the localbus node.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> arch/powerpc/boot/dts/sbc8641d.dts |  352 +++++++++++++++++++++++++++ 
> +++++++++
> 1 files changed, 352 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/sbc8641d.dts

applied.

- k
