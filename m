Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B42B367B71
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Sep 2006 21:57:13 +1000 (EST)
Received: from vitb.ru.mvista.com ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id k8BBvBi05205
	for <linuxppc-embedded@ozlabs.org>; Mon, 11 Sep 2006 16:57:11 +0500
Date: Mon, 11 Sep 2006 15:57:28 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: I2C on MPC8272...
Message-ID: <20060911155728.7c1c441a@vitb.ru.mvista.com>
In-Reply-To: <BE8B3EECA608414FB163FBA4576FCEBD432009@EXNY.us.corp.aacisd.com>
References: <BE8B3EECA608414FB163FBA4576FCEBD432009@EXNY.us.corp.aacisd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 8 Sep 2006 13:00:58 -0400
"Kuffner Cory" <CKuffner@LIO.AACISD.com> wrote:

> Hello all,
>  
> Does anyone know how to use the I2C module for the MPC8272??  We are attempting to enable it by following code written for a bareboard system and converting it into a kernel module (2.6.11 Kernel), but nothing happens on our SDA and SCL data lines.  The parameter ram is kind of tricky to set up, but I beleive we have everything pointing where it should.  To write to the IMM we are using the ioremap function with ioread and iowrite, we can write to the ports so I don't think there is an issue writing to memory, but I'm new to embedded linux.  Has anyone ever used the I2C controller in one of freescale's chips or just a good understanding of I2C modules in embedded linux??  I think all the chips have the same I2C interface....so it should be the same set up for MPC8250, 8255, 8260, etc.
>  

I am recalling i2c functional on 8272, but no other details unfortunately. IIRC, i2c-mpc.c did the magic with some minor intervention.

Barely, to access immr it is ioremapped early, and cpm2_immr-> holds i2c controller, pram and other pleasant stuff. And, I am recalling i2c on 8540 working fine right out of the box...

-- 
Sincerely, 
Vitaly
