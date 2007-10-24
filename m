Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910710241231h9427223kbfcc23be2e111194@mail.gmail.com>
Date: Wed, 24 Oct 2007 15:31:09 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: Audio codec device tree entries
In-Reply-To: <471F7D28.6050107@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>
	<9e4733910710240800y24952e70g8c318e35e2e45e2e@mail.gmail.com>
	<fa686aa40710240816l6187b559l31fb72656ec265c@mail.gmail.com>
	<fa686aa40710240820l62d5a50ewcd7707fed8f9176f@mail.gmail.com>
	<9e4733910710240828x412f598dy7fc4a75faa76358d@mail.gmail.com>
	<fa686aa40710240843r5271c749m33bce043702603b7@mail.gmail.com>
	<9e4733910710240854y6ac115b6i5e0400eb369fcf7@mail.gmail.com>
	<fa686aa40710240938l5b8c30b9qe538cc641df5e61b@mail.gmail.com>
	<9e4733910710241001g165e7aeatdc92096544fbeb60@mail.gmail.com>
	<471F7D28.6050107@freescale.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/24/07, Timur Tabi <timur@freescale.com> wrote:
> Jon Smirl wrote:
>
> > Calling it directly from the platform code is an option, but where
> > does the fabric driver code live? It doesn't make a lot of sense to
> > put ALSA code into arch/powerpc/platforms/52xx. I could make a
> > function call from arch/powerpc/platforms/52xx over to
> > sound/soc/powerpc but that's not very pretty.
>
> sound/soc/fsl is where the non-codec ASoC drivers for Freescale parts should go.

Why are you using a vendor named directory? I don't believe vendor
named directories are used anywhere in the kernel. The directories are
always named after the platform or architecture. Vendor directories
end up in a big mess if Freescale decides to sell a CPU to someone
else.


>
> > The codec drivers in asoc are completely agnostic. The same codec
> > driver works on x86, arm, powerpc, etc.
>
> Well, in theory at least.  I never tried my cs4270 driver on anything but PowerPC.
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
