Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910711111607i35294d3ja43e1c616a3427bd@mail.gmail.com>
Date: Sun, 11 Nov 2007 19:07:23 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: pcspkr device, pnpPNP,100
In-Reply-To: <1194825784.18185.0.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711111535w6ffdfa97x4bed07eb84d4ab13@mail.gmail.com>
	<1194825784.18185.0.camel@pasglop>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/11/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> On Sun, 2007-11-11 at 18:35 -0500, Jon Smirl wrote:
> > Which platform does pcspkr device, pnpPNP,100 belong to, amiga? I'd
> > like to IFDEF add_pcspkr(void) in setup-common.c for the right
> > platform.
>
> #ifdef is evil. What about multiplatform kernels ? Just test for the
> presence of the device in the device-tree (use a platform driver maybe)

This code should be in a device driver so that it can be selected with
Kconfig. Can we #ifdef it now as a hint? I could make it a device
driver but I don't have any hardware to test it on.

I'm trying to get the mpc5200 kernel to build with platform bus turned
off (only of_platform bus). I'm almost there, just a couple more odd
places to patch up.


>
> Ben.
>
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
