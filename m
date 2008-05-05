Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id 09C6ADDF49
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 00:03:26 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id n7so482001wag.13
	for <linuxppc-dev@ozlabs.org>; Mon, 05 May 2008 07:03:25 -0700 (PDT)
Message-ID: <9e4733910805050703p7aa58225q5b5438feadd66f22@mail.gmail.com>
Date: Mon, 5 May 2008 10:03:25 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: MPC52xx and SPI (native one, NOT psc)
In-Reply-To: <fa686aa40805050655j20e617edy9d69f2c351705fd2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <ed84ed090805050100y4d33bf05vf6ab9b73ad0547c4@mail.gmail.com>
	<fa686aa40805050655j20e617edy9d69f2c351705fd2@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Fabrizio Garetto <fabrizio.garetto@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 5/5/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Mon, May 5, 2008 at 2:00 AM, Fabrizio Garetto
>  <fabrizio.garetto@gmail.com> wrote:
>  > Hello to everyone,
>  >  I was trying to enable the SPI of a lite5200 board. I've seen that
>  >  there's something related to this in
>  >  arch/powerpc/boot/dts/lite5200b.dts
>  >
>  >  >spi@f00 {
>  >  >                       device_type = "spi";
>  >  >                       compatible = "mpc5200b-spi\0mpc5200-spi";
>  >  >                       reg = <f00 20>;
>  >  >                       interrupts = <2 d 0 2 e 0>;
>  >  >                       interrupt-parent = <&mpc5200_pic>;
>  >  >               };
>  >  >
>  >
>  >  but I'm not able to find where to enable it in menuconfig. Under
>  >  device drivers -> Spi support there only the PSC SPI.
>  >  Where am I wrong?
>
>
> The device tree describes the hardware; even if there isn't a driver
>  for it.  The non-PSC SPI does not have a driver right now.
>
>  I'm actually working on a driver for it *right now*.  Are you able to
>  help with testing?

Have you tired using an SD card with your new driver?

>
>  Cheers,
>  g.
>
>
>  --
>  Grant Likely, B.Sc., P.Eng.
>  Secret Lab Technologies Ltd.
>
> _______________________________________________
>  Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Jon Smirl
jonsmirl@gmail.com
