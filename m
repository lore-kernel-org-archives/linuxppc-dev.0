Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 73574B7144
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Sep 2010 16:58:02 +1000 (EST)
Date: Wed, 1 Sep 2010 02:57:58 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: mtmsrd not defined
Message-ID: <20100901025758.2dbada27@lappy.seanm.ca>
In-Reply-To: <9B0CD60E-F3E4-47FD-AE4D-3065E742E3A2@kernel.crashing.org>
References: <20100822180958.6305f5b1@lappy.seanm.ca>
	<1282516494.22370.440.camel@pasglop>
	<20100822184844.37c30d5e@lappy.seanm.ca>
	<D9007E15-F764-450D-9B20-6506F0051BA7@kernel.crashing.org>
	<20100831134605.1fca5fdf@lappy.seanm.ca>
	<20100831225525.1c9bd5a8@lappy.seanm.ca>
	<9B0CD60E-F3E4-47FD-AE4D-3065E742E3A2@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 1 Sep 2010 01:45:46 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> For what defconfig setup do you get the errors above?

44x/ebony_defconfig

Then enable KPROBES (or XMON).

Then put an #ifdef CONFIG_PPC_FPU in ldstfp.S.

Cheers,
   Sean
