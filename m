Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C639FB72AE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 17:45:53 +1000 (EST)
Message-Id: <292C3A97-D618-460C-BE3F-B8770F63C2E3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Rini van Zetten <rini@arvoo.nl>
In-Reply-To: <4A3B3D90.5030100@arvoo.nl>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH -mm v3][POWERPC] mpc8xxx : allow SPI without cs.
Date: Fri, 19 Jun 2009 02:45:35 -0500
References: <4A39DC80.7030906@arvoo.nl>	<20090618130955.GA1369@oksana.dev.rtsoft.ru>
	<EEB9B7B7-5456-4AE9-8BB9-96DA04320697@kernel.crashing.org>
	<4A3B3D90.5030100@arvoo.nl>
Cc: spi-devel-general@lists.sourceforge.net,
	linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 19, 2009, at 2:26 AM, Rini van Zetten wrote:

> This patch adds the possibility to have a spi device without a cs.
>
> For example, the dts file should look something like this:
>
> spi-controller {
>       gpios = <&pio1 1 0      /* cs0 */
>                0              /* cs1, no GPIO */
>                &pio2 2 0>;    /* cs2 */
>
> Signed-off-by: Rini van Zetten <rini@arvoo.nl>
> ---
> Changes :
> 	patch against 2.6.30-rc8-mm1
> 	style updates
> 	compiler warning fix
> comment :
> 	This feature is needed on our home made board to program an onboard  
> fpga.
> 	The fpga needs some special pin toggling to put it in programming  
> mode.
> 	That's why we want to skip the usual gpio cs and do the pin toggling
> 	in our driver
> 	

Which FSL chip are you using?

- k
