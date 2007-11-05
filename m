Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.189])
	by ozlabs.org (Postfix) with ESMTP id 9270FDDE2B
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 07:11:01 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1411736rvf
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Nov 2007 12:10:59 -0800 (PST)
Message-ID: <9e4733910711051204g1efd2911sffbeef956b9e9f01@mail.gmail.com>
Date: Mon, 5 Nov 2007 15:04:02 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
In-Reply-To: <472F754C.1090202@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
	<472F6D5D.3030804@genesi-usa.com>
	<9e4733910711051151p18311586h133ac70917714466@mail.gmail.com>
	<472F754C.1090202@freescale.com>
Cc: Tjernlund <tjernlund@tjernlund.se>, Jean Delvare <khali@linux-fr.org>,
	i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/5/07, Scott Wood <scottwood@freescale.com> wrote:
> Jon Smirl wrote:
> > I can change it to remove fsl5200-clocking if someone can tell me if
> > this is only needed on the mpc5200b.
>
> Well, it appears to be needed on the mpc5200 (no 'b')...


What is the recommend way to check for a mpc5200 or mpc5200b?


>
> > This driver also supports the
> > MPC107/Tsi107/MPC8240/MPC8245 and           MPC85xx/MPC8641.
>
> You forgot mpc83xx. :-)
>
> > Do any of
> > these other chips need fsl5200-clocking?
>
> None of them have it set in arch/powerpc/boot/dts.
>
> -Scott
>


-- 
Jon Smirl
jonsmirl@gmail.com
