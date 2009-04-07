Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 90920DE0A0
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 16:19:02 +1000 (EST)
Message-Id: <7756C9F7-1F72-4C3D-AF01-D46DE0DC06BC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <49BE146D.5050604@grandegger.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 2/3] PowerPC: MPC85xx: TQM8548: use proper phy-handles for
	enet2 and enet3
Date: Tue, 7 Apr 2009 01:18:54 -0500
References: <49BE146D.5050604@grandegger.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 16, 2009, at 3:57 AM, Wolfgang Grandegger wrote:

> For enet2 and enet3 the wrong phy-handles have been used in DTS files
> of the TQM8548 modules.
>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
> arch/powerpc/boot/dts/tqm8548-bigflash.dts |    4 ++--
> arch/powerpc/boot/dts/tqm8548.dts          |    4 ++--
> 2 files changed, 4 insertions(+), 4 deletions(-)

fixup & applied

- k
