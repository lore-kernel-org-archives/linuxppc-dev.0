Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id C7F7C67A46
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 05:32:08 +1100 (EST)
In-Reply-To: <20050321180548.GU8345@smtp.west.cox.net>
References: <20050321180548.GU8345@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <d4a949778fc5fa91525b2d936bae2c50@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 21 Mar 2005 12:32:06 -0600
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: Kumar Gala <galak@freescale.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC] ppc32: Report chip version in common /proc/cpuinfo
	handling
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mar 21, 2005, at 12:05 PM, Tom Rini wrote:

> On Mon, Mar 21, 2005 at 11:21:28AM -0600, Kumar Gala wrote:
>  >
> > On Mar 21, 2005, at 10:39 AM, Tom Rini wrote:
>  >
> > >On Fri, Mar 18, 2005 at 06:26:52PM -0600, Kumar Gala wrote:
>  > >
>  > >>
>  > >> You asked me to look at doing the following.? I just want to =
make
> > >sure
>  > >> this is what we want to do (and call it).? I'm a little =
concerned
> > >that
>  > >> 'chip' is not necessary the right name in light of TSI10x and=20
> MV64x60
>  > >> being described by ppc_sys in the future.
>  > >
>  > >"chip" or "chip(set)" or anything else is fine with me (I'm=20
> horrible at
>  > > names).? But I don't like:
> > >
>  > >> +#if defined (CONFIG_85xx) || defined (CONFIG_83xx)
> > >> +???? if (cur_ppc_sys_spec->ppc_sys_name)
> > >> +???? ??????? seq_printf(m, "chip\t\t: %s\n",
> > >cur_ppc_sys_spec->ppc_sys_name);
> > >> +#endif
>  > >
>  > >ifdef'ing this.? If the field is set, we should print it.
>  >
> > The only reason this is ifdef'd is that cur_ppc_sys_spec does not
> > always exist on all platforms built.
>
> Oh boy, I sense an <asm-ppc/serial.h> in the making.=A0 Please tell me
>  it's at least not possible that someone could stick an 85xx and an
>  MV64x60 together.=A0 So we want the enum there to do sanity checking,
>  right?

It is not possible that this could happen, in the sense that you are=20
using the MV64x60 as a chipset, not a PCI device or something bizarre.

- kumar=
