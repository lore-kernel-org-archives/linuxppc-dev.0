Return-Path: <benh@kernel.crashing.org>
Subject: Re: [MPC7448] machdep_calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?=
	<sebastien.chretien.enseirb@gmail.com>
In-Reply-To: <319b0ac50808180717ka6731fdu591798ac0d8b4e82@mail.gmail.com>
References: <319b0ac50808180145r44a1b64fhd09c038ce45bb206@mail.gmail.com>
	<1219051624.28339.39.camel@pasglop>
	<319b0ac50808180422r504a012djb971bf80e819a6d2@mail.gmail.com>
	<319b0ac50808180435o4a8e5bebr79f86e17ba2fb9af@mail.gmail.com>
	<1219062004.7946.5.camel@localhost>
	<319b0ac50808180717ka6731fdu591798ac0d8b4e82@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Tue, 19 Aug 2008 07:39:36 +1000
Message-Id: <1219095576.28339.74.camel@pasglop>
Mime-Version: 1.0
Cc: Linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-08-18 at 16:17 +0200, Sébastien Chrétien wrote:
> The mpc7448hpc2 uses a tsi108-bridge. My board uses an IP on a FPGA..
> I read the code of mpc7448_hpc2.c.
> It uses a ioremap in order to iniatilize the tsi108 registers. But I
> have already initialized MMU with my registers in HEAD_32.S. Do I need
> to use ioremap in setup_arch() ?

Why did you hack head_32.S ? You shouldn't do that... This is common
code, not platform code.

Ben.
> 
> 
> 
> 2008/8/18, Michael Ellerman <michael@ellerman.id.au>:
>         On Mon, 2008-08-18 at 13:35 +0200, Sébastien Chrétien wrote:
>         > Can somebody explain me the aim of the
>         function  "setup_arch" in the
>         > machine_call structure ?
>         
>         
>         Is this MPC7448 anything like an mpc7448hpc2 ?
>         
>         If so maybe you should start by looking at the code for it in:
>         
>         arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
>         
>         Even if it's not related, that will give you some idea of what
>         the
>         callbacks are for.
>         
>         cheers
>         
>         --
>         Michael Ellerman
>         OzLabs, IBM Australia Development Lab
>         
>         wwweb: http://michael.ellerman.id.au
>         phone: +61 2 6212 1183 (tie line 70 21183)
>         
>         We do not inherit the earth from our ancestors,
>         we borrow it from our children. - S.M.A.R.T Person
>         
> 
