Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 75AFBDDEE1
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 03:56:33 +1100 (EST)
Message-Id: <CE39F0FA-ADBE-4BDB-8FCA-E0CFA3693153@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20090227155310.7771.96519.stgit@ubuntu8041.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc/86xx: Correct local bus registers in GE Fanuc
	SBC610 dts file
Date: Mon, 9 Mar 2009 11:56:21 -0500
References: <20090227155310.7771.96519.stgit@ubuntu8041.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 27, 2009, at 9:53 AM, Martyn Welch wrote:

> The registers for the local bus are incorrectly set to 0xf8005000  
> rather
> than there actual location of 0xfef05000.
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>
> arch/powerpc/boot/dts/gef_sbc610.dts |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied to next

- k
