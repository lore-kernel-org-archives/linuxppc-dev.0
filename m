Return-Path: <acrux_it@libero.it>
Received: from outrelay08.libero.it (outrelay08.libero.it [212.52.84.112])
 by ozlabs.org (Postfix) with ESMTP id 470DC104792
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Feb 2012 13:01:31 +1100 (EST)
Date: Sat, 4 Feb 2012 03:02:07 +0100
From: acrux <acrux_it@libero.it>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: Efika (mpc5200b): sound doesn't build/work from linux-2.6.38.x
Message-Id: <20120204030207.0d5cec19.acrux_it@libero.it>
In-Reply-To: <CAOZdJXU+kiQgsM9F3JVG3o8LV4oejSA1D85bFX+ZsqB7f9j_Ew@mail.gmail.com>
References: <20120202034803.2fb7690b.acrux_it@libero.it>
 <20120202175751.2c6e4bb9.acrux_it@libero.it>
 <CAOZdJXU+kiQgsM9F3JVG3o8LV4oejSA1D85bFX+ZsqB7f9j_Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2 Feb 2012 21:50:02 +0000
Tabi Timur-B04825 <B04825@freescale.com> wrote:

> On Thu, Feb 2, 2012 at 10:57 AM, acrux <acrux_it@libero.it> wrote:
> 
> 
> > well, i got the same error with also linux-2.6.37. Btw, this was already reported about a year ago:
> > http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-February/088415.html
> 
> I think this was fixed already.  You're using an obsolete kernel.
> 

hi Timur,
as i said [1] it seems to be fixed only in 3.x instead the last working one is the obsolete 2.6.36.x .
Anyway, alog the sound/soc/fsl/mpc5200_dma.c now builds the sound is still broken.

best,
--nico



[1]

On Thu, 2 Feb 2012 03:48:03 +0100
acrux <acrux_it@libero.it> wrote:

__omissis_
> 
> With linux-3.0.18, linux-3.1.10 and linux-3.2.2 it builds but doesn't work.
> That's from my dmesg:
> 
> [...]
> asoc: error - multiple DAI f0002200.sound registered with no name
> mpc5200-psc-ac97 f0002200.sound: Failed to register DAI
> mpc5200-psc-ac97: probe of f0002200.sound failed with error -22
> 


acrux <acrux@cruxppc.org>
