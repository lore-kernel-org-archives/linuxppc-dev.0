Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C8299B75B6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 11:51:11 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1AC0EDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 11:51:10 +1000 (EST)
Message-Id: <577AF3AA-3CBA-4918-915F-F768640FD90F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20090519094057.11438.12921.stgit@ES-J7S4D2J>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] powerpc/86xx: Add I2C device mappings in DTS for SBC610
Date: Wed, 10 Jun 2009 20:50:59 -0500
References: <20090519094057.11438.12921.stgit@ES-J7S4D2J>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 19, 2009, at 4:40 AM, Martyn Welch wrote:

> Mappings for temperature sensors (adt7461 and lm92) are missing from  
> the
> SBC610's DTS file.
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>
> arch/powerpc/boot/dts/gef_sbc610.dts |   10 ++++++++++
> 1 files changed, 10 insertions(+), 0 deletions(-)


applied to next.

- k
