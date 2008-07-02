Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D9CCADF1B8
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 02:14:12 +1000 (EST)
Message-Id: <3B499DF6-86A2-4CBE-8C61-D8745A885BA6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jochen Friedrich <jochen@scram.de>
In-Reply-To: <486BA775.8080703@scram.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] powerpc: Add i2c pins to dts and board setup
Date: Wed, 2 Jul 2008 11:14:04 -0500
References: <486BA775.8080703@scram.de>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 2, 2008, at 11:06 AM, Jochen Friedrich wrote:

> Initialize I2C pins on boards with CPM1/CPM2 controllers
> and document the i2c bus in booting-without-of.
>
> The boards don't have any I2C chips connected to the I2C
> bus, so unless some external chips are connected to the
> boards, this code is just an example of setting everything
> else up.
>
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> ---
> Documentation/powerpc/booting-without-of.txt |   42 +++++++++++++++++ 
> +++++++++
> arch/powerpc/boot/dts/mpc8272ads.dts         |   11 +++++++
> arch/powerpc/boot/dts/mpc866ads.dts          |   11 +++++++
> arch/powerpc/boot/dts/mpc885ads.dts          |   11 +++++++
> arch/powerpc/platforms/82xx/mpc8272_ads.c    |    4 ++
> arch/powerpc/platforms/8xx/mpc86xads_setup.c |    4 ++
> arch/powerpc/platforms/8xx/mpc885ads_setup.c |    3 ++
> 7 files changed, 86 insertions(+), 0 deletions(-)

applied.

- k
