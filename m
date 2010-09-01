Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B10C7B714E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Sep 2010 23:01:36 +1000 (EST)
Subject: Re: [PATCH] powerpc: mtmsrd not defined
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100901080214.GA4722@brick.ozlabs.ibm.com>
Date: Wed, 1 Sep 2010 08:01:29 -0500
Message-Id: <04187CA6-D0DE-45B3-819F-DE26BFD9FF16@kernel.crashing.org>
References: <20100822180958.6305f5b1@lappy.seanm.ca>
	<1282516494.22370.440.camel@pasglop>
	<20100822184844.37c30d5e@lappy.seanm.ca>
	<D9007E15-F764-450D-9B20-6506F0051BA7@kernel.crashing.org>
	<20100831134605.1fca5fdf@lappy.seanm.ca>
	<20100831225525.1c9bd5a8@lappy.seanm.ca>
	<20100901080214.GA4722@brick.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 1, 2010, at 3:02 AM, Paul Mackerras wrote:

> On Tue, Aug 31, 2010 at 10:55:25PM -0400, Sean MacLennan wrote:
>=20
>> I had to give up. Without the CONFIG_PPC_FPU it compiles fine for an
>> FPU less 44x. But with the CONFIG_PPC_FPU, I get the following =
errors:
>=20
> Ah, those references would be from arch/powerpc/lib/sstep.c.  =
Evidently
> we need #ifdef CONFIG_PPC_FPU around the emulation of the =
floating-point
> loads and stores.
>=20
> Do we do any in-kernel emulation of floating-point operations with
> CONFIG_PPC_FPU turned off?

I'm not aware of any.  I haven't looked at the Program Check exception =
path to know if we'd handle emulation gracefully or not for =
!CONFIG_PPC_FPU.

- k=
