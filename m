Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 2337767A65
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 04:21:29 +1100 (EST)
In-Reply-To: <20050321163904.GT8345@smtp.west.cox.net>
References: <20050321163904.GT8345@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <4ae19fb229974e099a8472158be9482f@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 21 Mar 2005 11:21:28 -0600
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


On Mar 21, 2005, at 10:39 AM, Tom Rini wrote:

> On Fri, Mar 18, 2005 at 06:26:52PM -0600, Kumar Gala wrote:
>
> >
> > You asked me to look at doing the following.=A0 I just want to make=20=

> sure
> > this is what we want to do (and call it).=A0 I'm a little concerned=20=

> that
> > 'chip' is not necessary the right name in light of TSI10x and =
MV64x60
> > being described by ppc_sys in the future.
>
> "chip" or "chip(set)" or anything else is fine with me (I'm horrible =
at
>  names).=A0 But I don't like:
>
> > +#if defined (CONFIG_85xx) || defined (CONFIG_83xx)
> > +=A0=A0=A0=A0 if (cur_ppc_sys_spec->ppc_sys_name)
> > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 seq_printf(m, "chip\t\t: %s\n",=20=

> cur_ppc_sys_spec->ppc_sys_name);
> > +#endif
>
> ifdef'ing this.=A0 If the field is set, we should print it.

The only reason this is ifdef'd is that cur_ppc_sys_spec does not=20
always exist on all platforms built.

- kumar=
