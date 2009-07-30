Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D3FD1B7E22
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jul 2009 14:32:59 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9542EDDD1B
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 14:32:58 +1000 (EST)
Message-Id: <B74A750C-D54D-4FB1-B726-D0152FC5AEFE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20090702141844.22370.87052.stgit@ES-J7S4D2J.amer.consind.ge.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] powerpc/86xx: Update GE Fanuc sbc310 default configuration
Date: Wed, 29 Jul 2009 23:32:47 -0500
References: <20090702141844.22370.87052.stgit@ES-J7S4D2J.amer.consind.ge.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 2, 2009, at 9:18 AM, Martyn Welch wrote:

> General update of defconfig including the following notable changes:
> - Enable Highmem support.
> - Support for PCMCIA based daughter card.
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>
> arch/powerpc/configs/86xx/gef_sbc310_defconfig |  213 +++++++++++++++ 
> ++-------
> 1 files changed, 154 insertions(+), 59 deletions(-)


applied to merge

- k
