Return-Path: <dgibson@ozlabs.org>
Date: Fri, 19 Oct 2007 13:49:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Bai Shuwei <baishuwei@gmail.com>
Subject: Re: powerpc 440 monitor program
Message-ID: <20071019034904.GA4407@localhost.localdomain>
References: <f3566d60710182032h69e2d2bejafd96f18dae95829@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f3566d60710182032h69e2d2bejafd96f18dae95829@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 19, 2007 at 11:32:33AM +0800, Bai Shuwei wrote:
> all,
>     hi, when I boot my system, there are no output on the screen.
> I choice the framebuffer and my monitor card is ATI PAGE 128 PCI, qt/e GUI.
> When i compile the kernel, the boot logo and aty 128fb has be compiled into
> kernel patched with videoboot, and x86emu. The video parameters set:
>      video=aty128fb:640x480-16@7.
>     The kenel can recognize the monitor card, and the frame buffer device
> has run.
> The output showed below:
> 
>     videoboot: Booting PCI video card bus 0, function 0, device 6
>    aty128fb: Found Intel x86 BIOS ROM Image
>    aty128fb: Rage128 BIOS located
>    aty128fb: Rage128 RK PCI [chip rev 0x2] 32M 64-bit SDR SGRAM (2:1)
>    fb0: ATY Rage128 frame buffer device on Rage128 RK PCI
> 
> My problem is there is no output on the monitor,and cannot see the penguin
> boot logo.

Uh.. most 440 systems use a serial console.  It ought in theory to be
possible to use a framebuffer instead, but it wouldn't surprise me if
rather a lot of debugging was necessary.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
