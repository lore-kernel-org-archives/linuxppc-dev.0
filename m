Return-Path: <jjo.braun@gmail.com>
Received: from mail-ie0-f174.google.com (mail-ie0-f174.google.com
 [209.85.223.174])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5F9332C0080
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2013 00:25:22 +1100 (EST)
Received: by mail-ie0-f174.google.com with SMTP id c11so17863982ieb.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Jan 2013 05:25:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CADwvPCve5GaRZZXuLUq4Es2FLN8AxtbRP4TQP7gQVRXoMw3S0g@mail.gmail.com>
References: <CADwvPCve5GaRZZXuLUq4Es2FLN8AxtbRP4TQP7gQVRXoMw3S0g@mail.gmail.com>
Date: Thu, 3 Jan 2013 14:25:19 +0100
Message-ID: <CADwvPCuFJprOm5Vovx5W+2=iYb_YPYLpvy7+hG8nUzwGfJtNzA@mail.gmail.com>
Subject: Re: tqm5200s i2c bus timeout
From: Johannes Braun <jjo.braun@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> The dtb file from the kernel 2.6.23 looks as follows:
> i2c@3d40 {
>
> #address-cells = <1>;
>      #size-cells = <0>;
>      compatible = "fsl,mpc5200-i2c","fsl-i2c";
>      reg = <0x3d40 0x40>;
>      interrupts = <2 16 0>;
>      fsl5200-clocking;
> };

sry, but this was a mistake. This is the correct section from the kernel 2.6.23:

i2c@3d40 {
    device_type = "i2c";
    compatible = "mpc5200-i2c\0fsl-i2c";
    cell-index= <1>;
    reg = <3d40 40>;
    interrupts = <2 10 0>;
    interrupt-parent = <&mpc5200_pic>;
    fsl5200-clocking;
};
