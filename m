Return-Path: <vitb@kernel.crashing.org>
Received: from vitb.dev.rtsoft.ru (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 69328DDE1A
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 02:18:40 +1000 (EST)
Date: Tue, 8 May 2007 20:18:01 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: "Loeliger Jon-LOELIGER" <jdl@freescale.com>
Subject: Re: [PATCH] [POWERPC] 8xx: PQ SoC IRDA support
Message-ID: <20070508201801.478f4999@vitb.ru.mvista.com>
In-Reply-To: <AF0367BA48C55940A43CCF08DF35553C012AA475@az33exm24.fsl.freescale.net>
References: <20070508052723.18404.8216.stgit@localhost.localdomain>
	<AF0367BA48C55940A43CCF08DF35553C012AA475@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Samuel Ortiz <samuel@sortiz.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 8 May 2007 07:36:48 -0700
"Loeliger Jon-LOELIGER" <jdl@freescale.com> wrote:

> > Adds support of IRDA transceiver residing on PowerQUICC processors and
> > enabling such on mpc885ads reference board. The driver is implemented 
> > using of_device concept, hereby implies arch/powerpc support 
> > of the target.
> > 
> > Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> 
> > diff --git a/arch/powerpc/boot/dts/mpc885ads.dts 
> > b/arch/powerpc/boot/dts/mpc885ads.dts
> > index 110bf61..95b280c 100644
> > --- a/arch/powerpc/boot/dts/mpc885ads.dts
> > +++ b/arch/powerpc/boot/dts/mpc885ads.dts
> > @@ -178,6 +178,16 @@
> >  				interrupt-parent = <930>;
> >  				phy-handle = <e8002>;
> >  			};
> > +
> > +			scc@a20 {
> > +				device_type = "network";
> > +				compatible = "fsl,irda";
> > +				model = "SCC";
> > +				device-id = <2>;
> > +				reg = <a20 18 3d00 80>;
> > +				interrupts = <1d 3>;
> > +				interrupt-parent = <930>;
> > +			};
> >  		};
> >  	};
> >  };
> 
> 
> Any chance we could get an update to the booting-without-of.txt
> for any of this?
> 
Yes of course. my note is that it makes sense once defines would settle down
stuff that looks OK in docs might not look such in driver...

-- 
Sincerely, 
Vitaly
