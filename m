Return-Path: <jhautbois@gmail.com>
Received: from mail-ew0-f165.google.com (mail-ew0-f165.google.com
	[209.85.219.165]) by ozlabs.org (Postfix) with ESMTP id 5D74FDE0A6
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 01:28:22 +1100 (EST)
Received: by ewy9 with SMTP id 9so2846317ewy.9
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 07:28:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200903131500.51446.laurentp@cse-semaphore.com>
References: <8cad0aa0903130638w6fab6299kcd23d92d4c2d0a8@mail.gmail.com>
	<200903131500.51446.laurentp@cse-semaphore.com>
Date: Fri, 13 Mar 2009 15:20:24 +0100
Message-ID: <8cad0aa0903130720r25e8b7c1u3f762d9560535f5e@mail.gmail.com>
Subject: Re: [MPC8272ADS]Can not configure the ttyCPM0
From: Jean-Michel Hautbois <jhautbois@gmail.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2009/3/13 Laurent Pinchart <laurentp@cse-semaphore.com>:
> Hi Jean-Michel,
>
> Support for the modem control lines has been added in v2.6.27-rc2. You will
> need to declare the modem control lines in your device tree. See
> Documentation/powerpc/dts-bindings/fsl/cpm_qe/serial.txt for more information.
>
> Please note that hardware flow control is not supported by the CPM UART driver
> yet.
>

OK, this is not easy, to modify...
My DTS already contains a configuration for the CPM1 port...

			serial@11a00 {
				device_type = "serial";
				compatible = "fsl,mpc8272-scc-uart",
				             "fsl,cpm2-scc-uart";
				reg = <0x11a00 0x20 0x8000 0x100>;
				interrupts = <40 8>;
				interrupt-parent = <&PIC>;
				fsl,cpm-brg = <1>;
				fsl,cpm-command = <0x800000>;
			};

			serial@11a60 {
				device_type = "serial";
				compatible = "fsl,mpc8272-scc-uart",
				             "fsl,cpm2-scc-uart";
				reg = <0x11a60 0x20 0x8300 0x100>;
				interrupts = <43 8>;
				interrupt-parent = <&PIC>;
				fsl,cpm-brg = <4>;
				fsl,cpm-command = <0xce0000>;
			};

I can't see what I have to do...
This is not obvious ;).

JM
