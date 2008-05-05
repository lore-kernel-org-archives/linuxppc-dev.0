Return-Path: <rider4ever@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.228])
	by ozlabs.org (Postfix) with ESMTP id 7C055DDDFB
	for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2008 18:00:53 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id i30so60528wxd.15
	for <linuxppc-dev@ozlabs.org>; Mon, 05 May 2008 01:00:50 -0700 (PDT)
Message-ID: <ed84ed090805050100y4d33bf05vf6ab9b73ad0547c4@mail.gmail.com>
Date: Mon, 5 May 2008 10:00:50 +0200
From: "Fabrizio Garetto" <fabrizio.garetto@gmail.com>
Sender: rider4ever@gmail.com
To: linuxppc-dev@ozlabs.org
Subject: MPC52xx and SPI (native one, NOT psc)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello to everyone,
I was trying to enable the SPI of a lite5200 board. I've seen that
there's something related to this in
arch/powerpc/boot/dts/lite5200b.dts

>spi@f00 {
>			device_type = "spi";
>			compatible = "mpc5200b-spi\0mpc5200-spi";
>			reg = <f00 20>;
>			interrupts = <2 d 0 2 e 0>;
>			interrupt-parent = <&mpc5200_pic>;
>		};
>

but I'm not able to find where to enable it in menuconfig. Under
device drivers -> Spi support there only the PSC SPI.
Where am I wrong?

Thanks in advance,
Fabrizio Garetto
