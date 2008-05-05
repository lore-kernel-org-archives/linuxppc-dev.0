Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 23267DDED9
	for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2008 23:55:42 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so705708anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 05 May 2008 06:55:41 -0700 (PDT)
Message-ID: <fa686aa40805050655j20e617edy9d69f2c351705fd2@mail.gmail.com>
Date: Mon, 5 May 2008 07:55:40 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Fabrizio Garetto" <fabrizio.garetto@gmail.com>
Subject: Re: MPC52xx and SPI (native one, NOT psc)
In-Reply-To: <ed84ed090805050100y4d33bf05vf6ab9b73ad0547c4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <ed84ed090805050100y4d33bf05vf6ab9b73ad0547c4@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 5, 2008 at 2:00 AM, Fabrizio Garetto
<fabrizio.garetto@gmail.com> wrote:
> Hello to everyone,
>  I was trying to enable the SPI of a lite5200 board. I've seen that
>  there's something related to this in
>  arch/powerpc/boot/dts/lite5200b.dts
>
>  >spi@f00 {
>  >                       device_type = "spi";
>  >                       compatible = "mpc5200b-spi\0mpc5200-spi";
>  >                       reg = <f00 20>;
>  >                       interrupts = <2 d 0 2 e 0>;
>  >                       interrupt-parent = <&mpc5200_pic>;
>  >               };
>  >
>
>  but I'm not able to find where to enable it in menuconfig. Under
>  device drivers -> Spi support there only the PSC SPI.
>  Where am I wrong?

The device tree describes the hardware; even if there isn't a driver
for it.  The non-PSC SPI does not have a driver right now.

I'm actually working on a driver for it *right now*.  Are you able to
help with testing?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
