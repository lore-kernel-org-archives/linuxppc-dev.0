Return-Path: <timur@freescale.com>
Message-ID: <471F7D28.6050107@freescale.com>
Date: Wed, 24 Oct 2007 12:13:12 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Audio codec device tree entries
References: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>	
	<9e4733910710231529h1089eacdy888306f20af92555@mail.gmail.com>	
	<471F52ED.10007@freescale.com>	
	<9e4733910710240800y24952e70g8c318e35e2e45e2e@mail.gmail.com>	
	<fa686aa40710240816l6187b559l31fb72656ec265c@mail.gmail.com>	
	<fa686aa40710240820l62d5a50ewcd7707fed8f9176f@mail.gmail.com>	
	<9e4733910710240828x412f598dy7fc4a75faa76358d@mail.gmail.com>	
	<fa686aa40710240843r5271c749m33bce043702603b7@mail.gmail.com>	
	<9e4733910710240854y6ac115b6i5e0400eb369fcf7@mail.gmail.com>	
	<fa686aa40710240938l5b8c30b9qe538cc641df5e61b@mail.gmail.com>
	<9e4733910710241001g165e7aeatdc92096544fbeb60@mail.gmail.com>
In-Reply-To: <9e4733910710241001g165e7aeatdc92096544fbeb60@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:

> Calling it directly from the platform code is an option, but where
> does the fabric driver code live? It doesn't make a lot of sense to
> put ALSA code into arch/powerpc/platforms/52xx. I could make a
> function call from arch/powerpc/platforms/52xx over to
> sound/soc/powerpc but that's not very pretty.

sound/soc/fsl is where the non-codec ASoC drivers for Freescale parts should go.

> The codec drivers in asoc are completely agnostic. The same codec
> driver works on x86, arm, powerpc, etc.

Well, in theory at least.  I never tried my cs4270 driver on anything but PowerPC.
