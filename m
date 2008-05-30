Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 071CEDE560
	for <linuxppc-dev@ozlabs.org>; Sat, 31 May 2008 01:51:42 +1000 (EST)
Message-Id: <7FCA1148-CA67-418C-A9F8-7A5C0563F73E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1210889097-32368-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] Add warning for unrecognized I2C nodes in the device tree
Date: Fri, 30 May 2008 10:51:01 -0500
References: <1210889097-32368-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 15, 2008, at 5:04 PM, Timur Tabi wrote:

> Update of_find_i2c_driver in fsl_soc.c to display a warning message  
> if an
> I2C node in the device tree isn't found in the i2c_devices[] array.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_soc.c |    4 ++++
> 1 files changed, 4 insertions(+), 0 deletions(-)

applied.

- k
