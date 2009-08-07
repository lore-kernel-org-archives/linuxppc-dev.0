Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CA29E100971
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 12:44:46 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 365FFDDD01
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 12:44:45 +1000 (EST)
Message-Id: <4DD0C59B-BE70-4133-AFEA-48A54E8067BA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20090630143238.10798.9863.stgit@ES-J7S4D2J.amer.consind.ge.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH] powerpc/86xx: Enable XMC site on GE Fanuc SBC310
Date: Thu, 6 Aug 2009 21:44:34 -0500
References: <20090630143238.10798.9863.stgit@ES-J7S4D2J.amer.consind.ge.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 30, 2009, at 9:32 AM, Martyn Welch wrote:

> This patch enables the XMC (PCIe daughter card) site on the SBC310.
> STG enter the description for the patch above.
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>
> arch/powerpc/boot/dts/gef_sbc310.dts |   37 +++++++++++++++++++++++++ 
> +++++++++
> 1 files changed, 37 insertions(+), 0 deletions(-)


applied to next.

- k
