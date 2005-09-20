Return-Path: <glikely@gmail.com>
Received: from qproxy.gmail.com (qproxy.gmail.com [72.14.204.205])
	by ozlabs.org (Postfix) with ESMTP id 3E36D682A9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Sep 2005 06:35:22 +1000 (EST)
Received: by qproxy.gmail.com with SMTP id p35so51036qbb
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Sep 2005 13:35:20 -0700 (PDT)
Message-ID: <528646bc050920133519382674@mail.gmail.com>
Date: Tue, 20 Sep 2005 14:35:20 -0600
From: Grant Likely <glikely@gmail.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
In-Reply-To: <87vf0vselw.fsf@p4.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <528646bc05091000377417dc16@mail.gmail.com>
	<87vf0vselw.fsf@p4.48ers.dk>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 2/2] Add support for MEMEC 2VP30-FF1152 eval board with
	simple FPGA design
Reply-To: glikely@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/20/05, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> >>>>> "Grant" =3D=3D Grant Likely <glikely@gmail.com> writes:
>=20
> Hi,
>=20
>  Grant> Here is an example port to another V2PRO based board.  This
>  Grant> patch is for information only and is NOT suitable for
>  Grant> submission up to mainline
>=20
> Ok, I still have a little comment though..
>=20
>  Grant> diff --git a/arch/ppc/boot/simple/embed_config.c
>  Grant> b/arch/ppc/boot/simple/embed_config.c
>  Grant> --- a/arch/ppc/boot/simple/embed_config.c
>  Grant> +++ b/arch/ppc/boot/simple/embed_config.c
>  Grant> @@ -745,7 +745,7 @@ embed_config(bd_t **bdp)
>  Grant>  }
>  Grant>  #endif /* WILLOW */
>  Grant>
>  Grant> -#ifdef CONFIG_XILINX_ML300
>  Grant> +#ifdef CONFIG_VIRTEX_II_PRO
>  Grant>  void
>  Grant>  embed_config(bd_t ** bdp)
>  Grant>  {
>=20
> Please don't force all V2P boards to use the same embed_config. I'm
> using RedBoot on a V2P board, which provides a ready to go bd_t that I
> can directly use.
No problem.  I need to go back and review this code anyway to
determine if any of it should be split out into common routines for
all v2p boards.

Hey, do you have any drivers for the common 'stock' v2p device cores
ported to 2.6 for your board? (like Ethernet, PS/2, framebuffer, etc)
I'm about to start porting the SystemACE driver and I also need
Ethernet and PS/2 devices, but I don't want to duplicate if anyone has
already done the work.

Thanks again,
g.
