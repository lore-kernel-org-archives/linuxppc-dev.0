Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AA0D3DDEC8
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 11:58:54 +1000 (EST)
In-Reply-To: <20070506004737.31233.52611.stgit@localhost.localdomain>
References: <20070506004737.31233.52611.stgit@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <67c6bf6b7d37f5e133398ea83edeac78@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 8xx: mpc885ads pcmcia support
Date: Sun, 6 May 2007 03:04:14 +0200
To: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +		pcmcia@0080 {

> +			#interrupt-cells = <1>;

> +			interrupt-parent = <ff000000>;
> +			interrupts = <d 1>;
> +		};

Since this node's children's interrupt representation
is different from the node's parent's, you need an
interrupt-map in here.  You also forgot "#address-cells"
and I think you need "ranges" too?


Segher
