Return-Path: <benh@kernel.crashing.org>
Subject: Re: Gianfar ethernet device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910711111622v5ad6fdd2jd30989819d05615d@mail.gmail.com>
References: <9e4733910711111511v36aa3504s3b55438698a4b4a8@mail.gmail.com>
	<9e4733910711111530g1f50d6e6hfaa76b4f051b5887@mail.gmail.com>
	<1194825876.18185.3.camel@pasglop>
	<9e4733910711111622v5ad6fdd2jd30989819d05615d@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 12 Nov 2007 12:08:00 +1100
Message-Id: <1194829680.18185.10.camel@pasglop>
Mime-Version: 1.0
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> The real solution is that gianfar support belongs in a device driver,
> not in a common file. That whole fsl_soc.c file is a catch-all of
> things that belong in device drivers. I haven't looked at every line
> in it, but 90%+ of the code should be moved into device drivers.
> 
> I'm preparing a patch that moves the i2c driver out of fsl_soc.c and
> into i2c_mpc.c.

The problem is how do you instanciate it. I'm working on some solution
for that but it's not there yet.

Ben.
