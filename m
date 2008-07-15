Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F3CDCDDEF1
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 23:27:36 +1000 (EST)
Message-Id: <C477E1AE-12D7-4E32-918E-BD50011A646F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jochen Friedrich <jochen@scram.de>
In-Reply-To: <486F5B18.1030508@scram.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] powerpc: Add documentation for CPM GPIO banks
Date: Tue, 15 Jul 2008 08:27:11 -0500
References: <486F5B18.1030508@scram.de>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 5, 2008, at 6:29 AM, Jochen Friedrich wrote:

> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> ---
> Documentation/powerpc/device-tree/fsl/cpm/gpio.txt |   38 +++++++++++ 
> +++++++++
> 1 files changed, 38 insertions(+), 0 deletions(-)
> create mode 100644 Documentation/powerpc/device-tree/fsl/cpm/gpio.txt

applied.  Moved to new location dts-bindings/fsl/cpm_qe/gpio.txt

- k
