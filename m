Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8BEFBDDDEE
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 02:46:30 +1100 (EST)
Message-Id: <09694720-0DE4-43EA-A4C9-D22376C41E41@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20081120085207.6545.48588.stgit@ubuntu8041>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: Add use of Epson RTX-8581 RTC to GE Fanuc SBC610
	dts
Date: Wed, 3 Dec 2008 09:46:22 -0600
References: <20081120085207.6545.48588.stgit@ubuntu8041>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 20, 2008, at 2:52 AM, Martyn Welch wrote:

> Adding use of newly added Epson RTX-8581 real-time clock driver to GE
> Fanuc SBC610's dts file and adding driver to default config.
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>
> arch/powerpc/boot/dts/gef_sbc610.dts           |    5 +++++
> arch/powerpc/configs/86xx/gef_sbc610_defconfig |    8 ++++++--
> 2 files changed, 11 insertions(+), 2 deletions(-)

applied to next

- k
