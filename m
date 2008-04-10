Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9C4D1DE5C3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Apr 2008 00:46:44 +1000 (EST)
Message-Id: <B4CD3ECE-5F98-4A7B-A811-A84EADA804CF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Sebastian Siewior <bigeasy@tglx.de>
In-Reply-To: <20080314230130.GA6812@www.tglx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH v2] [POWER] mpc85xx_ds add DMA engine to the DT and parse
	it.
Date: Thu, 10 Apr 2008 09:46:39 -0500
References: <20080311103906.GD9656@www.tglx.de>
	<60A35F8F-FA66-4ADD-B192-6AC6A301DBA0@kernel.crashing.org>
	<20080314230130.GA6812@www.tglx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mar 14, 2008, at 6:01 PM, Sebastian Siewior wrote:
> This is a modified entry I found in the documentation for the 8544.
>
> Signed-off-by: Sebastian Siewior <bigeasy@linutronix.de>
> ---
> arch/powerpc/boot/dts/mpc8544ds.dts      |   41 +++++++++++++++++++++ 
> +++++++++
> arch/powerpc/platforms/85xx/mpc85xx_ds.c |   13 +++++++++
> 2 files changed, 54 insertions(+), 0 deletions(-)

applied.

I also added updating the defconfig to enable the driver by default.

- k
