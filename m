Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 2D832B7150
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Sep 2010 02:40:09 +1000 (EST)
Date: Wed, 1 Sep 2010 12:40:07 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: mtmsrd not defined
Message-ID: <20100901124007.343cf1e9@opus.seanm.ca>
In-Reply-To: <20100901080214.GA4722@brick.ozlabs.ibm.com>
References: <20100822180958.6305f5b1@lappy.seanm.ca>
	<1282516494.22370.440.camel@pasglop>
	<20100822184844.37c30d5e@lappy.seanm.ca>
	<D9007E15-F764-450D-9B20-6506F0051BA7@kernel.crashing.org>
	<20100831134605.1fca5fdf@lappy.seanm.ca>
	<20100831225525.1c9bd5a8@lappy.seanm.ca>
	<20100901080214.GA4722@brick.ozlabs.ibm.com>
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

On Wed, 1 Sep 2010 18:02:14 +1000
Paul Mackerras <paulus@samba.org> wrote:

> Ah, those references would be from arch/powerpc/lib/sstep.c.
> Evidently we need #ifdef CONFIG_PPC_FPU around the emulation of the
> floating-point loads and stores.

I tried that yesterday and it didn't help, although maybe I forgot to
mask out a few. I will check again.

Cheers,
   Sean
