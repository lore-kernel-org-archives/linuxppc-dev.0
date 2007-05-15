Return-Path: <sr@denx.de>
From: Stefan Roese <sr@denx.de>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Small fixes for the Ebony device tree
Date: Tue, 15 May 2007 08:46:09 +0200
References: <20070515020026.GG565@localhost.localdomain>
	<200705150811.09927.sr@denx.de>
	<20070515061855.GD6998@localhost.localdomain>
In-Reply-To: <20070515061855.GD6998@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705150846.09220.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 15 May 2007, David Gibson wrote:
> Anyone have any objection to the following:  each of these controllers
> should have compatible properties listing 3 string, first, a specific
> version for the CPU in question (e.g "ibm,sdram-440gp"), then a string
> based on the type as listed below, finally "ibm,sdram-4xx".
>
> > SDRAM:		all 40x (except for 405EZ)
>
> 	ibm,sdram-40x
>
> > DDR:		440GP, 440GX, 440EP, 440GR
>
> 	ibm,sdram-44x-ddr
>
> > DDR2:		440SP, 440SPe
>
> 	ibm,sdram-44x-ddr2
>
> > DDR2 (Denali):	440EPx, 440GRx
>
> 	ibm,sdram-44x-ddr2denali

Why "ibm,xxx"? Is this for the CPU core? Or for the SDRAM controller core? 
Both are not IBM in this case.

> Seem reasonable?

I forgot the new 405EX which will be equipped with a DDR2 controller (not sure 
right now if it's the Denali or the other core right now). So we should 
probably drop this 40x/44x completely. Does this make sense?

Best regards,
Stefan
