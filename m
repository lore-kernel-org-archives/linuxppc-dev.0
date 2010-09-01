Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D4DD7B7159
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Sep 2010 16:45:55 +1000 (EST)
Subject: Re: [PATCH] powerpc: mtmsrd not defined
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100831225525.1c9bd5a8@lappy.seanm.ca>
Date: Wed, 1 Sep 2010 01:45:46 -0500
Message-Id: <9B0CD60E-F3E4-47FD-AE4D-3065E742E3A2@kernel.crashing.org>
References: <20100822180958.6305f5b1@lappy.seanm.ca>
	<1282516494.22370.440.camel@pasglop>
	<20100822184844.37c30d5e@lappy.seanm.ca>
	<D9007E15-F764-450D-9B20-6506F0051BA7@kernel.crashing.org>
	<20100831134605.1fca5fdf@lappy.seanm.ca>
	<20100831225525.1c9bd5a8@lappy.seanm.ca>
To: Sean MacLennan <smaclennan@pikatech.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 31, 2010, at 9:55 PM, Sean MacLennan wrote:

> On Tue, 31 Aug 2010 13:46:05 -0400
> Sean MacLennan <smaclennan@pikatech.com> wrote:
>=20
>> On Tue, 31 Aug 2010 11:17:17 -0500
>> Kumar Gala <galak@kernel.crashing.org> wrote:
>>=20
>>> Can we add proper CONFIG_PPC_FPU into this file. =20
>>=20
>> If nobody beats me to it.... I can try this evening.
>=20
> I had to give up. Without the CONFIG_PPC_FPU it compiles fine for an
> FPU less 44x. But with the CONFIG_PPC_FPU, I get the following errors:
>=20
> arch/powerpc/lib/built-in.o: In function `__copy_tofrom_user':
> arch/powerpc/lib/copy_32.S:(.kprobes.text+0xf8e): undefined reference =
to `do_lfs'
> arch/powerpc/lib/copy_32.S:(.kprobes.text+0xf96): undefined reference =
to `do_lfs'
> arch/powerpc/lib/copy_32.S:(.kprobes.text+0xfc2): undefined reference =
to `do_lfd'
> arch/powerpc/lib/copy_32.S:(.kprobes.text+0xfca): undefined reference =
to `do_lfd'
> arch/powerpc/lib/copy_32.S:(.kprobes.text+0xff6): undefined reference =
to `do_stfs'
> arch/powerpc/lib/copy_32.S:(.kprobes.text+0xffe): undefined reference =
to `do_stfs'
> arch/powerpc/lib/copy_32.S:(.kprobes.text+0x102a): undefined reference =
to `do_stfd'
> arch/powerpc/lib/copy_32.S:(.kprobes.text+0x1032): undefined reference =
to `do_stfd'
> make: *** [.tmp_vmlinux1] Error 1
>=20
>=20
> Oops, sorry, it will say arch/powerpc/lib/copy32.S... I corrected =
that.
> But I cannot find how copy_32.S is including those functions.
>=20
> Cheers,
>   Sean

For what defconfig setup do you get the errors above?

- k=
